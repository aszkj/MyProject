package com.yldbkd.www.seller.android.activity;

import android.annotation.TargetApi;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.view.ViewGroup;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.FragmentAdapter;
import com.yldbkd.www.seller.android.fragment.BaseGuideFragment;
import com.yldbkd.www.seller.android.fragment.FirstGuideFragment;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.library.android.viewCustomer.CirclePageIndicator;
import com.yldbkd.www.library.android.viewCustomer.ViewPagerParallax;

import java.util.HashMap;
import java.util.Map;

/**
 * 引导页Activity
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class GuideActivity extends BaseActivity {
    final float PARALLAX_COEFFICIENT = 1.2f;
    final float DISTANCE_COEFFICIENT = 0.5f;

    ViewPagerParallax mPager;
    CirclePageIndicator mPagerIndicator;
    FragmentAdapter mAdapter;

    Map<Integer, int[]> mLayoutViewIdsMap = new HashMap<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_guide);
        intViews();
        mPager.setAdapter(mAdapter);
        mPager.setPageTransformer(true, new ParallaxTransformer(PARALLAX_COEFFICIENT, DISTANCE_COEFFICIENT));
        mPagerIndicator.setViewPager(mPager);
        mPagerIndicator.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
            }

            @Override
            public void onPageSelected(int position) {
                int size = mAdapter.getCount();
                for (int i = 0; i < size; i++) {
                    FirstGuideFragment fragment = (FirstGuideFragment) mAdapter.getItem(i);
                    if (position == i) {
                        fragment.setUserVisibleHint(true);
                        fragment.onResume();
                    } else {
                        fragment.setUserVisibleHint(false);
                        fragment.onPause();
                    }
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {
            }
        });
    }

    private void intViews() {
        mPager = (ViewPagerParallax) findViewById(R.id.viewpager);
        mPagerIndicator = (CirclePageIndicator) findViewById(R.id.indicator);
        mAdapter = new FragmentAdapter(getSupportFragmentManager());
        for (int i = 0; i < 4; i++) {
            FirstGuideFragment fragment = new FirstGuideFragment();
            Bundle bundle = new Bundle();
            bundle.putInt(Constants.BundleName.POSITION, i);
            fragment.setArguments(bundle);
            addGuide(fragment);
        }
    }

    private void addGuide(BaseGuideFragment fragment) {
        mAdapter.addItem(fragment);
        mLayoutViewIdsMap.put(fragment.getRootViewId(), fragment.getChildViewIds());
    }

    class ParallaxTransformer implements ViewPager.PageTransformer {

        float parallaxCoefficient;
        float distanceCoefficient;

        public ParallaxTransformer(float parallaxCoefficient, float distanceCoefficient) {
            this.parallaxCoefficient = parallaxCoefficient;
            this.distanceCoefficient = distanceCoefficient;
        }

        @TargetApi(Build.VERSION_CODES.HONEYCOMB)
        @Override
        public void transformPage(View page, float position) {
            float scrollXOffset = page.getWidth() * parallaxCoefficient;

            ViewGroup pageViewWrapper = (ViewGroup) page;
            @SuppressWarnings("SuspiciousMethodCalls")
            int[] layer = mLayoutViewIdsMap.get(pageViewWrapper.getId());
            for (int id : layer) {
                View view = page.findViewById(id);
                if (view != null) {
                    view.setTranslationX(scrollXOffset * position);
                }
                scrollXOffset *= distanceCoefficient;
            }
        }
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }
}
