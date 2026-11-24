// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

import android.opengl.EGL14;
import android.opengl.GLES31;
import java.nio.Buffer;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;

/** App-owned burst of one physical imager, pixel mode and crop. Coordinates refer to native mosaic pixels. */
public final class MultiFrameRawEngine {
    public static final int MODE_HDR_PLUS = 1, MODE_RAW_AEB = 2, MODE_SUPER_RES = 3,
            MODE_FOCUS_STACK = 4, MODE_SYNTHETIC_ND = 5;
    private static final int TILE = 16, SEARCH = 3; // search in 2x2 superpixels
    private static final long MIB = 1024L * 1024;
    private static final double BLUR_LIMIT = 0.75;
    private final int mode;
    private final Frame[] ring;
    private int oldest, size;

    /** The caller owns raw until addFrame returns. The ring stores its own unsigned 16-bit copy. */
    public static final class FrameInput {
        public final int[] raw;
        public final int width, height, cfaPattern, iso;
        public final float[] blackLevel4;
        public final float whiteLevel, gyroExcursionRad, focalLengthPx;
        public final long timestampNs, exposureNs;

        public FrameInput(int[] raw, int width, int height, int cfaPattern, float[] blackLevel4,
                          float whiteLevel, long timestampNs, long exposureNs, int iso,
                          float gyroExcursionRad, float focalLengthPx) {
            this.raw = raw;
            this.width = width;
            this.height = height;
            this.cfaPattern = cfaPattern;
            this.blackLevel4 = blackLevel4;
            this.whiteLevel = whiteLevel;
            this.timestampNs = timestampNs;
            this.exposureNs = exposureNs;
            this.iso = iso;
            this.gyroExcursionRad = gyroExcursionRad;
            this.focalLengthPx = focalLengthPx;
        }
    }

    /** Pass raw, width, height, cfaPattern, blackLevel4 and whiteLevel together to processRawToArgb.
     * AEB headroom is the maximum representable radiance relative to anchor saturation. */
    public static final class Result {
        public final int[] raw;
        public final int width, height, cfaPattern, acceptedFrames;
        public final float[] blackLevel4;
        public final float whiteLevel;
        public final long anchorTimestampNs;
        public final double headroom;
        public final boolean superResolved, usedGlGuide;

        private Result(int[] raw, int width, int height, Frame anchor, int accepted, double headroom,
                       float white, boolean sr, boolean gpu) {
            this.raw = raw;
            this.width = width;
            this.height = height;
            this.cfaPattern = anchor.cfa;
            this.blackLevel4 = anchor.black.clone();
            this.whiteLevel = white;
            this.anchorTimestampNs = anchor.time;
            this.acceptedFrames = accepted;
            this.headroom = headroom;
            this.superResolved = sr;
            this.usedGlGuide = gpu;
        }
    }

    private static final class Frame {
        final int w, h, cfa;
        final long time;
        final double exposureGain, blur;
        final float white;
        final float[] black, inv = new float[4];
        final short[] data;

        Frame(FrameInput f) {
            w = f.width;
            h = f.height;
            time = f.timestampNs;
            cfa = f.cfaPattern;
            white = f.whiteLevel;
            exposureGain = (double) f.exposureNs * f.iso;
            blur = f.focalLengthPx > 0 && Float.isFinite(f.gyroExcursionRad)
                    ? f.focalLengthPx * f.gyroExcursionRad : Double.NaN;
            black = f.blackLevel4.clone();
            for (int p = 0; p < 4; p++) inv[p] = 1f / (white - black[p]);
            data = new short[w*h];
            for (int i = 0; i < data.length; i++) {
                int dn = f.raw[i];
                if ((dn & ~65535) != 0) throw new IllegalArgumentException("RAW sample outside unsigned 16-bit range");
                data[i] = (short)dn;
            }
        }

        double linear(int x, int y, int phase) {
            return ((data[y*w+x] & 65535) - black[phase]) * inv[phase];
        }
    }

