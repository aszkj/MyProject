package com.yldbkd.www.buyer.android.utils;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.graphics.Point;
import android.os.Build;
import android.view.Display;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.*;
import android.view.animation.Animation.AnimationListener;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;

public class AnimUtils {

    public static void setAddCartAnim(final BaseActivity activity, final int[] start_location,
                                      final int[] end_location, final ImageView bgView, final TextView textView,
                                      final View layoutView) {
        ViewGroup animMaskLayout = createAnimLayout(activity);
        final ImageView v = new ImageView(activity);
        v.setBackgroundResource(R.mipmap.cart_num_bg);
        v.setAdjustViewBounds(true);
        v.setScaleType(ScaleType.CENTER_INSIDE);
        animMaskLayout.addView(v);// 把动画添加到动画层
        final View view = addViewToAnimLayout(activity, animMaskLayout, v, start_location);
        // 计算位移
        final int endX = end_location[0] - start_location[0]; // 动画位移的X坐标
        final int endY = end_location[1] - start_location[1];// 动画位移的y坐标
        final int halfHeight = activity.getWindowManager().getDefaultDisplay().getHeight() / 2;
        final int halfWidth = activity.getWindowManager().getDefaultDisplay().getWidth() / 2;
        //if (start_location[1] < halfHeight) {
        AnimationSet set = new AnimationSet(false);
        TranslateAnimation translateAnimationX = new TranslateAnimation(0,
                endX, 0, 0);
        translateAnimationX.setInterpolator(new LinearInterpolator());
        translateAnimationX.setRepeatCount(0);// 动画重复执行的次数
        translateAnimationX.setFillAfter(true);

        TranslateAnimation translateAnimationY = new TranslateAnimation(0,
                0, 0, endY);
        MyInterpolator interpolator = new MyInterpolator(2);
        translateAnimationY.setInterpolator(interpolator);
        translateAnimationY.setRepeatCount(0);// 动画重复执行的次数
        translateAnimationX.setFillAfter(true);

        set.setFillAfter(false);
        set.addAnimation(translateAnimationY);
        set.addAnimation(translateAnimationX);
        set.setDuration(500);// 动画的执行时间
        view.startAnimation(set);
        // 动画监听事件
        set.setAnimationListener(new AnimationListener() {
            // 动画的开始
            @Override
            public void onAnimationStart(Animation animation) {
                v.setVisibility(View.VISIBLE);
            }

            @Override
            public void onAnimationRepeat(Animation animation) {
            }

            // 动画的结束
            @Override
            public void onAnimationEnd(Animation animation) {
                v.setVisibility(View.GONE);
                Integer count = CartUtils.getCartCount();
                if (count > 0) {
                    bgView.setVisibility(View.VISIBLE);
                    textView.setVisibility(View.VISIBLE);
                    if (layoutView != null) {
                        layoutView.setBackgroundResource(R.drawable.cart_full_selector);
                    }
                    if (count > 99) {
                        textView.setText(activity.getString(R.string.num_too_much));
                        textView.setTextSize(5f);
                    } else {
                        textView.setText(String.valueOf(count));
                        textView.setTextSize(10f);
                    }
                } else {
                    bgView.setVisibility(View.INVISIBLE);
                    textView.setVisibility(View.INVISIBLE);
                    if (layoutView != null) {
                        layoutView.setBackgroundResource(R.drawable.cart_none_selector);
                    }
                }
            }
        });
    }

    @SuppressWarnings("deprecation")
    @SuppressLint("NewApi")
    private static View addViewToAnimLayout(final Activity activity, final ViewGroup viewGroup, final View view
            , int[] location) {
        int x = location[0];
        int y = location[1];
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT);
        lp.leftMargin = x;
        lp.topMargin = y;
        int screenHeight = 0;
        Display display = activity.getWindowManager().getDefaultDisplay();
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.HONEYCOMB_MR1) {
            Point size = new Point();
            display.getSize(size);
            screenHeight = size.y;
        } else {
            screenHeight = display.getHeight();
        }
        lp.bottomMargin = screenHeight - (y + activity.getResources().getDrawable(R.mipmap.cart_num_bg)
                .getIntrinsicHeight());
        view.setLayoutParams(lp);
        return view;
    }

    static class MyInterpolator implements Interpolator {
        private float mFactor;
        private int i;

        public MyInterpolator(int i) {
            this.i = i;
        }

        @Override
        public float getInterpolation(float input) {
            switch (i) {
                case 1:
                    mFactor = input;
                    break;
                case 2:
                    mFactor = input * input * input;
                    break;
            }
            return mFactor;
        }
    }

    private static ViewGroup createAnimLayout(Activity activity) {
        ViewGroup rootView = (ViewGroup) activity.getWindow().getDecorView();
        LinearLayout animLayout = new LinearLayout(activity);
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT);
        animLayout.setLayoutParams(lp);
        animLayout.setId(Integer.MAX_VALUE - 1);
        animLayout.setBackgroundResource(android.R.color.transparent);
        rootView.addView(animLayout);
        return animLayout;
    }
}
