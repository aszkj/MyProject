package com.yldbkd.www.library.android.pullRefresh;

import android.content.Context;
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

public class LoadingLayout extends FrameLayout {

    static final int DEFAULT_ROTATION_ANIMATION_DURATION = 150;

    private final ImageView headerImage;
    private final ProgressBar headerProgress;
    private final TextView headerText;

    private String pullLabel;
    private String refreshingLabel;
    private String releaseLabel;

    private final Animation rotateAnimation, resetRotateAnimation;
    private boolean ifShowBottom;

    public LoadingLayout(Context context, final int mode, String releaseLabel,
                         String pullLabel, String refreshingLabel) {
        this(context, mode, releaseLabel, pullLabel, refreshingLabel, true);
    }

    public LoadingLayout(Context context, final int mode, String releaseLabel,
                         String pullLabel, String refreshingLabel, boolean ifShowBottom) {
        super(context);
        this.ifShowBottom = ifShowBottom;
        ViewGroup header = (ViewGroup) LayoutInflater.from(context).inflate(
                R.layout.pull_to_refresh_header, this);
        headerText = (TextView) header.findViewById(R.id.pull_to_refresh_text);
        headerImage = (ImageView) header
                .findViewById(R.id.pull_to_refresh_image);
        headerProgress = (ProgressBar) header
                .findViewById(R.id.pull_to_refresh_progress);

        final Interpolator interpolator = new LinearInterpolator();
        rotateAnimation = new RotateAnimation(0, -180,
                Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF,
                0.5f);
        rotateAnimation.setInterpolator(interpolator);
        rotateAnimation.setDuration(DEFAULT_ROTATION_ANIMATION_DURATION);
        rotateAnimation.setFillAfter(true);

        resetRotateAnimation = new RotateAnimation(-180, 0,
                Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF,
                0.5f);
        resetRotateAnimation.setInterpolator(interpolator);
        resetRotateAnimation.setDuration(DEFAULT_ROTATION_ANIMATION_DURATION);
        resetRotateAnimation.setFillAfter(true);

        this.releaseLabel = releaseLabel;
        this.pullLabel = pullLabel;
        this.refreshingLabel = refreshingLabel;

        switch (mode) {
            case PullToRefreshBase.MODE_PULL_UP_TO_REFRESH:
                if (ifShowBottom) {
                    headerImage.setImageResource(R.mipmap.pulltorefresh_up_arrow);
                }
                break;
            case PullToRefreshBase.MODE_PULL_DOWN_TO_REFRESH:
            default:
                headerImage.setImageResource(R.mipmap.pulltorefresh_down_arrow);
                break;
        }
    }

    public void reset() {
        headerText.setText(pullLabel);
        if (ifShowBottom) {
            headerImage.setVisibility(View.VISIBLE);
        }
        headerProgress.setVisibility(View.GONE);
    }

    public void releaseToRefresh() {
        headerText.setText(releaseLabel);
        headerImage.clearAnimation();
        if (ifShowBottom) {
            headerImage.startAnimation(rotateAnimation);
        }
    }

    public void setPullLabel(String pullLabel) {
        this.pullLabel = pullLabel;
    }

    public void refreshing() {
        headerText.setText(refreshingLabel);
        headerImage.clearAnimation();
        headerImage.setVisibility(View.INVISIBLE);
        if (ifShowBottom) {
            headerProgress.setVisibility(View.VISIBLE);
        }
    }

    public void setRefreshingLabel(String refreshingLabel) {
        this.refreshingLabel = refreshingLabel;
    }

    public void setReleaseLabel(String releaseLabel) {
        this.releaseLabel = releaseLabel;
    }

    public void pullToRefresh() {
        headerText.setText(pullLabel);
        headerImage.clearAnimation();
        if (ifShowBottom) {
            headerImage.startAnimation(resetRotateAnimation);
        }
    }

    public void setTextColor(int color) {
        headerText.setTextColor(color);
    }

    public void setIfShowBottom(boolean ifShowBottom) {
        this.ifShowBottom = ifShowBottom;
    }
}
