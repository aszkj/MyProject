package com.yldbkd.www.library.android.pullRefresh;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.Interpolator;
import android.view.animation.LinearInterpolator;
import android.view.animation.RotateAnimation;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.yldbkd.www.library.android.R;

import in.srain.cube.views.ptr.PtrFrameLayout;
import in.srain.cube.views.ptr.PtrUIHandler;
import in.srain.cube.views.ptr.indicator.PtrIndicator;

/**
 * 下拉刷新头部定义的View
 * <p/>
 * Created by linghuxj on 15/12/17.
 */
public class RefreshHeaderHandler extends FrameLayout implements PtrUIHandler {

    static final int DEFAULT_ROTATION_ANIMATION_DURATION = 150;

    private ViewGroup header;
    private ImageView headerImage;
    private ProgressBar headerProgress;
    private TextView headerText;

    private Animation rotateAnimation, resetRotateAnimation;
    private boolean start = false, begin = false;

    private static final int UP = 1, DOWN = 2;

    public RefreshHeaderHandler(Context context) {
        super(context);
        initView(context);
    }

    public RefreshHeaderHandler(Context context, AttributeSet attrs) {
        super(context, attrs);
        initView(context);
    }

    public RefreshHeaderHandler(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initView(context);
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    public RefreshHeaderHandler(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        initView(context);
    }

    private void initView(Context context) {
        header = (ViewGroup) LayoutInflater.from(context).inflate(R.layout.pull_to_refresh_header, this);
        headerText = (TextView) header.findViewById(R.id.pull_to_refresh_text);
        headerImage = (ImageView) header.findViewById(R.id.pull_to_refresh_image);
        headerProgress = (ProgressBar) header.findViewById(R.id.pull_to_refresh_progress);

        final Interpolator interpolator = new LinearInterpolator();
        rotateAnimation = new RotateAnimation(0, -180, Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF,
                0.5f);
        rotateAnimation.setInterpolator(interpolator);
        rotateAnimation.setDuration(DEFAULT_ROTATION_ANIMATION_DURATION);
        rotateAnimation.setFillAfter(true);

        resetRotateAnimation = new RotateAnimation(-180, 0, Animation.RELATIVE_TO_SELF, 0.5f,
                Animation.RELATIVE_TO_SELF, 0.5f);
        resetRotateAnimation.setInterpolator(interpolator);
        resetRotateAnimation.setDuration(DEFAULT_ROTATION_ANIMATION_DURATION);
        resetRotateAnimation.setFillAfter(true);

        switch (2) {
            case UP:
                headerImage.setImageResource(R.mipmap.pulltorefresh_up_arrow);
                break;
            case DOWN:
            default:
                headerImage.setImageResource(R.mipmap.pulltorefresh_down_arrow);
                break;
        }
    }

    @Override
    public void onUIReset(PtrFrameLayout frame) {
        headerText.setText(R.string.pull_to_refresh_pull_label);
        begin = false;
        headerImage.setImageResource(R.mipmap.pulltorefresh_down_arrow);
        headerImage.setVisibility(VISIBLE);
        headerProgress.setVisibility(View.GONE);
    }

    @Override
    public void onUIRefreshPrepare(PtrFrameLayout ptrFrameLayout) {
        headerText.setText(R.string.pull_to_refresh_pull_label);
        headerImage.setVisibility(VISIBLE);
        headerProgress.setVisibility(View.GONE);
    }

    @Override
    public void onUIRefreshBegin(PtrFrameLayout ptrFrameLayout) {
        headerText.setText(R.string.pull_to_refresh_refreshing_label);
        start = false;
        headerImage.clearAnimation();
        headerImage.setVisibility(GONE);
        headerProgress.setVisibility(VISIBLE);
    }

    @Override
    public void onUIRefreshComplete(PtrFrameLayout ptrFrameLayout) {
        headerText.setText(R.string.pull_to_refresh_complete_label);
        headerImage.clearAnimation();
        headerImage.setImageResource(R.mipmap.pulltorefresh_finish);
        headerImage.setVisibility(VISIBLE);
        headerProgress.setVisibility(GONE);
    }

    @Override
    public void onUIPositionChange(PtrFrameLayout ptrFrameLayout, boolean b, byte b1, PtrIndicator ptrIndicator) {
        if (ptrIndicator.isOverOffsetToKeepHeaderWhileLoading() && !begin) {
            begin = true;
            headerText.setText(R.string.pull_to_refresh_release_label);
            if (!start) {
                start = true;
                headerImage.startAnimation(rotateAnimation);
            }
        }
    }
}
