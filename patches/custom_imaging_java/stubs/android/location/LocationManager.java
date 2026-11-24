package android.location;

import java.util.Collections;
import java.util.List;

public abstract class LocationManager {
    public static final String GPS_PROVIDER = "gps";
    public static final String NETWORK_PROVIDER = "network";
    public static final String PASSIVE_PROVIDER = "passive";
    public static final String FUSED_PROVIDER = "fused";

    public Location getLastKnownLocation(String provider) { return null; }
    public List<String> getProviders(boolean enabledOnly) { return Collections.emptyList(); }
    public boolean isProviderEnabled(String provider) { return false; }
}
