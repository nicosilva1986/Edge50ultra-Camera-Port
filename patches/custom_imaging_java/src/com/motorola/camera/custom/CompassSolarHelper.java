// SPDX-License-Identifier: MIT
package com.motorola.camera.custom;

/**
 * Offline compass and solar math for the capture HUD.
 * Orientation uses Android SensorManager ENU world coordinates (X=East, Y=North, Z=Up)
 * mapped from the active camera optical axis (-Z_device for rear, +Z_device for front).
 * Upright portrait facing north is Rx(+90°) = [sin(45°), 0, 0, cos(45°)] -> heading=0°, pitch=0°.
 * Flat face-up identity [0, 0, 0, 1] points rear camera straight down (pitch=-90°, +Y North).
 * Solar position follows the NOAA low-precision ephemeris (Meeus equation of center,
 * obliquity, declination, equation of time, and horizon refraction).
 */
public final class CompassSolarHelper {
    public static final double DEFAULT_OUTDOOR_EV100 = 11.0;

    private static final String[] CARDINALS = {
            "N", "NE", "E", "SE", "S", "SW", "W", "NW"
    };

    private CompassSolarHelper() {}

    public static final class OrientationReading {
        public final float headingDeg;
        public final float pitchDeg;
        public final float rollDeg;
        public final int accuracy;
        public final long timestampNs;

        public OrientationReading(float headingDeg, float pitchDeg, float rollDeg,
                                  int accuracy, long timestampNs) {
            this.headingDeg = headingDeg;
            this.pitchDeg = pitchDeg;
            this.rollDeg = rollDeg;
            this.accuracy = accuracy;
            this.timestampNs = timestampNs;
        }
    }

    public static final class SolarPosition {
        public final double azimuthDeg;
        public final double elevationDeg;

        public SolarPosition(double azimuthDeg, double elevationDeg) {
            this.azimuthDeg = azimuthDeg;
            this.elevationDeg = elevationDeg;
        }
    }

    /**
     * @param rotationVector Android rotation vector, {@code [x, y, z]} or {@code [x, y, z, w]}
     * @param displayRotationDeg one of 0, 90, 180, 270; other values keep the natural screen axes
     */
    public static OrientationReading computeOrientation(float[] rotationVector, int rotationVectorLen,
                                                        int displayRotationDeg, boolean isFrontCamera,
                                                        int accuracy, long timestampNs) {
        if (rotationVector == null || rotationVectorLen < 3 || rotationVector.length < 3
                || rotationVector.length < rotationVectorLen) {
            return new OrientationReading(Float.NaN, Float.NaN, Float.NaN, accuracy, timestampNs);
        }
        float q1 = rotationVector[0];
        float q2 = rotationVector[1];
        float q3 = rotationVector[2];
        float q0;
        if (rotationVectorLen >= 4) {
            q0 = rotationVector[3];
        } else {
            float vectorNorm2 = q1 * q1 + q2 * q2 + q3 * q3;
            q0 = vectorNorm2 < 1f ? (float) Math.sqrt(1.0 - vectorNorm2) : 0f;
        }
        float norm = (float) Math.sqrt(q0 * q0 + q1 * q1 + q2 * q2 + q3 * q3);
        if (norm > 1.0e-6f) {
            float inv = 1f / norm;
            q0 *= inv;
            q1 *= inv;
            q2 *= inv;
            q3 *= inv;
        }

        float sqQ1 = 2f * q1 * q1;
        float sqQ2 = 2f * q2 * q2;
        float sqQ3 = 2f * q3 * q3;
        float q1q2 = 2f * q1 * q2;
        float q3q0 = 2f * q3 * q0;
        float q1q3 = 2f * q1 * q3;
        float q2q0 = 2f * q2 * q0;
        float q2q3 = 2f * q2 * q3;
        float q1q0 = 2f * q1 * q0;
        float r0 = 1f - sqQ2 - sqQ3;
        float r1 = q1q2 - q3q0;
        float r2 = q1q3 + q2q0;
        float r3 = q1q2 + q3q0;
        float r4 = 1f - sqQ1 - sqQ3;
        float r5 = q2q3 - q1q0;
        float r6 = q1q3 - q2q0;
        float r7 = q2q3 + q1q0;
        float r8 = 1f - sqQ1 - sqQ2;

        float dz = isFrontCamera ? 1f : -1f;
        float east = r2 * dz;
        float north = r5 * dz;
        float up = r8 * dz;
        double horizontal = Math.hypot(east, north);
        float heading;
        if (horizontal < 1.0e-3) {
            // Optical axis near zenith/nadir (flat table pose): derive azimuth from device +Y axis.
            double yHorizontal = Math.hypot(r1, r4);
            heading = yHorizontal > 1.0e-4 ? (float) Math.toDegrees(Math.atan2(r1, r4)) : 0f;
        } else {
            heading = (float) Math.toDegrees(Math.atan2(east, north));
        }
        if (heading < 0f) heading += 360f;
        if (heading >= 360f) heading = 0f;
        float pitch = (float) Math.toDegrees(Math.atan2(up, horizontal));

        int rotation = displayRotationDeg % 360;
        if (rotation < 0) rotation += 360;
        float rightX;
        float rightY;
        float upX;
        float upY;
        if (rotation == 90) {
            rightX = 0f;
            rightY = 1f;
            upX = -1f;
            upY = 0f;
        } else if (rotation == 180) {
            rightX = -1f;
            rightY = 0f;
            upX = 0f;
            upY = -1f;
        } else if (rotation == 270) {
            rightX = 0f;
            rightY = -1f;
            upX = 1f;
            upY = 0f;
        } else {
            rightX = 1f;
            rightY = 0f;
            upX = 0f;
            upY = 1f;
        }
        float worldUpX = r6;
        float worldUpY = r7;
        float roll = (float) Math.toDegrees(Math.atan2(
                worldUpX * rightX + worldUpY * rightY,
                worldUpX * upX + worldUpY * upY));
        return new OrientationReading(heading, pitch, roll, accuracy, timestampNs);
    }