    public MultiFrameRawEngine(int mode, int maxFrames) {
        checkConfig(mode, maxFrames);
        this.mode = mode;
        ring = new Frame[maxFrames];
    }

    private static void checkConfig(int mode, int count) {
        if (mode < MODE_HDR_PLUS || mode > MODE_SYNTHETIC_ND || count < 1 || count > 8)
            throw new IllegalArgumentException("Invalid mode or frame count");
    }

    private static void dimensions(int w, int h) {
        if (w < 4 || h < 2 || (h & 1) != 0 || (long)w*h > Integer.MAX_VALUE-8)
            throw new IllegalArgumentException("Invalid Bayer dimensions");
    }

    private static int outputDimension(int n, int multiple) {
        return Math.toIntExact(Math.max(multiple, (3L*n/2/multiple)*multiple));
    }

    /** Admission estimate includes ring, incoming int plane and possible eviction overlap, or
     * output, two alignment guides, tile maps and a bounded GL staging allowance, whichever is larger.
     * Callers budget their other retained inputs, earlier results and downstream demosaic separately. */
    public static long estimatedPeakBytes(int mode, int w, int h, int count) {
        checkConfig(mode, count);
        dimensions(w, h);
        long n = (long)w*h;
        long out = mode == MODE_SUPER_RES ? (long)outputDimension(w,4)*outputDimension(h,2) : n;
        if (out > Integer.MAX_VALUE-8) throw new IllegalArgumentException("Output too large");
        long tiles = ((w+15L)/16)*((h+15L)/16);
        long packed = 2*n*count;
        long ingest = packed + 6*n;
        long merge = packed + 4*out + 2*n + tiles*(12L*count+8);
        return Math.max(ingest, merge) + MIB;
    }

    public synchronized void addFrame(FrameInput f) {
        if (f == null || f.raw == null) throw new IllegalArgumentException("Missing input");
        int count = Math.min(size+1, ring.length);
        long bytes = estimatedPeakBytes(mode, f.width, f.height, count);
        long pixels = (long)f.width*f.height;
        long cap = (mode == MODE_SUPER_RES ? 420L : 320L)*MIB;
        if (bytes > cap || (2L*size + 2)*pixels + 4L*f.raw.length + MIB > cap)
            throw new IllegalArgumentException("Burst exceeds working memory cap");
        if (f.raw.length < pixels || f.blackLevel4 == null || f.blackLevel4.length != 4
                || f.cfaPattern < CleanBayerRawProcessor.CFA_RGGB || f.cfaPattern > CleanBayerRawProcessor.CFA_BGGR
                || !Float.isFinite(f.whiteLevel) || f.whiteLevel > 65535 || f.timestampNs < 0
                || f.exposureNs <= 0 || f.iso <= 0 || Float.isInfinite(f.focalLengthPx)
                || Float.isInfinite(f.gyroExcursionRad) || f.gyroExcursionRad < 0)
            throw new IllegalArgumentException("Invalid RAW descriptor");
        for (float black : f.blackLevel4) {
            if (!Float.isFinite(black) || black < 0 || f.whiteLevel-black < 1)
                throw new IllegalArgumentException("Invalid black/white levels");
        }
        if (size > 0) {
            Frame last = at(size-1);
            if (last.w != f.width || last.h != f.height || last.cfa != f.cfaPattern || last.time >= f.timestampNs)
                throw new IllegalArgumentException("Incompatible geometry, CFA or capture order");
        }
        Frame snapshot = new Frame(f); // validate and pack before replacing any slot
        ring[(oldest+size)%ring.length] = snapshot;
        if (size == ring.length) oldest = (oldest+1)%ring.length;
        else size++;
    }

    private Frame at(int i) { return ring[(oldest+i)%ring.length]; }
    public synchronized int size() { return size; }
    public synchronized void clear() { Arrays.fill(ring,null); oldest = size = 0; }

    public synchronized Result merge() { return mergeInternal(false); }

    /** Optional guide acceleration on the caller's dedicated current offscreen ES 3.1+ context. */
    public synchronized Result mergeOnCurrentGlContext() { return mergeInternal(true); }

