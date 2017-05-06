package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.LoginActivity;
import com.yldbkd.www.seller.android.activity.MainActivity;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.PreferenceName;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.PreferenceUtils;

public class FirstGuideFragment extends BaseGuideFragment {

    final long ANIMATION_DURATION = 500;
    final long ANIMATION_OFFSET = 200;
    private int[] mAnimationViewIds = {R.id.guide_item_1, R.id.guide_item_2, R.id.guide_item_3, R.id.guide_button};
    private View mainView;
    private Button button;
    private static final int[] TITLES = {R.mipmap.guide_title1, R.mipmap.guide_title2, R.mipmap.guide_title3,
            R.mipmap.guide_title4};
    private static final int[] CONTENTS = {R.mipmap.guide_content1, R.mipmap.guide_content2, R.mipmap.guide_content3,
            R.mipmap.guide_content4};
    private static final int[] BGS = {R.mipmap.guide_bg1, R.mipmap.guide_bg2, R.mipmap.guide_bg3, R.mipmap.guide_bg4};

    private int position = 0;

    @Override
    public int[] getChildViewIds() {
        return mAnimationViewIds;
    }

    @Override
    public int getRootViewId() {
        return R.id.layout_guide_first;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        position = bundle.getInt(Constants.BundleName.POSITION);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        mainView = inflater.inflate(R.layout.fragment_guide_first, container, false);
        ((ImageView) mainView.findViewById(R.id.guide_item_1)).setImageResource(TITLES[position]);
        ((ImageView) mainView.findViewById(R.id.guide_item_2)).setImageResource(CONTENTS[position]);
        ((ImageView) mainView.findViewById(R.id.guide_item_3)).setImageResource(BGS[position]);
        button = (Button) mainView.findViewById(R.id.guide_button);
        if (position == 3) {
            button.setVisibility(View.VISIBLE);
        }
        initListener();
        return mainView;
    }

    private void initListener() {
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                PreferenceUtils.setBooleanPref(getActivity(), PreferenceName.FIRST_OPEN, true);
                Intent intent = new Intent(getActivity(), LoginActivity.class);
                intent.setAction(LoginFragment.class.getSimpleName());
                startActivity(intent);
                AppManager.getAppManager().finishActivity(getActivity());
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        for (int i = 0; i < mAnimationViewIds.length; i++) {
            Animation animation = AnimationUtils.loadAnimation(getActivity(), R.anim.guide_items);
            animation.setDuration(ANIMATION_DURATION);
            animation.setStartOffset(ANIMATION_OFFSET * i);
            mainView.findViewById(mAnimationViewIds[i]).startAnimation(animation);
        }
    }
}
