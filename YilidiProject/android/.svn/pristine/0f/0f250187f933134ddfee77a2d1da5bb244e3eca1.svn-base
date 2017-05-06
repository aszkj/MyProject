package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;

import com.yldbkd.www.seller.android.R;

public class SecondGuideFragment extends BaseGuideFragment {

    final long ANIMATION_DURATION = 500;
    final long ANIMATION_OFFSET = 200;
    private int[] mAnimationViewIds = { R.id.guide_item_1, R.id.guide_item_2 };

    private View mainView;

    @Override
    public int[] getChildViewIds() {
        return new int[] {};
    }

    @Override
    public int getRootViewId() {
        return R.id.layout_guide_second;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        mainView = inflater.inflate(R.layout.fragment_guide_second, container, false);
        return mainView;
    }

    @Override
    public void onResume() {
        super.onResume();
        for (int i = 0; i < mAnimationViewIds.length; i++) {
            Animation animation = AnimationUtils.loadAnimation(getActivity(), R.anim.guide_items);
            animation.setDuration(ANIMATION_DURATION);
            animation.setStartOffset(ANIMATION_OFFSET * i);
            animation.setFillAfter(true);
            mainView.findViewById(mAnimationViewIds[i]).startAnimation(animation);
            mainView.findViewById(mAnimationViewIds[i]).setVisibility(View.VISIBLE);
        }
    }

}