    private Frame anchor() {
        if (size == 0) throw new IllegalStateException("Empty burst");
        Frame[] eligible = new Frame[size];
        int count = 0;
        Frame leastMotion = at(0);
        for (int i = 0; i < size; i++) {
            Frame f = at(i);
            if (!(f.blur > BLUR_LIMIT)) eligible[count++] = f;
            if (f.blur < leastMotion.blur) leastMotion = f;
        }
        if (count == 0) return leastMotion;
        if (mode == MODE_RAW_AEB) {
            Arrays.sort(eligible, 0, count, (a,b) -> Double.compare(a.exposureGain,b.exposureGain));
            return eligible[count/2];
        }
        // Keep the earliest eligible reference on ties; measured stability takes precedence over unknown.
        Frame best = eligible[0];
        for (int i = 1; i < count; i++) {
            double blur = eligible[i].blur;
            if (Double.isFinite(blur) && (!Double.isFinite(best.blur) || blur < best.blur)) best = eligible[i];
        }
        return best;
    }

    private static final class Aligned {
        final Frame f;
        final float[] dx, dy, sharpness;
        final double scale;
        double noiseVariance;
        Aligned(Frame f, Frame anchor, int tiles, boolean focus) {
            this.f = f;
            scale = anchor.exposureGain / f.exposureGain;
            dx = new float[tiles];
            dy = new float[tiles];
            sharpness = focus ? new float[tiles] : null;
        }
    }

    private Result mergeInternal(boolean allowGl) {
        Frame base = anchor();
        int cols = (base.w+TILE-1)/TILE, rows = (base.h+TILE-1)/TILE, tiles = cols*rows;
        boolean focus = mode == MODE_FOCUS_STACK, sr = mode == MODE_SUPER_RES;
        Aligned[] frames = new Aligned[size];
        frames[0] = new Aligned(base,base,tiles,focus);
        int used = 1;
        for (int i = 0; i < size; i++) {
            Frame f = at(i);
            if (f != base && !(f.blur > BLUR_LIMIT)) frames[used++] = new Aligned(f,base,tiles,focus);
        }
        int w = sr ? outputDimension(base.w,4) : base.w, h = sr ? outputDimension(base.h,2) : base.h;
        boolean gpu = false;
        if (used > 1) {
            float[] ref = new float[(base.w/2)*(base.h/2)], other = new float[ref.length];
            try (GuideCompute gl = allowGl ? GuideCompute.open() : null) {
                gpu = guide(base,ref,gl);
                if (sr || focus) registrationBand(ref,base.w/2);
                if (focus) sharpness(frames[0],cols);
                for (int i = 1; i < used; i++) {
                    Aligned f = frames[i];
                    gpu |= guide(f.f,other,gl);
                    if (sr || focus) registrationBand(other,base.w/2);
                    register(ref,other,f,cols,mode);
                    if (focus) sharpness(f,cols);
                }
            }
        }
        double headroom = 1;
        if (mode == MODE_RAW_AEB) for (int i = 1; i < used; i++) headroom = Math.max(headroom,frames[i].scale);
        float white = (float)Math.min(16_777_215, base.white*headroom);
        int[] out = new int[w*h], minimumDn = new int[4];
        for (int p = 0; p < 4; p++) minimumDn[p] = (int)Math.ceil(base.black[p]);
        int maximumDn = (int)Math.floor(white);
        boolean diverse = false;
        for (int tile = 0; tile < tiles; tile++) {
            boolean refine = sr && diverse(frames,used,tile);
            diverse |= refine;
            int winner = 0;
            if (focus && used > 1) for (int i = 1; i < used; i++)
                if (frames[i].sharpness[tile] > frames[winner].sharpness[tile]) winner = i;
            int tx = tile%cols*TILE, ty = tile/cols*TILE;
            int x0 = edge(tx,w,base.w), y0 = edge(ty,h,base.h);
            int x1 = edge(Math.min(tx+TILE,base.w),w,base.w), y1 = edge(Math.min(ty+TILE,base.h),h,base.h);
            for (int y = y0; y < y1; y++) for (int x = x0; x < x1; x++) {
                int p = (y&1)*2+(x&1);
                double signal;
                if (sr) {
                    double sx = (x+0.5)*base.w/w-0.5, sy = (y+0.5)*base.h/h-0.5;
                    signal = refine ? reconstruct(frames,used,tile,sx,sy,p) : sample(base,sx,sy,p);
                } else {
                    signal = fuse(frames,used,tile,x,y,p,winner);
                }
                double fraction = Math.max(0,Math.min(1,signal/headroom));
                int dn = (int)Math.round(base.black[p]+fraction*(white-base.black[p]));
                out[y*w+x] = Math.max(minimumDn[p],Math.min(maximumDn,dn));
            }
        }
        return new Result(out,w,h,base,used,headroom,white,diverse,gpu);
    }

