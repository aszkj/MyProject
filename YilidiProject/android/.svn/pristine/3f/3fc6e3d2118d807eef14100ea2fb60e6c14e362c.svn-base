package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.SearchBrandFragment;
import com.yldbkd.www.buyer.android.fragment.SearchProductFragment;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.HistoryUtils;
import com.yldbkd.www.buyer.android.utils.PreferenceName;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.util.ArrayList;
import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2017/1/17 15:46
 * @描述 搜索商品和品牌
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class SearchResultActivity extends BaseActivity {
    private String keywords;
    //搜索
    private View rlTitleBar;
    private View backView;
    private ClearableEditText searchTextView;
    private TextView searchBtn;

    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;
    private static final int VIEW_PAGER_COUNT = 2;
    private static final int[] VIEW_PAGER_TITLES = {R.string.search_title_product, R.string.search_title_brand};
    private List<Fragment> fragments = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.search_tab_fragment);
        keywords = getIntent().getStringExtra(Constants.BundleName.SEARCH_KEYWORD);

        initView();
        initData();
        initListener();
    }

    public void initView() {
        rlTitleBar = findViewById(R.id.search_title_bar);
        backView = findViewById(R.id.back_view);
        searchBtn = (TextView) findViewById(R.id.right_view);
        searchTextView = (ClearableEditText) findViewById(R.id.search_text_view);

        pagerIndicator = (PagerSlidingTabStrip) findViewById(R.id.search_page_indicator);
        viewPager = (ViewPager) findViewById(R.id.view_pager);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_COUNT);
    }

    public void initData() {
        rlTitleBar.setBackgroundColor(ContextCompat.getColor(this, R.color.colorYellow));
        backView.setVisibility(View.GONE);
        searchTextView.setText(keywords);
        searchTextView.setSelection(keywords.length());
        searchTextView.requestFocus();
        initAdapter();
    }

    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();

        //传入关键字
        Bundle bundle = new Bundle();
        bundle.putString(Constants.BundleName.SEARCH_KEYWORD, keywords);

        SearchProductFragment searchProductFragment = new SearchProductFragment();
        searchProductFragment.setArguments(bundle);
        SearchBrandFragment brandFragment = new SearchBrandFragment();
        brandFragment.setArguments(bundle);
        fragments.add(searchProductFragment);
        fragments.add(brandFragment);
        for (int i = 0; i < VIEW_PAGER_COUNT; i++) {
            titles.add(getResources().getString(VIEW_PAGER_TITLES[i]));
        }
        SearchFragmentAdapter adapter = new SearchFragmentAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(0);
        pagerIndicator.setViewPager(viewPager);
        pagerIndicator.setTextSize((int) getResources().getDimension(R.dimen.text_size_big));
    }

    private static class SearchFragmentAdapter extends FragmentStatePagerAdapter {
        private List<Fragment> fragments;
        private List<String> titles;

        public SearchFragmentAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
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

    public void initListener() {
        searchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(SearchResultActivity.this);
                onBackPressed();
            }
        });
        searchTextView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (EditorInfo.IME_ACTION_SEARCH == i) {
                    if (textView.getText().toString() == null || textView.getText().toString().equals(keywords)) {
                        return false;
                    }
                    keywords = textView.getText().toString();
                    if (TextUtils.isEmpty(keywords.trim())) {
                        ToastUtils.show(SearchResultActivity.this, R.string.search_location_empty_notify);
                        return false;
                    }
                    if (CheckUtils.isConSpeCharacters(keywords.trim())) {
                        ToastUtils.show(SearchResultActivity.this, R.string.search_error_notify);
                        return false;
                    }
                    KeyboardUtils.close(SearchResultActivity.this);
                    HistoryUtils.addHistory(SearchResultActivity.this, keywords, PreferenceName.Search.SEARCH_HISTORY);
                    //将搜索框内容传递给子fragment
                    setKeywodrsToViewPager();
                }
                return false;
            }
        });
    }

    private void setKeywodrsToViewPager() {
        SearchProductFragment productFragment = (SearchProductFragment) fragments.get(0);
        SearchBrandFragment brandFragment = (SearchBrandFragment) fragments.get(1);
        productFragment.setKeyWords(keywords, true);
        brandFragment.setKeyWords(keywords, true);
        int currentItem = viewPager.getCurrentItem();
        if (currentItem == 0) {
            productFragment.searchRequest();
        } else if (currentItem == 1) {
            brandFragment.searchRequest();
        }
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}