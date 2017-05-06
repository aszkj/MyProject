package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.CollectFragment;

/**
 * 收藏页面activity
 * <p>
 * Created by linghuxj on 2017/2/21.
 */

public class CollectionActivity extends BaseActivity {


    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (CollectFragment.class.getSimpleName().equals(tag)) {
            fragment = new CollectFragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.common_activity);
        showFragment(CollectFragment.class.getSimpleName(), getIntent().getExtras(), false);
    }
}