    public static SolarPosition computeSolarPosition(double latDeg, double lonDeg, long epochMillis) {
        double jd = epochMillis / 86400000.0 + 2440587.5;
        double t = (jd - 2451545.0) / 36525.0;
        double eqTime = equationOfTimeMinutes(t);
        double declination = sunDeclinationDeg(t);
        double utcMinutes = ((epochMillis % 86400000L) + 86400000L) % 86400000L / 60000.0;
        double trueSolar = utcMinutes + eqTime + 4.0 * lonDeg;
        trueSolar = trueSolar - 1440.0 * Math.floor(trueSolar / 1440.0);
        double hourAngle = trueSolar / 4.0 - 180.0;

        double lat = Math.toRadians(latDeg);
        double dec = Math.toRadians(declination);
        double ha = Math.toRadians(hourAngle);
        double cosZenith = Math.sin(lat) * Math.sin(dec) + Math.cos(lat) * Math.cos(dec) * Math.cos(ha);
        if (cosZenith > 1.0) cosZenith = 1.0;
        if (cosZenith < -1.0) cosZenith = -1.0;
        double zenith = Math.toDegrees(Math.acos(cosZenith));
        double azDenom = Math.cos(lat) * Math.sin(Math.toRadians(zenith));
        double azimuth;
        if (Math.abs(azDenom) > 0.001) {
            double azCos = (Math.sin(lat) * Math.cos(Math.toRadians(zenith)) - Math.sin(dec)) / azDenom;
            if (azCos < -1.0) azCos = -1.0;
            if (azCos > 1.0) azCos = 1.0;
            azimuth = 180.0 - Math.toDegrees(Math.acos(azCos));
            if (hourAngle > 0.0) azimuth = -azimuth;
        } else if (latDeg > 0.0) {
            azimuth = 180.0;
        } else {
            azimuth = 0.0;
        }
        if (azimuth < 0.0) azimuth += 360.0;
        if (azimuth >= 360.0) azimuth -= 360.0;

        double geometricElevation = 90.0 - zenith;
        double elevation = geometricElevation + refractionDeg(geometricElevation);
        if (elevation > 90.0) elevation = 90.0;
        if (elevation < -90.0) elevation = -90.0;
        return new SolarPosition(azimuth, elevation);
    }

    public static String formatCardinal(double azimuthDeg) {
        if (!Double.isFinite(azimuthDeg)) return "N";
        double wrapped = wrap360(azimuthDeg);
        int index = (int) Math.floor((wrapped + 22.5) / 45.0) % 8;
        return CARDINALS[index];
    }

    public static String formatHeadingLabel(double azimuthDeg) {
        if (!Double.isFinite(azimuthDeg)) return "N 0\u00B0";
        int rounded = (int) Math.round(wrap360(azimuthDeg));
        if (rounded >= 360) rounded = 0;
        return formatCardinal(rounded) + " " + rounded + "\u00B0";
    }

    public static double angularSeparationDeg(double az1Deg, double el1Deg, double az2Deg, double el2Deg) {
        double x1 = Math.cos(Math.toRadians(el1Deg)) * Math.sin(Math.toRadians(az1Deg));
        double y1 = Math.cos(Math.toRadians(el1Deg)) * Math.cos(Math.toRadians(az1Deg));
        double z1 = Math.sin(Math.toRadians(el1Deg));
        double x2 = Math.cos(Math.toRadians(el2Deg)) * Math.sin(Math.toRadians(az2Deg));
        double y2 = Math.cos(Math.toRadians(el2Deg)) * Math.cos(Math.toRadians(az2Deg));
        double z2 = Math.sin(Math.toRadians(el2Deg));
        double dot = x1 * x2 + y1 * y2 + z1 * z2;
        if (dot > 1.0) dot = 1.0;
        if (dot < -1.0) dot = -1.0;
        return Math.toDegrees(Math.acos(dot));
    }

    public static double horizontalAzimuthDeltaDeg(double camAzDeg, double sunAzDeg) {
        double delta = (sunAzDeg - camAzDeg) % 360.0;
        if (delta > 180.0) delta -= 360.0;
        if (delta <= -180.0) delta += 360.0;
        return delta;
    }