    private static int edge(int n, int out, int in) { return (int)(((long)n*out + in/2)/in); }
    private static boolean guide(Frame f, float[] dst, GuideCompute gl) {
        if (gl != null && gl.fill(f,dst)) return true;
        int i = 0;
        for (int y = 0; y < f.h; y += 2) for (int x = 0; x+1 < f.w; x += 2)
            dst[i++] = (float)(0.25*(f.linear(x,y,0) + f.linear(x+1,y,1)
                    + f.linear(x,y+1,2) + f.linear(x+1,y+1,3)));
        return false;
    }


    /** Clipped L1 on a common radiance interval, so saturated bracket pixels cannot pull the match. */
    private static double cost(float[] ref, float[] src, int w, int h, int x0, int y0, int x1, int y1,
                               int dx, int dy, int stride, double scale) {
        double sum = 0, ceiling = Math.min(1,scale);
        int n = 0;
        for (int y = y0; y < y1; y += stride) for (int x = x0; x < x1; x += stride) {
            int sx = x+dx, sy = y+dy;
            if (sx < 0 || sy < 0 || sx >= w || sy >= h) continue;
            double a = Math.min(ceiling,ref[y*w+x]), b = Math.min(ceiling,scale*src[sy*w+sx]);
            sum += Math.min(0.10*ceiling,Math.abs(a-b));
            n++;
        }
        return n == 0 ? Double.POSITIVE_INFINITY : sum/n;
    }

    private static void register(float[] ref, float[] src, Aligned frame, int cols, int mode) {
        int w = frame.f.w/2, h = frame.f.h/2;
        int step = Math.max(1,(int)Math.sqrt((double)w*h/2304));
        int border = Math.min(SEARCH,Math.min((w-1)/3,(h-1)/3));
        int gx = 0, gy = 0;
        double best = Double.POSITIVE_INFINITY;
        // Sparse frame-wide translation, then dense overlapping tile refinement around that prior.
        for (int y = -SEARCH; y <= SEARCH; y++) for (int x = -SEARCH; x <= SEARCH; x++) {
            double c = cost(ref,src,w,h,border,border,w-border,h-border,x,y,step,frame.scale)
                    + 1e-6*(x*x+y*y);
            if (c < best) { best = c; gx = x; gy = y; }
        }
        double[] global = {gx,gy};
        refine(ref,src,w,h,border,border,w-border,h-border,step,frame.scale,global);
        double[] delta = new double[2];
        for (int t = 0; t < frame.dx.length; t++) {
            int tx = (t%cols)*TILE/2, ty = (t/cols)*TILE/2;
            int x0 = Math.max(0,tx-3), y0 = Math.max(0,ty-3);
            int x1 = Math.min(w,tx+TILE/2+3), y1 = Math.min(h,ty+TILE/2+3);
            delta[0] = global[0]; delta[1] = global[1];
            // ND tracks the static scene. Following each moving object would erase intentional trails.
            if (mode != MODE_SYNTHETIC_ND) {
                double priorCost = cost(ref,src,w,h,x0,y0,x1,y1,gx,gy,1,frame.scale);
                best = priorCost;
                int lx = gx, ly = gy;
                for (int y = Math.max(-SEARCH,gy-1); y <= Math.min(SEARCH,gy+1); y++)
                    for (int x = Math.max(-SEARCH,gx-1); x <= Math.min(SEARCH,gx+1); x++) {
                        double c = cost(ref,src,w,h,x0,y0,x1,y1,x,y,1,frame.scale)
                                + 0.004*Math.min(1,frame.scale)*(Math.abs(x-gx)+Math.abs(y-gy));
                        if (c < best) { best = c; lx = x; ly = y; }
                    }
                if (lx != gx || ly != gy) {
                    delta[0] = lx; delta[1] = ly;
                    refine(ref,src,w,h,x0,y0,x1,y1,1,frame.scale,delta);
                }
            }
            frame.dx[t] = displacement(delta[0]);
            frame.dy[t] = displacement(delta[1]);
        }
        if (mode == MODE_HDR_PLUS) estimateNoise(frame,ref,src,cols);
    }

