package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.EvalutionSummary;
import com.yldbkd.www.buyer.android.fragment.EvalutionListFragment;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/14 11:38
 * @描述 全部评价
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class EvalutionShowActivity extends BaseActivity {
    private View backView;
    private TextView mTitleView;
    private List<Fragment> fragments = new ArrayList<>();
    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;

    private HttpBack<List<EvalutionSummary>> evalutionTabHttpBack;
    private int mSalePruductId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.evalution_show_activity);
        mSalePruductId = getIntent().getIntExtra(Constants.BundleName.SALE_PRODUCT_ID, 0);
        initView();
        initData();
        initListener();
        initHttpBack();
        initRequest();
    }

    public void initView() {
        backView = findViewById(R.id.back_view);
        mTitleView = (TextView) findViewById(R.id.title_view);
        mTitleView.setText(getResources().getString(R.string.store_all_comments));
        pagerIndicator = (PagerSlidingTabStrip) findViewById(R.id.evalution_indicator);
        viewPager = (ViewPager) findViewById(R.id.view_pager);
    }

    private void initData() {
    }

    private void initHttpBack() {
        evalutionTabHttpBack = new HttpBack<List<EvalutionSummary>>(this) {
            @Override
            public void onSuccess(List<EvalutionSummary> evalutionSummarys) {
                if (evalutionSummarys == null || evalutionSummarys.size() == 0) {
                    return;
                }
                initAdapter(evalutionSummarys);
            }
        };
    }

    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleProductId", mSalePruductId);
        RetrofitUtils.getInstance().getEvaluationSummary(ParamUtils.getParam(map), evalutionTabHttpBack);
    }

    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onBackPressed();
            }
        });
    }

    private void initAdapter(List<EvalutionSummary> evalutionSummarys) {
        viewPager.setOffscreenPageLimit(evalutionSummarys.size());

        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();
        for (int i = 0; i < evalutionSummarys.size(); i++) {
            EvalutionSummary evalutionSummary = evalutionSummarys.get(i);
            EvalutionListFragment fragment = new EvalutionListFragment();
            Bundle bundle = new Bundle();
            bundle.putString(Constants.BundleName.EVALUTION_CLASSIFTY, evalutionSummary.getSummaryValue());
            bundle.putInt(Constants.BundleName.SALE_PRODUCT_ID, mSalePruductId);
            fragment.setArguments(bundle);
            fragments.add(fragment);
            titles.add(evalutionSummary.getSummaryName() +"\n(" + evalutionSummary.getSummaryCount() + ")");
        }
        EvalutionFragmentAdapter adapter = new EvalutionFragmentAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(0);
        pagerIndicator.setViewPager(viewPager);
        pagerIndicator.setTextSize((int) getResources().getDimension(R.dimen.text_size_normal));
    }

    private static class EvalutionFragmentAdapter extends FragmentStatePagerAdapter {

        private List<Fragment> fragments;
        private List<String> titles;

        public EvalutionFragmentAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
            super(fm);
            this.fragments = fragments;
            this.titles = titles;
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

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
