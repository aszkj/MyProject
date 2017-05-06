package com.yldbkd.www.buyer.android.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Classification;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.util.ArrayList;
import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 9:29
 * @描述 分类商品
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ClassificationProductTabFragment extends BaseFragment {
    //title
    private View backView;
    private TextView titleView;

    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;
    private List<Classification> subClassList;
    private int VIEW_PAGER_COUNT;
    private List<Fragment> fragments = new ArrayList<>();
    private Classification classification;
    private Integer position;
    private boolean isSecType = false;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        classification = (Classification) bundle.getSerializable(Constants.BundleName.CLASSITY_DATA);
        position = bundle.getInt(Constants.BundleName.CLASSITY_CHECKED, 0);
        subClassList = classification.getSubClassList();
        isSecType = subClassList == null || subClassList.size() == 0;
        VIEW_PAGER_COUNT = isSecType ? 1 : subClassList.size();
    }

    @Override
    public int setLayoutId() {
        return R.layout.classification_product_tab_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        pagerIndicator = (PagerSlidingTabStrip) view.findViewById(R.id.classification_product_page_indicator);
        viewPager = (ViewPager) view.findViewById(R.id.view_pager);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_COUNT);
    }

    @Override
    public void initData() {
        if (VIEW_PAGER_COUNT <= 1) {
            titleView.setText(isSecType ? classification.getClassName() : subClassList.get(0).getClassName());
            pagerIndicator.setVisibility(View.GONE);
        } else {
            titleView.setText(classification.getClassName());
            pagerIndicator.setVisibility(View.VISIBLE);
        }
        initAdapter();
    }

    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();
        for (int i = 0; i < VIEW_PAGER_COUNT; i++) {
            ClassificationProductFragment classificationProductFragment = new ClassificationProductFragment();
            Bundle bundle = new Bundle();
            bundle.putSerializable(Constants.BundleName.CLASS_CODE, isSecType ? classification.getClassCode() : subClassList.get(i).getClassCode());
            classificationProductFragment.setArguments(bundle);
            fragments.add(classificationProductFragment);
            titles.add(isSecType ? classification.getClassName() : subClassList.get(i).getClassName());
        }
        ClassifationProductFragmentAdapter adapter = new ClassifationProductFragmentAdapter(getFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(position);
        pagerIndicator.setViewPager(viewPager);
        pagerIndicator.setTextSize((int) getResources().getDimension(R.dimen.text_size_big));
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
    }

    private static class ClassifationProductFragmentAdapter extends FragmentStatePagerAdapter {
        private List<Fragment> fragments;
        private List<String> titles;

        public ClassifationProductFragmentAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
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