    private static float displacement(double cells) {
        double pixels = Math.max(-6, Math.min(6,2*cells));
        return (float)(Math.abs(pixels-Math.rint(pixels)) < 0.07 ? Math.rint(pixels) : pixels);
    }

    /** Sub-superpixel Lucas-Kanade translation with bilinear intensities and robust residuals. */
    private static void refine(float[] ref, float[] src, int w, int h, int x0, int y0, int x1, int y1,
                               int step, double scale, double[] d) {
        for (int iteration = 0; iteration < 4; iteration++) {
            double xx = 1e-6, yy = 1e-6, xy = 0, xr = 0, yr = 0;
            int ix = (int)Math.floor(d[0]), iy = (int)Math.floor(d[1]);
            double fx = d[0]-ix, fy = d[1]-iy;
            for (int y = y0; y < y1; y += step) for (int x = x0; x < x1; x += step) {
                int sx = x+ix, sy = y+iy;
                if (sx < 0 || sy < 0 || sx+1 >= w || sy+1 >= h) continue;
                int j = sy*w+sx;
                double a = src[j], b = src[j+1], c = src[j+w], e = src[j+w+1];
                double value = (a+(b-a)*fx)*(1-fy)+(c+(e-c)*fx)*fy;
                double target = ref[y*w+x];
                if (target >= 0.95 || value >= 0.95) continue;
                double residual = target-value*scale;
                double weight = 1/(1+Math.abs(residual)/0.025);
                double dx = ((b-a)*(1-fy)+(e-c)*fy)*scale;
                double dy = ((c-a)*(1-fx)+(e-b)*fx)*scale;
                xx += weight*dx*dx; yy += weight*dy*dy; xy += weight*dx*dy;
                xr += weight*dx*residual; yr += weight*dy*residual;
            }
            double det = xx*yy-xy*xy;
            if (det < 1e-10) break;
            double dx = Math.max(-0.45,Math.min(0.45,(yy*xr-xy*yr)/det));
            double dy = Math.max(-0.45,Math.min(0.45,(xx*yr-xy*xr)/det));
            d[0] += dx; d[1] += dy;
            if (dx*dx+dy*dy < 0.0001) break;
        }
    }

    /** A four-site guide averages down independent pixel noise by about two in standard deviation. */
    private static void estimateNoise(Aligned f, float[] ref, float[] src, int cols) {
        int[] histogram = new int[256];
        int w = f.f.w/2, h = f.f.h/2, count = 0;
        int step = Math.max(1,(int)Math.sqrt((double)w*h/4096));
        for (int y = 0; y < h; y += step) for (int x = 0; x < w; x += step) {
            int tile = (2*y/TILE)*cols+2*x/TILE;
            int sx = x+Math.round(f.dx[tile]/2), sy = y+Math.round(f.dy[tile]/2);
            if (sx < 0 || sy < 0 || sx >= w || sy >= h) continue;
            double error = Math.abs(ref[y*w+x]-src[sy*w+sx]*f.scale);
            histogram[Math.min(255,(int)(error*4096))]++;
            count++;
        }
        int median = 0, n = 0;
        for (; median < 255; median++) { n += histogram[median]; if (2*n >= count) break; }
        double sigma = Math.min(0.04, 2*1.4826*(median+0.5)/4096);
        double floor = Math.max(2/f.f.white,0.001);
        f.noiseVariance = 6*sigma*sigma + floor*floor;
    }