    public static double computeEv100(long exposureTimeNs, int iso, float aperture) {
        if (exposureTimeNs <= 0L || iso <= 0 || !(aperture > 0f)
                || Float.isInfinite(aperture)) {
            return Double.NaN;
        }
        double seconds = exposureTimeNs * 1.0e-9;
        double value = (aperture * aperture / seconds) * (100.0 / iso);
        if (!(value > 0.0) || Double.isInfinite(value)) return Double.NaN;
        return Math.log(value) / Math.log(2.0);
    }

    public static boolean isPhysicalOutdoorBacklit(double ev100, double sunElevationDeg,
                                                   double cameraSunAngleDeg, int magneticAccuracy) {
        return Double.isFinite(ev100)
                && ev100 >= DEFAULT_OUTDOOR_EV100
                && magneticAccuracy >= 2
                && sunElevationDeg >= 5.0
                && cameraSunAngleDeg <= 45.0;
    }

    public static String formatExifDirection(double azimuthDeg) {
        if (!Double.isFinite(azimuthDeg)) return null;
        long hundredths = Math.round(wrap360(azimuthDeg) * 100.0);
        if (hundredths >= 36000L || hundredths < 0L) hundredths = 0L;
        return hundredths + "/100";
    }

    private static double wrap360(double degrees) {
        double wrapped = degrees % 360.0;
        if (wrapped < 0.0) wrapped += 360.0;
        if (wrapped >= 360.0) wrapped = 0.0;
        return wrapped;
    }

    private static double sunDeclinationDeg(double t) {
        double lambda = sunApparentLongitudeDeg(t);
        double epsilon = obliquityCorrectionDeg(t);
        return Math.toDegrees(Math.asin(
                Math.sin(Math.toRadians(epsilon)) * Math.sin(Math.toRadians(lambda))));
    }

    private static double equationOfTimeMinutes(double t) {
        double epsilon = obliquityCorrectionDeg(t);
        double meanLong = geomMeanLongitudeDeg(t);
        double eccentricity = eccentricityEarthOrbit(t);
        double anomaly = geomMeanAnomalyDeg(t);
        double y = Math.tan(Math.toRadians(epsilon) / 2.0);
        y *= y;
        double l0 = Math.toRadians(meanLong);
        double m = Math.toRadians(anomaly);
        double eTime = y * Math.sin(2.0 * l0)
                - 2.0 * eccentricity * Math.sin(m)
                + 4.0 * eccentricity * y * Math.sin(m) * Math.cos(2.0 * l0)
                - 0.5 * y * y * Math.sin(4.0 * l0)
                - 1.25 * eccentricity * eccentricity * Math.sin(2.0 * m);
        return Math.toDegrees(eTime) * 4.0;
    }

    private static double sunApparentLongitudeDeg(double t) {
        double omega = 125.04 - 1934.136 * t;
        return geomMeanLongitudeDeg(t) + sunEquationOfCenterDeg(t)
                - 0.00569 - 0.00478 * Math.sin(Math.toRadians(omega));
    }

    private static double sunEquationOfCenterDeg(double t) {
        double anomaly = geomMeanAnomalyDeg(t);
        double m = Math.toRadians(anomaly);
        return Math.sin(m) * (1.914602 - t * (0.004817 + 0.000014 * t))
                + Math.sin(m + m) * (0.019993 - 0.000101 * t)
                + Math.sin(m + m + m) * 0.000289;
    }

    private static double obliquityCorrectionDeg(double t) {
        double seconds = 21.448 - t * (46.8150 + t * (0.00059 - t * 0.001813));
        double mean = 23.0 + (26.0 + seconds / 60.0) / 60.0;
        double omega = 125.04 - 1934.136 * t;
        return mean + 0.00256 * Math.cos(Math.toRadians(omega));
    }

    private static double geomMeanLongitudeDeg(double t) {
        double longitude = 280.46646 + t * (36000.76983 + t * 0.0003032);
        longitude = longitude % 360.0;
        if (longitude < 0.0) longitude += 360.0;
        return longitude;
    }

    private static double geomMeanAnomalyDeg(double t) {
        return 357.52911 + t * (35999.05029 - 0.0001537 * t);
    }

    private static double eccentricityEarthOrbit(double t) {
        return 0.016708634 - t * (0.000042037 + 0.0000001267 * t);
    }

    private static double refractionDeg(double elevationDeg) {
        if (elevationDeg > 85.0) return 0.0;
        double te = Math.tan(Math.toRadians(elevationDeg));
        double arcSeconds;
        if (elevationDeg > 5.0) {
            double te2 = te * te;
            double te3 = te2 * te;
            double te5 = te3 * te2;
            arcSeconds = 58.1 / te - 0.07 / te3 + 0.000086 / te5;
        } else if (elevationDeg > -0.575) {
            arcSeconds = 1735.0 + elevationDeg * (-518.2 + elevationDeg * (103.4
                    + elevationDeg * (-12.79 + elevationDeg * 0.711)));
        } else {
            arcSeconds = -20.774 / te;
        }
        return arcSeconds / 3600.0;
    }
}
