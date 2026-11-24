// SPDX-License-Identifier: MIT
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { after, before, test } from 'node:test';
import { fileURLToPath } from 'node:url';
import { resolveJava } from '../scripts/env_paths.mjs';

const tree = fileURLToPath(new URL('../patches/custom_imaging_java/', import.meta.url));
const src = join(tree, 'src/com/motorola/camera/custom');
const java = resolveJava();
const javac = join(dirname(java), process.platform === 'win32' ? 'javac.exe' : 'javac');
let classes;

function run(executable, args) {
  const result = spawnSync(executable, args, { encoding: 'utf8', timeout: 60_000, windowsHide: true });
  assert.ifError(result.error);
  assert.equal(result.status, 0, result.stdout + result.stderr);
  return result.stdout.trim();
}

const probe = String.raw`import com.motorola.camera.custom.MultiFrameRawEngine;
import com.motorola.camera.custom.MultiFrameRawEngine.FrameInput;
import com.motorola.camera.custom.MultiFrameRawEngine.Result;
import com.motorola.camera.custom.CleanBayerRawProcessor;
import static com.motorola.camera.custom.MultiFrameRawEngine.*;
import java.util.Arrays;
import java.util.Locale;
import java.util.Random;

public final class BurstChecks {
    static final int W=160, H=96, WHITE=4095;
    static final float[] BLACK={59,73,64,80};
    static final long BASE=4_000_000;
    static final int[] PHASE_COLOR={0,1,1,2};
    interface Scene { double at(double x,double y,int phase); }
    static void ok(boolean b,String msg){if(!b) throw new AssertionError(msg);}
    static void near(double a,double b,double eps,String msg){ok(Math.abs(a-b)<=eps,msg+" "+a+" vs "+b);}
    static void reject(Runnable r){
        try { r.run(); } catch(IllegalArgumentException ex){return;}
        throw new AssertionError("invalid input accepted");
    }
    static int site(int x,int y){return 2*(y&1)+(x&1);}
    static double baseTexture(double x,double y) {
        return .055*Math.sin(.19*x+.11*y)+.06*Math.cos(.13*x-.21*y)+.04*Math.sin(.09*x+.027*y);
    }
    // Independently render each photosite under physical camera translation, ADC pedestal and shutter time.
    static FrameInput exposure(Scene scene,double dx,double dy,double evScale,double noise,
                               long id,float gyro) {
        Random rng=new Random(7101+id);
        int[] raw=new int[W*H];
        for(int y=0;y<H;y++)for(int x=0;x<W;x++){
            int p=site(x,y);
            double dn=BLACK[p]+(WHITE-BLACK[p])*evScale*scene.at(x-dx,y-dy,p)+noise*rng.nextGaussian();
            raw[y*W+x]=(int)Math.round(Math.max(0,Math.min(WHITE,dn)));
        }
        return new FrameInput(raw,W,H,0,BLACK,WHITE,id,Math.round(evScale*BASE),100,gyro,1000);
    }
    static double decoded(Result r,int x,int y){
        int p=site(x,y);
        return (r.raw[y*r.width+x]-r.blackLevel4[p])/(r.whiteLevel-r.blackLevel4[p])*r.headroom;
    }
    static double nativeSample(FrameInput f,int x,int y) {
        int p=site(x,y);
        return (f.raw[y*f.width+x]-f.blackLevel4[p])/(f.whiteLevel-f.blackLevel4[p]);
    }
    static void hdr(){
        Scene truth=(x,y,p)->.145+.65*baseTexture(x,y)+.018*PHASE_COLOR[p]
            +(x>92+.09*y ? .46 : 0);
        int[][] shift={{0,0},{4,-2},{-4,2},{2,4},{-2,-4},{6,2}};
        MultiFrameRawEngine engine=new MultiFrameRawEngine(MODE_HDR_PLUS,6);
        FrameInput[] burst=new FrameInput[6];
        for(int i=0;i<6;i++){
            final int n=i;
            Scene moving=(x,y,p)->(n>0 && x>=53+n && x<77+n && y>=40 && y<62) ? .90 : truth.at(x,y,p);
            burst[i]=exposure(moving,shift[i][0],shift[i][1],1,40,50+i,0);
            engine.addFrame(burst[i]);
        }
        Result r=engine.mergeOnCurrentGlContext();
        ok(!r.usedGlGuide && r.acceptedFrames==6 && r.anchorTimestampNs==50,"headless/reference selection");
        double anchorError=0, mergedError=0, edgeError=0, unalignedError=0, ghost=0; int patch=0;
        for(int y=10;y<H-10;y++)for(int x=10;x<W-10;x++){
            double v=truth.at(x,y,site(x,y)), err=decoded(r,x,y)-v;
            if(x<52){anchorError+=Math.pow(nativeSample(burst[0],x,y)-v,2);mergedError+=err*err;}
            if(Math.abs(x-92-.09*y)<4){
                double mean=0;
                for(FrameInput f:burst) mean+=nativeSample(f,x,y)/6;
                unalignedError+=(mean-v)*(mean-v);edgeError+=err*err;
            }
            if(x>=62 && x<75 && y>=43 && y<58){ghost+=Math.abs(err);patch++;}
        }
        double gain=10*Math.log10(anchorError/mergedError);
        System.out.printf(Locale.ROOT,"HDR shadow gain %.2f dB, moving-patch MAE %.5f%n",gain,ghost/patch);
        ok(gain>=4,"shadow SNR gain "+gain);
        ok(ghost/patch < .014,"ghost leaked onto anchor");
        ok(edgeError < .20*unalignedError,"static edge is still misregistered");
    }
    static void aeb(){
        Scene wedge=(x,y,p)-> x<50 ? .065 : x<82 ? .52 : x<119 ? 1.40 : 2.45;
        MultiFrameRawEngine e=new MultiFrameRawEngine(MODE_RAW_AEB,3);
        FrameInput base=exposure(wedge,0,0,1,19,21,0);
        e.addFrame(exposure(wedge,0,0,.25,19,20,0));e.addFrame(base);
        e.addFrame(exposure(wedge,0,0,4,19,22,0));
        Result r=e.merge();
        ok(r.anchorTimestampNs==21 && r.headroom==4,"bracket anchor/headroom");
        double b=0,m=0,bright1=0,bright2=0;int n=0;
        for(int y=15;y<75;y++)for(int x=10;x<40;x++){
            double a=nativeSample(base,x,y)-.065, c=decoded(r,x,y)-.065;
            b+=a*a;m+=c*c;
            bright1+=decoded(r,x+76,y);bright2+=decoded(r,x+111,y);n++;
        }
        near(bright1/n,1.40,.012,"first clipped step");
        near(bright2/n,2.45,.012,"second clipped step");
        ok(m < .22*b,"long frame did not reduce shadow noise");
        ok(r.raw[48*W+140]>WHITE,"lost above-anchor linear codes");
        System.out.printf(Locale.ROOT,"AEB highlight steps %.3f / %.3f, shadow gain %.2f dB%n",bright1/n,bright2/n,10*Math.log10(b/m));
    }

    // Bilinear single-plane upsampling oracle, independent of the production registration/reconstruction.
    static double upscale(FrameInput f,double x,double y,int p) {
        int x0=2*(int)Math.floor((x-(p&1))/2)+(p&1), y0=2*(int)Math.floor((y-p/2)/2)+p/2;
        double u=(x-x0)/2, v=(y-y0)/2;
        return (1-v)*((1-u)*nativeSample(f,x0,y0)+u*nativeSample(f,x0+2,y0))
                  +v*((1-u)*nativeSample(f,x0,y0+2)+u*nativeSample(f,x0+2,y0+2));
    }
    static void sr(){
        // 0.31 cycles/native pixel is above a same-color Bayer plane's 0.25 Nyquist frequency.
        // Smooth lower-frequency structure independently supports registration on both axes.
        Scene chart=(x,y,p)->.44+baseTexture(x,y)+.04*PHASE_COLOR[p]
            +(x<99 ? .095*Math.sin(2*Math.PI*(.31*x+.012*y)) : (x>124+.11*y ? .13 : -.13));
        double[][] offsets={{0,0},{.8,.15},{-.55,.9},{1.4,-.95},{-1.1,-.65},{.25,1.4},{1.9,.82},{-.92,1.85}};
        MultiFrameRawEngine e=new MultiFrameRawEngine(MODE_SUPER_RES,8);
        FrameInput anchor=null;
        for(int i=0;i<offsets.length;i++){
            FrameInput f=exposure(chart,offsets[i][0],offsets[i][1],1,0,100+i,0);
            if(i==0)anchor=f;
            e.addFrame(f);
        }
        Result r=e.merge();
        ok(r.width==240 && r.height==144 && r.superResolved,"resolution/phase diversity");
        double srErr=0,baseErr=0,srSine=0,baseSine=0,edgeSR=0,edgeBase=0;
        for(int y=15;y<r.height-15;y++)for(int x=15;x<r.width-15;x++){
            double sx=(x+.5)/1.5-.5, sy=(y+.5)/1.5-.5;
            int p=site(x,y);
            double ideal=chart.at(sx,sy,p), single=upscale(anchor,sx,sy,p), fused=decoded(r,x,y);
            if(sx<90){
                double wave=Math.sin(2*Math.PI*(.31*sx+.012*sy));
                double low=.44+baseTexture(sx,sy)+.04*PHASE_COLOR[p];
                srErr+=(fused-ideal)*(fused-ideal);baseErr+=(single-ideal)*(single-ideal);
                srSine+=(fused-low)*wave;baseSine+=(single-low)*wave;
            }
            if(Math.abs(sx-124-.11*sy)<2){
                edgeSR+=(fused-ideal)*(fused-ideal);edgeBase+=(single-ideal)*(single-ideal);
            }
        }
        System.out.printf(Locale.ROOT,"SR grating RMSE ratio %.3f, true-frequency contrast %.2fx, slanted-edge RMSE ratio %.3f%n",
                Math.sqrt(srErr/baseErr),srSine/baseSine,Math.sqrt(edgeSR/edgeBase));
        ok(srErr<.75*baseErr && srSine>1.3*baseSine,"no additional resolved signal");
        ok(edgeSR<edgeBase,"slanted edge acuity regressed");
        int[] argb=CleanBayerRawProcessor.processRawToArgb(r.raw,r.width,r.height,r.cfaPattern,
                r.blackLevel4,r.whiteLevel,new float[]{1,1,1},null,0);
        ok(argb.length==r.width*r.height,"downstream demosaic");
    }
    static void focus(){
        Scene detail=(x,y,p)->.115*Math.sin(.63*x+.23*y)+.062*Math.cos(.57*y-.2*x);
        Scene sharp=(x,y,p)->.40+baseTexture(x,y)+detail.at(x,y,p);
        MultiFrameRawEngine e=new MultiFrameRawEngine(MODE_FOCUS_STACK,2);
        for(int i=0;i<2;i++){
            final int plane=i;
            Scene image=(x,y,p)->.40+baseTexture(x,y)+((x<80)==(plane==0)?1:.1)*detail.at(x,y,p);
            e.addFrame(exposure(image,i*2,0,1,0,30+i,0));
        }
        Result r=e.merge();
        double[] error={0,0},energy={0,0};
        for(int y=12;y<H-12;y++)for(int x=12;x<W-12;x++){
            if(Math.abs(x-80)<17)continue;
            int side=x<80?0:1;
            double v=sharp.at(x,y,site(x,y)), diff=decoded(r,x,y)-v;
            error[side]+=diff*diff;energy[side]+=Math.pow(detail.at(x,y,site(x,y)),2);
        }
        for(int i=0;i<2;i++)ok(error[i]<.04*energy[i],"lost detail on plane "+i);
    }
    static void nd(){
        MultiFrameRawEngine e=new MultiFrameRawEngine(MODE_SYNTHETIC_ND,4);
        int[] shifts={0,2,-2,4};
        for(int i=0;i<4;i++){
            final int streak=36+i*12;
            Scene scene=(x,y,p)-> .29+baseTexture(x,y)+.03*PHASE_COLOR[p]
                +(x>=streak && x<streak+6 && y>=30 && y<56 ? .50 : 0);
            e.addFrame(exposure(scene,shifts[i],0,1,0,40+i,0));
        }
        Result r=e.merge();
        double trail=0,bg=0;int nt=0,nb=0;
        for(int y=12;y<82;y++)for(int x=12;x<144;x++){
            boolean lit=x>=36 && x<78 && (x-36)%12<6 && y>=30 && y<56;
            double err=decoded(r,x,y)-(.29+baseTexture(x,y)+.03*PHASE_COLOR[site(x,y)]+(lit?.125:0));
            if(lit){trail+=err*err;nt++;}else{bg+=err*err;nb++;}
        }
        ok(Math.sqrt(trail/nt)<.012 && Math.sqrt(bg/nb)<.006,"unequal temporal weights or background drift");
    }
    static FrameInput small(int[] data,int w,int h,int cfa,long t,float blur){
        return new FrameInput(data,w,h,cfa,new float[]{0,0,0,0},1023,t,100,100,blur,1);
    }
    static int[] constant(int size,int dn){int[] a=new int[size];Arrays.fill(a,dn);return a;}
    static void ring(){
        MultiFrameRawEngine e=new MultiFrameRawEngine(MODE_SYNTHETIC_ND,3);
        int[] owned=constant(24,100);
        e.addFrame(small(owned,6,4,3,1,.75f)); Arrays.fill(owned,999);
        e.addFrame(small(constant(24,200),6,4,3,2,.751f));
        e.addFrame(small(constant(24,400),6,4,3,3,Float.NaN));
        Result r=e.merge();
        ok(r.raw[0]==250 && r.acceptedFrames==2 && r.anchorTimestampNs==1,"blur boundary or caller ownership");
        e.addFrame(small(constant(24,600),6,4,3,4,1.5f));
        ok(e.size()==3 && e.merge().raw[0]==400,"oldest did not evict");
        e.clear();ok(e.size()==0,"clear");
        for(int i=0;i<3;i++)e.addFrame(small(constant(24,100+i),6,4,3,i+5,new float[]{1.4f,1.0f,1.2f}[i]));
        r=e.merge();ok(r.acceptedFrames==1 && r.raw[7]==101,"all-rejected best anchor");
        MultiFrameRawEngine sr=new MultiFrameRawEngine(MODE_SUPER_RES,2);
        for(int i=0;i<2;i++)sr.addFrame(small(constant(70,207),7,10,1,i,0));
        r=sr.merge();
        ok(r.width==8 && r.height==14 && !r.superResolved,"odd input / rounded output / duplicate frames");
        for(int dn:r.raw)ok(dn==207,"CFA border");
    }
    static void calibration(){
        int w=10,h=8;
        double[] light={.11,.32,.47,.75};
        for(int cfa=0;cfa<4;cfa++)for(int mode=1;mode<=5;mode++){
            MultiFrameRawEngine e=new MultiFrameRawEngine(mode,2);
            for(int i=0;i<2;i++){
                float[] pedestal=i==0?new float[]{35.4f,49,71,8}:new float[]{82,16,9,88};
                float white=i==0?2047:4095;
                int[] data=new int[w*h];
                for(int j=0;j<data.length;j++){
                    int p=site(j%w,j/w);
                    data[j]=(int)Math.round(pedestal[p]+light[p]*(white-pedestal[p]));
                }
                e.addFrame(new FrameInput(data,w,h,cfa,pedestal,white,i,BASE,100,0,1000));
                Arrays.fill(pedestal,1500);
            }
            Result r=e.merge();
            ok(r.cfaPattern==cfa,"CFA metadata");
            for(int y=0;y<r.height;y++)for(int x=0;x<r.width;x++)
                near(decoded(r,x,y),light[site(x,y)],.001,"phase / pedestal contamination");
        }
        MultiFrameRawEngine e=new MultiFrameRawEngine(MODE_SYNTHETIC_ND,3);
        float[] black={64.4f,64.4f,64.4f,64.4f};
        e.addFrame(new FrameInput(constant(8,0),4,2,0,black,1023,1,BASE,100,.00075f,1000));
        e.addFrame(new FrameInput(constant(8,1000),4,2,0,black,1023,2,BASE,100,.0008f,1000));
        Result r=e.merge();
        ok(r.acceptedFrames==1 && r.raw[0]==65,"pixel-unit blur threshold or fractional black floor");
    }
    static void invalid(){
        reject(()->new MultiFrameRawEngine(6,1));reject(()->new MultiFrameRawEngine(1,0));
        reject(()->new MultiFrameRawEngine(1,9));
        MultiFrameRawEngine e=new MultiFrameRawEngine(MODE_HDR_PLUS,2);
        try{e.merge();throw new AssertionError("empty merge");}catch(IllegalStateException expected){}
        reject(()->e.addFrame(null));reject(()->e.addFrame(small(null,4,2,0,0,0)));
        for(int[] wh:new int[][]{{2,4},{4,1},{4,3},{-4,2},{Integer.MAX_VALUE,4}})
            reject(()->e.addFrame(small(new int[8],wh[0],wh[1],0,0,0)));
        reject(()->e.addFrame(small(new int[7],4,2,0,0,0)));
        reject(()->e.addFrame(small(new int[8],4,2,4,0,0)));
        reject(()->e.addFrame(small(new int[8],4,2,0,0,-.1f)));
        for(float[] black:new float[][]{null,{0,0,0},{0,0,0,Float.NaN},{0,0,0,1023}})
            reject(()->e.addFrame(new FrameInput(new int[8],4,2,0,black,1023,0,10,100,0,1)));
        for(float white:new float[]{0,Float.NaN,Float.POSITIVE_INFINITY,65536})
            reject(()->e.addFrame(new FrameInput(new int[8],4,2,0,BLACK,white,0,10,100,0,1)));
        reject(()->e.addFrame(new FrameInput(new int[8],4,2,0,BLACK,1023,0,0,100,0,1)));
        reject(()->e.addFrame(new FrameInput(new int[8],4,2,0,BLACK,1023,0,10,0,0,1)));
        // Preflight before dereferencing a large input or allocating an output.
        for(int mode:new int[]{MODE_HDR_PLUS,MODE_RAW_AEB,MODE_FOCUS_STACK,MODE_SYNTHETIC_ND,MODE_SUPER_RES}){
            MultiFrameRawEngine large=new MultiFrameRawEngine(mode,8);
            try {large.addFrame(small(new int[1],10000,8000,0,0,0));throw new AssertionError("cap");}
            catch(IllegalArgumentException expected){ok(expected.getMessage().contains("memory cap"),"wrong limit");}
        }
        ok(MultiFrameRawEngine.estimatedPeakBytes(MODE_SUPER_RES,4088,3068,8)<=420L*1024*1024,"binned SR budget");
        // At 30 MP the SR output alone costs 270 MB. Ring + guides + output
        // exceed 320 MiB but fit 420 MiB. The next validation must be raw length.
        try {new MultiFrameRawEngine(MODE_SUPER_RES,1).addFrame(small(new int[1],6000,5000,0,0,0));
             throw new AssertionError("short plane");}
        catch(IllegalArgumentException expected){ok(expected.getMessage().contains("descriptor"),"premature SR cap");}
        // At 42 MP the HDR ingestion/eviction peak crosses 320 MiB, below the SR cap.
        try {new MultiFrameRawEngine(MODE_HDR_PLUS,1).addFrame(small(new int[1],7000,6000,0,0,0));
             throw new AssertionError("HDR cap");}
        catch(IllegalArgumentException expected){ok(expected.getMessage().contains("memory cap"),"missing HDR-specific cap");}
        e.addFrame(small(constant(8,10),4,2,0,5,0));
        reject(()->e.addFrame(small(constant(8,20),4,2,0,5,0)));
        reject(()->e.addFrame(small(constant(8,20),4,2,1,6,0)));
        reject(()->e.addFrame(small(constant(16,20),4,4,0,6,0)));
        reject(()->e.addFrame(small(constant(8,65536),4,2,0,6,0)));
        ok(e.size()==1 && e.merge().raw[0]==10,"partial add changed ring");
    }
    public static void main(String[] args){
        switch(args[0]){
            case "hdr":hdr();break;case "aeb":aeb();break;case "sr":sr();break;
            case "calibration":calibration();break;case "focus":focus();break;case "nd":nd();break;case "ring":ring();break;case "invalid":invalid();break;
            default:throw new IllegalArgumentException(args[0]);
        }
    }
}
`;

