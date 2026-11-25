package android.graphics;

public final class Gainmap {
    private Bitmap contents;
    private final float[] ratioMin = {1f, 1f, 1f};
    private final float[] ratioMax = {2f, 2f, 2f};
    private final float[] gamma = {1f, 1f, 1f};
    private final float[] epsilonSdr = {1f / 64f, 1f / 64f, 1f / 64f};
    private final float[] epsilonHdr = {1f / 64f, 1f / 64f, 1f / 64f};
    private float displayRatioForFullHdr = 2f;
    private float minDisplayRatioForHdrTransition = 1f;

    public Gainmap() {}

    public Gainmap(Bitmap gainmapContents) {
        this.contents = gainmapContents;
    }

    public Bitmap getGainmapContents() { return contents; }
    public void setGainmapContents(Bitmap bitmap) { this.contents = bitmap; }
    public float[] getRatioMin() { return ratioMin.clone(); }
    public float[] getRatioMax() { return ratioMax.clone(); }
    public float[] getGamma() { return gamma.clone(); }
    public float[] getEpsilonSdr() { return epsilonSdr.clone(); }
    public float[] getEpsilonHdr() { return epsilonHdr.clone(); }
    public void setRatioMin(float red, float green, float blue) {
        ratioMin[0] = red; ratioMin[1] = green; ratioMin[2] = blue;
    }
    public void setRatioMax(float red, float green, float blue) {
        ratioMax[0] = red; ratioMax[1] = green; ratioMax[2] = blue;
    }
    public void setGamma(float red, float green, float blue) {
        gamma[0] = red; gamma[1] = green; gamma[2] = blue;
    }
    public void setEpsilonSdr(float red, float green, float blue) {
        epsilonSdr[0] = red; epsilonSdr[1] = green; epsilonSdr[2] = blue;
    }
    public void setEpsilonHdr(float red, float green, float blue) {
        epsilonHdr[0] = red; epsilonHdr[1] = green; epsilonHdr[2] = blue;
    }
    public void setDisplayRatioForFullHdr(float max) { this.displayRatioForFullHdr = max; }
    public float getDisplayRatioForFullHdr() { return displayRatioForFullHdr; }
    public void setMinDisplayRatioForHdrTransition(float min) { this.minDisplayRatioForHdrTransition = min; }
    public float getMinDisplayRatioForHdrTransition() { return minDisplayRatioForHdrTransition; }
}
