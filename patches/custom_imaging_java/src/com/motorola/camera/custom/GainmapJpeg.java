// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;

/** Copies only EXIF from a metadata rewrite, preserving the encoded JPEG/R payload. */
final class GainmapJpeg {
    private static final byte[] EXIF = "Exif\0\0".getBytes(StandardCharsets.US_ASCII);
    private static final byte[] MPF = "MPF\0".getBytes(StandardCharsets.US_ASCII);

    private GainmapJpeg() {}

    static byte[] withExif(byte[] nativeJpeg, byte[] metadataJpeg) throws IOException {
        int exif = find(metadataJpeg, 0xe1, EXIF);
        if (exif < 0) throw new IOException("Missing rewritten EXIF");
        int mpf = find(nativeJpeg, 0xe2, MPF);
        if (mpf < 0) throw new IOException("Unexpected native JPEG/R headers");

        int existingExif = find(nativeJpeg, 0xe1, EXIF);
        int newExifLen = segmentSize(metadataJpeg, exif);
        int replaceAt = existingExif >= 0 ? existingExif : 2;
        int oldExifLen = existingExif >= 0 ? segmentSize(nativeJpeg, existingExif) : 0;
        int delta = newExifLen - oldExifLen;
        byte[] result = new byte[Math.addExact(nativeJpeg.length, delta)];
        System.arraycopy(nativeJpeg, 0, result, 0, replaceAt);
        System.arraycopy(metadataJpeg, exif, result, replaceAt, newExifLen);
        int tailSrc = replaceAt + oldExifLen;
        System.arraycopy(nativeJpeg, tailSrc, result, replaceAt + newExifLen,
                nativeJpeg.length - tailSrc);

        // When inserting at offset 2 or replacing an EXIF before MPF, MPF shifts by delta.
        int mpfShift = (existingExif < 0 || existingExif < mpf) ? delta : 0;
        int tiff = mpf + 8 + mpfShift;
        int length = segmentSize(nativeJpeg, mpf) - 8;
        if (length < 8) throw new IOException("Truncated MPF");
        ByteBuffer index = ByteBuffer.wrap(result, tiff, length).slice();
        int order = index.getShort(0) & 0xffff;
        if (order == 0x4949) index.order(ByteOrder.LITTLE_ENDIAN);
        else if (order != 0x4d4d) throw new IOException("Invalid MPF byte order");
        if (index.getShort(2) != 42) throw new IOException("Invalid MPF TIFF header");
        int ifd = index.getInt(4);
        if (ifd < 8 || ifd > length - 2) throw new IOException("Invalid MPF directory");
        int tags = index.getShort(ifd) & 0xffff;
        for (int i = 0; i < tags; i++) {
            int entry = ifd + 2 + i * 12;
            if (entry > length - 12) throw new IOException("Truncated MPF directory");
            if ((index.getShort(entry) & 0xffff) != 0xb002) continue;
            int entries = index.getInt(entry + 8);
            if (index.getShort(entry + 2) != 7 || index.getInt(entry + 4) < 32
                    || entries < 0 || entries > length - 32) {
                throw new IOException("Invalid MP entries");
            }
            int primarySize = index.getInt(entries + 4);
            int secondarySize = index.getInt(entries + 20);
            int secondaryOffset = index.getInt(entries + 24);
            long secondaryStartLong = (long) mpf + 8 + secondaryOffset;
            if (secondaryOffset <= 0 || secondaryStartLong > nativeJpeg.length - 4) {
                throw new IOException("Invalid JPEG/R image boundaries");
            }
            int secondaryStart = (int) secondaryStartLong;
            if (primarySize < mpf + 8 + length + 2 || primarySize > secondaryStart
                    || secondaryStart < mpf + 8 + length + 2
                    || secondarySize < 4 || secondarySize > nativeJpeg.length - secondaryStart
                    || !hasMarker(nativeJpeg, primarySize - 2, 0xd9)
                    || !hasMarker(nativeJpeg, secondaryStart, 0xd8)
                    || !hasMarker(nativeJpeg, secondaryStart + secondarySize - 2, 0xd9)) {
                throw new IOException("Invalid JPEG/R image boundaries");
            }
            index.putInt(entries + 4, Math.addExact(primarySize, delta));
            if (mpfShift == 0 && replaceAt > mpf && replaceAt < secondaryStart) {
                index.putInt(entries + 24, Math.addExact(secondaryOffset, delta));
            }
            return result;
        }
        throw new IOException("Missing MP entries");
    }

    private static boolean hasMarker(byte[] jpeg, int at, int marker) {
        return (jpeg[at] & 255) == 255 && (jpeg[at + 1] & 255) == marker;
    }

    private static int segmentSize(byte[] jpeg, int at) {
        return 2 + ((jpeg[at + 2] & 255) << 8) + (jpeg[at + 3] & 255);
    }

    private static int find(byte[] jpeg, int marker, byte[] signature) throws IOException {
        if (jpeg.length < 4 || (jpeg[0] & 255) != 255 || (jpeg[1] & 255) != 216) {
            throw new IOException("Missing JPEG SOI");
        }
        for (int at = 2; at <= jpeg.length - 2; ) {
            if ((jpeg[at] & 255) != 255) throw new IOException("Invalid JPEG marker");
            int type = jpeg[at + 1] & 255;
            if (type == 218 || type == 217) break;
            if (type == 255) { at++; continue; }
            if (at > jpeg.length - 4) throw new IOException("Truncated JPEG marker");
            int size = segmentSize(jpeg, at);
            if (size < 4 || size > jpeg.length - at) throw new IOException("Invalid JPEG segment");
            if (type == marker && size >= 4 + signature.length) {
                int match = 0;
                while (match < signature.length && jpeg[at + 4 + match] == signature[match]) match++;
                if (match == signature.length) return at;
            }
            at += size;
        }
        return -1;
    }
}
