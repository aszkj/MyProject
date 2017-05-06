package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.*;

/**
 * 一些比较零散的Fragment用该Activity来管理
 * <p/>
 * Created by linghuxj on 15/10/9.
 */
public class SearchActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (ClassFragment.class.getSimpleName().equals(tag)) {
            fragment = new ClassFragment();
        }
        if (SearchProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new SearchProductFragment();
        }
        if (SearchLocationFragment.class.getSimpleName().equals(tag)) {
            fragment = new SearchLocationFragment();
        }
        if (LocationNearbyFragment.class.getSimpleName().equals(tag)) {
            fragment = new LocationNearbyFragment();
        }
        if (LocationHistoryFragment.class.getSimpleName().equals(tag)) {
            fragment = new LocationHistoryFragment();
        }
        if (SearchLocationResultFragment.class.getSimpleName().equals(tag)) {
            fragment = new SearchLocationResultFragment();
        }
        if (SearchFragment.class.getSimpleName().equals(tag)) {
            fragment = new SearchFragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.common_activity);
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);
    }
}
