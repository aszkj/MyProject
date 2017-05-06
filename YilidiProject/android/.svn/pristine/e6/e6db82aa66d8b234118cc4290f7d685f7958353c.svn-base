package com.yldbkd.www.buyer.android.fragment;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.util.ArrayList;
import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 9:29
 * @描述 分类和品牌
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ClassificationTabFragment extends BaseFragment {

    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;

    private static final int VIEW_PAGER_COUNT = 2;
    private static final int[] VIEW_PAGER_TITLES = {R.string.classification_tab_title, R.string.brand_tab_title};
    private List<Fragment> fragments = new ArrayList<>();

    @Override
    public int setLayoutId() {
        return R.layout.classification_tab_fragment;
    }

    @Override
    public void initView(View view) {
        pagerIndicator = (PagerSlidingTabStrip) view.findViewById(R.id.classification_page_indicator);
        viewPager = (ViewPager) view.findViewById(R.id.view_pager);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_COUNT);
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        if (isVisibleToUser) {
            initAdapter();
        }
    }

    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();

        ClassificationFragment classificationFragment = new ClassificationFragment();
        BrandFragment brandFragment = new BrandFragment();
        fragments.add(classificationFragment);
        fragments.add(brandFragment);

        for (int i = 0; i < VIEW_PAGER_COUNT; i++) {
            titles.add(getResources().getString(VIEW_PAGER_TITLES[i]));
        }
        ClassifationFragmentAdapter adapter = new ClassifationFragmentAdapter(getChildFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(0);
        pagerIndicator.setViewPager(viewPager);
        pagerIndicator.setTextSize((int) getResources().getDimension(R.dimen.text_size_big));
    }

    private static class ClassifationFragmentAdapter extends FragmentStatePagerAdapter {

        private List<Fragment> fragments;
        private List<String> titles;

        public ClassifationFragmentAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
            super(fm);
            this.fragments = fragments;
            this.titles = titles;
            notifyDataSetChanged();
        }

        @Override
        public Fragment getItem(int position) {
            return fragments.get(position);
        }

        @Override
        public int getCount() {
            return fragments.size();
        }

        @Override
        public int getItemPosition(Object object) {
            return PagerAdapter.POSITION_NONE;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            return titles.get(position);
        }
    }
}
