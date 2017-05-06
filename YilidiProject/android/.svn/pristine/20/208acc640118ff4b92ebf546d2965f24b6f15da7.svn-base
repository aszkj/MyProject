package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.LocationMapFragment;

/**
 * 定位地图信息Activity
 * <p/>
 * Created by linghuxj on 16/6/17.
 */
public class LocationMapActivity extends BaseActivity {

    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (LocationMapFragment.class.getSimpleName().equals(tag)) {
            fragment = new LocationMapFragment();
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
