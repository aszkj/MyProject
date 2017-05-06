package com.yldbkd.www.library.android.anim;

import android.animation.Animator;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Matrix;
import android.os.Build;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.util.SparseArray;
import android.util.TypedValue;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewPropertyAnimator;
import android.view.animation.LinearInterpolator;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.yldbkd.www.library.android.R;
import com.yldbkd.www.library.android.common.DisplayUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * 雨的视图
 * <p>
 * Created by linghuxj on 2016/10/9.
 */

public class RainView extends RelativeLayout {

    // @formatter:off
    private static final int[] ATTRS = new int[]{android.R.attr.textSize, android.R.attr.textColor};
    private static final String[] DIRECTIONS = new String[]{"top_to_bottom", "bottom_to_top",
            "left_to_right", "right_to_left"};
    private static final int MAX_COUNT = 5;
    private static final int MARGIN_OFFSET = 160;
    private static final long NORMAL_SPEED = 1500L;
    private static final int SPEED_OFFSET = 1500;
    private static final int DELAY_TIME = 200;
    private static final int DELAY_OFFSET = 400;

    private static final int PADDING = 0;
    private int paddingLAR = 0;

    private RelativeLayout container;
    private Context context;
    private Random random = new Random();

    private int paddingSize = 10;

    private int backgroundColor = R.color.white;
    private int bgResourceId;
    private int resourceId = R.mipmap.processing;
    private String direction = "top_to_bottom";

    private SparseArray<View> childListView = new SparseArray<>();
    private List<Integer> cancelIndexList = new ArrayList<>();

    private int totalIndex = 0;

    private boolean isEnd = false;

    private Handler handler;
    public static final int RAIN_VIEW_CLICK = 0xff;
    public static final int RAIN_VIEW_FINISHED = 0xfd;

    private Handler createHandler = new Handler();

    private Matrix matrix = new Matrix();

    public RainView(Context context) {
        this(context, null);
    }

    public RainView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public RainView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        this.context = context;
        init(context, attrs);
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    public RainView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.context = context;
        init(context, attrs);
    }

    private void init(Context context, AttributeSet attrs) {
        Log.d("RainView", "init is calling ...");

        container = new RelativeLayout(context);
        container.setLayoutParams(new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));
        addView(container);

        DisplayMetrics dm = getResources().getDisplayMetrics();

        paddingSize = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, paddingSize, dm);

        TypedArray array = context.obtainStyledAttributes(attrs, ATTRS);
        array.recycle();

        array = context.obtainStyledAttributes(attrs, R.styleable.RainView);
        backgroundColor = array.getColor(R.styleable.RainView_rv_background_color, ContextCompat.getColor(context, backgroundColor));
        bgResourceId = array.getResourceId(R.styleable.RainView_rv_bg_src, bgResourceId);
        resourceId = array.getResourceId(R.styleable.RainView_rv_src, resourceId);
        direction = array.getString(R.styleable.RainView_rv_anim_direction);
        paddingLAR = array.getDimensionPixelOffset(R.styleable.RainView_rv_padding_lr, PADDING);

        array.recycle();

    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        super.onLayout(changed, l, t, r, b);
        Log.d("RainView", "onLayout is calling ...");
    }

    public void initView() {
        Log.d("RainView", "initView is calling ...");
        createChildView(totalIndex);
        totalIndex++;
        if (isEnd) {
            return;
        }
        createHandler.postDelayed(runnable, random.nextInt(DELAY_OFFSET) + DELAY_TIME);
    }

    private int getRainWidth() {
        int width = this.getWidth();
        width = width - paddingLAR * 2;
        return width;
    }

    private void createChildView(final int index) {
        Log.d("RainView", "createChildView is calling ...");
        RelativeLayout.LayoutParams layoutParams = new LayoutParams(LayoutParams.WRAP_CONTENT,
                LayoutParams.WRAP_CONTENT);

        final ImageView imageView = new ImageView(context);
        imageView.setImageResource(resourceId);
        childListView.append(index, imageView);

        int marginIndex = random.nextInt(MAX_COUNT);
        layoutParams.leftMargin = marginIndex * (getRainWidth() / MAX_COUNT) + (random.nextInt(MARGIN_OFFSET) - MARGIN_OFFSET / 3);
        layoutParams.leftMargin = (layoutParams.leftMargin < 0 ? 0 : layoutParams.leftMargin) + paddingLAR;

        imageView.setLayoutParams(layoutParams);
        imageView.setTag(index);
        container.addView(imageView);

        imageView.setOnTouchListener(new OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (event.getAction() == MotionEvent.ACTION_DOWN) {
                    if (handler != null) {
                        handler.obtainMessage(RAIN_VIEW_CLICK, imageView).sendToTarget();
                    }
                }
                return true;
            }
        });

        startAnim(imageView);
    }

    private void startAnim(View view) {
        Log.d("RainView", "startAnim is calling ...");
        final int index = (int) view.getTag();
        ViewPropertyAnimator animator = view.animate().translationYBy(this.getHeight());

        long speed = random.nextInt(SPEED_OFFSET) + NORMAL_SPEED;
        animator.setDuration(speed);
        animator.setInterpolator(new LinearInterpolator());
        animator.setListener(new Animator.AnimatorListener() {

            @Override
            public void onAnimationStart(Animator animation) {
            }

            @Override
            public void onAnimationEnd(Animator animation) {
                if (!cancelIndexList.contains(index)) {
                    remove(index);
                }
                if (childListView.size() == 0) {
                    container.removeAllViews();
                    cancelIndexList.clear();
                    if (handler == null) {
                        return;
                    }
                    handler.obtainMessage(RAIN_VIEW_FINISHED).sendToTarget();
                }
            }

            @Override
            public void onAnimationCancel(Animator animation) {
                cancelIndexList.add(index);
            }

            @Override
            public void onAnimationRepeat(Animator animation) {
            }
        });
        animator.start();
    }

    public void remove(int index) {
        container.removeView(childListView.get(index));
        childListView.remove(index);
    }

    private Runnable runnable = new Runnable() {
        @Override
        public void run() {
            initView();
        }
    };

    public void setHandler(Handler handler) {
        this.handler = handler;
    }

    public void setEnd(boolean end) {
        isEnd = end;
    }
}
