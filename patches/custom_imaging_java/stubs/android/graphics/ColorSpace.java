package android.graphics;

public class ColorSpace {
    public enum Named {
        SRGB,
        DISPLAY_P3,
        BT2020_HLG
    }

    private static final ColorSpace SRGB_INSTANCE = new ColorSpace(Named.SRGB);
    private static final ColorSpace DISPLAY_P3_INSTANCE = new ColorSpace(Named.DISPLAY_P3);
    private static final ColorSpace BT2020_HLG_INSTANCE = new ColorSpace(Named.BT2020_HLG);

    private final Named named;

    private ColorSpace(Named named) {
        this.named = named;
    }

    public static ColorSpace get(Named name) {
        if (name == Named.DISPLAY_P3) return DISPLAY_P3_INSTANCE;
        if (name == Named.BT2020_HLG) return BT2020_HLG_INSTANCE;
        return SRGB_INSTANCE;
    }

    public String getName() {
        return named.name();
    }

    public boolean isWideGamut() {
        return named != Named.SRGB;
    }
}