    // Suppress frequencies aliased by CFA subsampling and those attenuated by defocus before
    // fitting motion. Filtering guides only keeps the original photosites intact for reconstruction.
    private static void registrationBand(float[] guide, int width) {
        int height = guide.length/width;
        for (int pass = 0; pass < 4; pass++) {
            for (int y = 0; y < height; y++) blurLine(guide,y*width,1,width);
            for (int x = 0; x < width; x++) blurLine(guide,x,width,height);
        }
    }

    private static void blurLine(float[] a, int start, int stride, int length) {
        float prev = a[start], center = prev;
        for (int i = 0, j = start; i < length; i++, j += stride) {
            float next = i+1 < length ? a[j+stride] : center;
            a[j] = (prev+2*center+next)*0.25f;
            prev = center;
            center = next;
        }
    }

    private static void sharpness(Aligned frame, int cols) {
        Frame f = frame.f;
        for (int t = 0; t < frame.dx.length; t++) {
            int sx = t%cols*TILE+Math.round(frame.dx[t]), sy = t/cols*TILE+Math.round(frame.dy[t]);
            double energy = 0;
            int count = 0;
            for (int y = Math.max(2,sy); y < Math.min(f.h-2,sy+TILE); y++)
                for (int x = Math.max(2,sx); x < Math.min(f.w-2,sx+TILE); x++) {
                    int p = 2*(y&1)+(x&1);
                    energy += Math.abs(4*f.linear(x,y,p)-f.linear(x-2,y,p)-f.linear(x+2,y,p)
                            -f.linear(x,y-2,p)-f.linear(x,y+2,p));
                    count++;
                }
            frame.sharpness[t] = count == 0 ? 0 : (float)(frame.scale*energy/count);
        }
    }

    /** Bilinear sampling on a single two-pixel-spaced CFA plane, including its own black pedestal. */
    private static double sample(Frame f, double x, double y, int phase) {
        int px = phase&1, py = phase>>1;
        int lastX = f.w-1 - ((f.w-1-px)&1);
        double u = Math.max(0,Math.min((lastX-px)/2,(x-px)/2)), v = Math.max(0,Math.min(f.h/2-1,(y-py)/2));
        int col = (int)u, row = (int)v, x0 = 2*col+px, y0 = 2*row+py;
        int x1 = Math.min(x0+2,lastX), y1 = Math.min(y0+2,f.h-2+py);
        double fx = u-col, fy = v-row;
        double top = f.linear(x0,y0,phase)*(1-fx)+f.linear(x1,y0,phase)*fx;
        double bottom = f.linear(x0,y1,phase)*(1-fx)+f.linear(x1,y1,phase)*fx;
        return top*(1-fy)+bottom*fy;
    }

    private double fuse(Aligned[] frames, int used, int tile, int x, int y, int phase, int winner) {
        Frame anchor = frames[0].f;
        double reference = anchor.linear(x,y,phase);
        if (used == 1 || (mode == MODE_FOCUS_STACK && winner == 0)) return reference;
        double sum = 0, weights = 0, clippedBound = reference;
        for (int i = 0; i < used; i++) {
            Aligned f = frames[i];
            double sx = x+f.dx[tile], sy = y+f.dy[tile];
            if (sx < 0 || sy < 0 || sx > anchor.w-1 || sy > anchor.h-1) continue;
            double v = i == 0 ? reference : sample(f.f,sx,sy,phase);
            double radiance = v*f.scale, weight = 1;
            if (mode == MODE_FOCUS_STACK) {
                if (i == winner) return radiance;
                continue;
            }
            if (mode == MODE_RAW_AEB) {
                clippedBound = Math.max(clippedBound,radiance);
                double safe = Math.max(0,Math.min(1,(1-v)/0.08));
                if (v >= 1-0.5*f.f.inv[phase]) safe = 0; // integer saturation
                weight = safe*safe/(f.scale*f.scale);
            } else if (mode == MODE_HDR_PLUS && i != 0) {
                double diff = radiance-reference, ratio = diff*diff/f.noiseVariance;
                weight = ratio > 25 ? 0 : 1/(1+ratio);
            }
            sum += weight*radiance;
            weights += weight;
        }
        return weights > 0 ? sum/weights : mode == MODE_RAW_AEB ? clippedBound : reference;
    }

