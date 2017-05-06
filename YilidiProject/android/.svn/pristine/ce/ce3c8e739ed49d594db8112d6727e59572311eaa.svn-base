package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.AddressFragment;
import com.yldbkd.www.buyer.android.fragment.AddressListFragment;

/**
 * 地址管理Activity
 * <p/>
 * Created by linghuxj on 15/10/13.
 */
public class AddressActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (AddressListFragment.class.getSimpleName().equals(tag)) {
            fragment = new AddressListFragment();
        }
        if (AddressFragment.class.getSimpleName().equals(tag)) {
            fragment = new AddressFragment();
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
