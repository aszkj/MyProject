package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.OrderListFragment;
import com.yldbkd.www.seller.android.fragment.OrderSearchFragment;
import com.yldbkd.www.seller.android.fragment.ProductSearchRecordFragment;
import com.yldbkd.www.seller.android.fragment.ProductSearchResultFragment;

/**
 * 搜索页面Activity
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class SearchActivity extends BaseActivity {

    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (OrderListFragment.class.getSimpleName().equals(tag)) {
            fragment = new OrderListFragment();
        }
        if (OrderSearchFragment.class.getSimpleName().equals(tag)) {
            fragment = new OrderSearchFragment();
        }
        if (ProductSearchRecordFragment.class.getSimpleName().equals(tag)) {
            fragment = new ProductSearchRecordFragment();
        }
        if (ProductSearchResultFragment.class.getSimpleName().equals(tag)) {
            fragment = new ProductSearchResultFragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_common);
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);
    }
}
