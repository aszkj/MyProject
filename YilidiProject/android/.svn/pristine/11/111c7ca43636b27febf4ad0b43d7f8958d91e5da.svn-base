package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.StoreSearchProductFragment;

/**
 * 店铺相关Activity
 * <p/>
 * Created by linghuxj on 15/10/10.
 */
public class StoreActivity extends BaseActivity {
    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (StoreSearchProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new StoreSearchProductFragment();
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