    private static boolean diverse(Aligned[] frames, int used, int tile) {
        for (int i = 1; i < used; i++) {
            double dx = frames[i].dx[tile], dy = frames[i].dy[tile];
            if (Math.hypot(dx-2*Math.rint(dx/2),dy-2*Math.rint(dy/2)) > 0.20) return true;
        }
        return false;
    }

    // Separable Gaussian gather from original CFA sites. Equivalent to normalized forward splats,
    // without allocating high-resolution float accumulation and weight planes.
    private static final double[] GAUSSIAN = new double[513];
    static {
        for (int i = 0; i < GAUSSIAN.length; i++) {
            double d = i/256.0;
            GAUSSIAN[i] = Math.exp(-d*d/(2*0.49*0.49));
        }
    }
    private static double kernel(double d) { return GAUSSIAN[Math.min(512,(int)(Math.abs(d)*256+0.5))]; }

    private static double reconstruct(Aligned[] frames, int used, int tile, double x, double y, int p) {
        int px = p&1, py = p>>1;
        double total = 0, weights = 0;
        for (int i = 0; i < used; i++) {
            Aligned f = frames[i];
            double sx = x+f.dx[tile], sy = y+f.dy[tile];
            int x0 = 2*(int)Math.floor((sx-px)/2)+px, y0 = 2*(int)Math.floor((sy-py)/2)+py;
            for (int yy = y0; yy <= y0+2; yy += 2) {
                if (yy < 0 || yy >= f.f.h) continue;
                double wy = kernel(yy-sy);
                for (int xx = x0; xx <= x0+2; xx += 2) {
                    if (xx < 0 || xx >= f.f.w) continue;
                    double weight = wy*kernel(xx-sx);
                    total += weight*f.f.linear(xx,yy,p)*f.scale;
                    weights += weight;
                }
            }
        }
        return weights > 0 ? total/weights : sample(frames[0].f,x,y,p);
    }
    /** Builds only 2x2 registration guides on the GPU. Capture buffers never leave the CPU ring. */
    private static final class GuideCompute implements AutoCloseable {
        private static final int SSBO = 0x90D2, STREAM_DRAW = 0x88E0, STREAM_READ = 0x88E1;
        private static final int CELLS = 8192;
        private static final String SOURCE = "#version 310 es\nprecision highp float;\nprecision highp int;\n"
                + "layout(local_size_x=64) in;\n"
                + "layout(std430,binding=0) readonly buffer Input { uvec2 pair[]; };\n"
                + "layout(std430,binding=1) writeonly buffer Output { float dst[]; };\n"
                + "uniform vec4 black, invRange; uniform int count;\n"
                + "void main(){ uint i=gl_GlobalInvocationID.x; if(i>=uint(count)) return;"
                + "uvec2 s=pair[i]; vec4 dn=vec4(s.x&65535u,s.x>>16,s.y&65535u,s.y>>16);"
                + "dst[i]=dot((dn-black)*invRange,vec4(0.25)); }";
        final int[] buffers = new int[2];
        final ByteBuffer staging = ByteBuffer.allocateDirect(CELLS*8).order(ByteOrder.nativeOrder());
        int program, shader, black, inverse, count;
        boolean available;

        static GuideCompute open() {
            GuideCompute gl = null;
            try {
                if (EGL14.eglGetCurrentContext() == null || EGL14.eglGetCurrentContext().equals(EGL14.EGL_NO_CONTEXT))
                    return null;
                gl = new GuideCompute();
                if (gl.init()) return gl;
            } catch (RuntimeException | LinkageError ignored) {
                // Android GL may be absent on a JVM, or the current context may have been lost.
            }
            if (gl != null) gl.close();
            return null;
        }

