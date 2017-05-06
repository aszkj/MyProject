package com.yldbkd.www.library.android.banner;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.Interpolator;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Scroller;
import com.yldbkd.www.library.android.R;
import com.yldbkd.www.library.android.common.DisplayUtils;

import java.lang.ref.WeakReference;
import java.lang.reflect.Field;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

/**
 * 基于ViewPager的轮播图
 * <p/>
 * Created by linghuxj on 2015/9/28.
 */
public class BannerView<T extends BannerBean> extends LinearLayout {

    private static final float BANNER_HEIGHT_SCALE = 0.422f; // 默认比例

    private static final long BANNER_INTERVAL = 3000;

    private Context context;
    private ViewPager imagePager;
    private ViewGroup label;
    private Handler handler;
    private Timer bannerTimer;
    private TimerTask bannerTimerTask;
    private List<T> list;

    private RelativeLayout layout;

    private float bannerHeightScale;

    private Activity getActivity(Context context) {
        return ((Activity) context);
    }

    public BannerView(Context context) {
        super(context);
        this.context = context;
    }

    public BannerView(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.context = context;
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.banner_view, this);
        initView(context);
        handler = new CheckHandler(this);
        bannerTimer = new Timer();
    }

    private void initView(Context context) {
        layout = (RelativeLayout) this.findViewById(R.id.banner_layout);

        imagePager = (CustomViewPager) this.findViewById(R.id.banner_image);

        // 设置滑动速度
        try {
            FixedSpeedScroller mScroller = new FixedSpeedScroller(imagePager.getContext(),
                    new AccelerateInterpolator());
            Field field = ViewPager.class.getDeclaredField("mScroller");
            field.setAccessible(true);
            field.set(imagePager, mScroller);
        } catch (NoSuchFieldException e) {
            Log.e("BannerView", "轮播滑动速度出现异常" + e);
            return;
        } catch (IllegalAccessException e) {
            Log.e("BannerView", "轮播滑动速度出现异常" + e);
        }

        label = (ViewGroup) this.findViewById(R.id.banner_label);

        DisplayMetrics dm = new DisplayMetrics();
        getActivity(context).getWindowManager().getDefaultDisplay()
                .getMetrics(dm);

        imagePager.setOnTouchListener(new OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                switch (motionEvent.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                    case MotionEvent.ACTION_MOVE:
                        stopPlay();
                        break;
                    case MotionEvent.ACTION_UP:
                        startPlay();
                        break;
                    default:
                        startPlay();
                        break;
                }
                return false;
            }
        });
    }

    /**
     * 加载Adapter数据和轮播标识小图标
     *
     * @param adapter Adapter
     * @param list    轮播BEAN的list
     */
    public void setAdapter(BannerViewAdapter adapter, List<T> list) {
        LayoutParams params = (LayoutParams) layout
                .getLayoutParams();
        DisplayUtils.getPixelDisplayMetricsII(getActivity(context));
        if (params != null) {
            params.height = (int) (DisplayUtils.screenWidth * getBannerHeightScale());
            layout.setLayoutParams(params);
        }
        this.list = list;
        // 加载圆点或者其他图形到banner
        final int count = list.size();
        final ImageView[] imageViews = new ImageView[count];
        if (label.getChildCount() > 0) {
            label.removeAllViews();
        }
        if (count <= 1) {
            label.setVisibility(INVISIBLE);
        } else {
            label.setVisibility(VISIBLE);
        }
        for (int i = 0; i < count; i++) {
            LayoutParams pm = new LayoutParams(
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT);
            pm.setMargins(20, 0, 0, 0);
            ImageView imageView = new ImageView(context);
            imageView.setLayoutParams(new LayoutParams(15, 15));
            imageViews[i] = imageView;
            if (i == 0) {
                imageViews[i].setBackgroundResource(R.mipmap.banner_label_focused);
            } else {
                imageViews[i].setBackgroundResource(R.mipmap.banner_label_unfocused);
            }
            label.addView(imageViews[i], pm);
        }

        imagePager.setAdapter(adapter);
        if (count > 1) {
            imagePager.setCurrentItem(count * 100);
        }
        imagePager
                .setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
                    @Override
                    public void onPageScrolled(int i, float v, int i2) {
                    }

                    @Override
                    public void onPageSelected(int i) {
                        for (int j = 0; j < count; j++) {
                            if (j == (i % count)) {
                                imageViews[j].setBackgroundResource(R.mipmap.banner_label_focused);
                            } else {
                                imageViews[j].setBackgroundResource(R.mipmap.banner_label_unfocused);
                            }
                        }
                    }

                    @Override
                    public void onPageScrollStateChanged(int i) {
                    }
                });
    }

    public BannerViewAdapter getAdapter() {
        return (BannerViewAdapter) imagePager.getAdapter();
    }

    /**
     * 启动轮播
     */
    public void startPlay() {
        if (bannerTimer != null) {
            if (bannerTimerTask != null) {
                bannerTimerTask.cancel();
            }
            bannerTimerTask = new BannerTimerTask();
            bannerTimer.schedule(bannerTimerTask, BANNER_INTERVAL,
                    BANNER_INTERVAL);
        }
    }

    /**
     * 暂停轮播
     */
    public void stopPlay() {
        if (bannerTimerTask != null) {
            bannerTimerTask.cancel();
        }
    }

    public float getBannerHeightScale() {
        if (bannerHeightScale == 0.0f) {
            bannerHeightScale = BANNER_HEIGHT_SCALE;
        }
        return bannerHeightScale;
    }

    public void setBannerHeightScale(float bannerHeightScale) {
        this.bannerHeightScale = bannerHeightScale;
    }

    /**
     * 自动轮播作业
     */
    class BannerTimerTask extends TimerTask {

        @Override
        public void run() {
            Message msg = new Message();
            if (list == null || list.size() <= 1) {
                return;
            }
            int currentItem = imagePager.getCurrentItem();
            if (currentItem == list.size() - 1) {
                msg.what = 0;
            } else {
                msg.what = currentItem + 1;
            }
            handler.sendMessage(msg);
        }
    }

    static class CheckHandler extends Handler {
        private WeakReference<BannerView> bannerViewWeakReference;

        public CheckHandler(BannerView bannerView) {
            bannerViewWeakReference = new WeakReference<>(bannerView);
        }

        @Override
        public void handleMessage(Message msg) {
            BannerView bannerView = bannerViewWeakReference.get();
            if (bannerView == null) {
                return;
            }
            bannerView.setItem(msg.what);
        }
    }

    public void setItem(int currentId) {
        imagePager.setCurrentItem(currentId);
    }

    private class FixedSpeedScroller extends Scroller {

        private int mDuration = 300; // 默认滑动时间为0.5S

        public FixedSpeedScroller(Context context) {
            super(context);
        }

        public FixedSpeedScroller(Context context, Interpolator interpolator) {
            super(context, interpolator);
        }

        public FixedSpeedScroller(Context context, Interpolator interpolator, boolean flywheel) {
            super(context, interpolator, flywheel);
        }

        @Override
        public void startScroll(int startX, int startY, int dx, int dy) {
            super.startScroll(startX, startY, dx, dy, mDuration);
        }

        @Override
        public void startScroll(int startX, int startY, int dx, int dy, int duration) {
            super.startScroll(startX, startY, dx, dy, mDuration);
        }

        public int getmDuration() {
            return mDuration;
        }

        public void setmDuration(int mDuration) {
            this.mDuration = mDuration;
        }
    }
}