before(() => {
  classes = mkdtempSync(join(tmpdir(), 'multiframe-raw-'));
  const runner = join(classes, 'BurstChecks.java');
  writeFileSync(runner, probe);
  run(javac, ['--release', '11', '-sourcepath', join(tree, 'stubs'), '-d', classes,
    join(src, 'CleanBayerRawProcessor.java'), join(src, 'MultiFrameRawEngine.java'), runner]);
});
after(() => { if (classes) rmSync(classes, { recursive: true, force: true }); });

for (const [op, title] of Object.entries({
  hdr: 'HDR+ improves shadow SNR by 4 dB and rejects moving outliers on shifted RAWs',
  aeb: 'RAW AEB recovers two clipped steps and uses the long exposure for shadows',
  sr: '1.5x CFA reconstruction resolves a grating and a slanted edge over single-frame upscale',
  focus: 'focus stack recovers both depth regions after translation',
  nd: 'synthetic ND preserves a registered background and uniformly integrates a moving light',
  ring: 'blur gate, ownership, eviction, fallback and rounded SR dimensions',
  calibration: 'all CFA patterns preserve site pedestals, and gyro rejection uses focal length in pixels',
  invalid: 'invalid input and memory overflow are rejected before ring mutation',
})) {
  test(title, t => {
    const metrics = run(java, ['-Xmx96m', '-cp', classes, 'BurstChecks', op]);
    if (metrics) t.diagnostic(metrics);
  });
}