        boolean init() {
            String version = GLES31.glGetString(0x1F02);
            if (version == null || !(version.startsWith("OpenGL ES 3.1") || version.startsWith("OpenGL ES 3.2")))
                return false;
            shader = GLES31.glCreateShader(0x91B9);
            if (shader == 0) return false;
            GLES31.glShaderSource(shader,SOURCE);
            GLES31.glCompileShader(shader);
            int[] ok = new int[1];
            GLES31.glGetShaderiv(shader,0x8B81,ok,0);
            if (ok[0] == 0) return false;
            program = GLES31.glCreateProgram();
            GLES31.glAttachShader(program,shader);
            GLES31.glLinkProgram(program);
            GLES31.glGetProgramiv(program,0x8B82,ok,0);
            if (ok[0] == 0) return false;
            black = GLES31.glGetUniformLocation(program,"black");
            inverse = GLES31.glGetUniformLocation(program,"invRange");
            count = GLES31.glGetUniformLocation(program,"count");
            GLES31.glGenBuffers(2,buffers,0);
            GLES31.glUseProgram(program);
            available = black >= 0 && inverse >= 0 && count >= 0 && buffers[0] != 0 && buffers[1] != 0
                    && GLES31.glGetError() == 0;
            return available;
        }

        boolean fill(Frame f, float[] dst) {
            if (!available) return false;
            available = false; // One failed dispatch disables the backend for the rest of this burst.
            try {
                GLES31.glUniform4fv(black,1,f.black,0);
                GLES31.glUniform4fv(inverse,1,f.inv,0);
                for (int start = 0; start < dst.length; start += CELLS) {
                    int n = Math.min(CELLS,dst.length-start);
                    staging.clear();
                    for (int i = start; i < start+n; i++) {
                        int row = i/(f.w/2), p = row*2*f.w+2*(i%(f.w/2));
                        staging.putInt((f.data[p]&65535) | (f.data[p+1]<<16));
                        staging.putInt((f.data[p+f.w]&65535) | (f.data[p+f.w+1]<<16));
                    }
                    staging.flip();
                    GLES31.glBindBuffer(SSBO,buffers[0]);
                    GLES31.glBufferData(SSBO,n*8,staging,STREAM_DRAW);
                    GLES31.glBindBufferBase(SSBO,0,buffers[0]);
                    GLES31.glBindBuffer(SSBO,buffers[1]);
                    GLES31.glBufferData(SSBO,n*4,null,STREAM_READ);
                    GLES31.glBindBufferBase(SSBO,1,buffers[1]);
                    GLES31.glUniform1i(count,n);
                    GLES31.glDispatchCompute((n+63)/64,1,1);
                    GLES31.glMemoryBarrier(0x0200); // GL_BUFFER_UPDATE_BARRIER_BIT before CPU map
                    if (GLES31.glGetError() != 0) return false;
                    Buffer mapped = GLES31.glMapBufferRange(SSBO,0,n*4,1);
                    if (mapped == null) return false;
                    boolean intact;
                    try {
                        ((ByteBuffer)mapped).order(ByteOrder.nativeOrder()).asFloatBuffer().get(dst,start,n);
                    } finally { intact = GLES31.glUnmapBuffer(SSBO); }
                    if (!intact || GLES31.glGetError() != 0) return false;
                }
                available = true;
                return true;
            } catch (RuntimeException | LinkageError ignored) { return false; }
        }

        @Override public void close() {
            try {
                if (program != 0) { GLES31.glUseProgram(0); GLES31.glDeleteProgram(program); }
                if (shader != 0) GLES31.glDeleteShader(shader);
                if (buffers[0] != 0 || buffers[1] != 0) GLES31.glDeleteBuffers(2,buffers,0);
            } catch (RuntimeException | LinkageError ignored) {}
        }
    }
}
