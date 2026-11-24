package android.location;

public class Location {
    public Location(String provider) {}
    public double getLatitude() { return 0.0; }
    public double getLongitude() { return 0.0; }
    public double getAltitude() { return 0.0; }
    public boolean hasAltitude() { return false; }
    public long getTime() { return 0L; }
    public float getAccuracy() { return 0f; }
    public String getProvider() { return null; }
}
