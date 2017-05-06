package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.PasswordFragment;
import com.yldbkd.www.seller.android.fragment.ProfileFragment;
import com.yldbkd.www.seller.android.fragment.StoreManageFragment;
import com.yldbkd.www.seller.android.fragment.SuggestFragment;

/**
 * 店铺中心Activity
 * <p/>
 * Created by linghuxj on 16/6/7.
 */
public class StoreActivity extends BaseActivity {

    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (ProfileFragment.class.getSimpleName().equals(tag)) {
            fragment = new ProfileFragment();
        }
        if (StoreManageFragment.class.getSimpleName().equals(tag)) {
            fragment = new StoreManageFragment();
        }
        if (PasswordFragment.class.getSimpleName().equals(tag)) {
            fragment = new PasswordFragment();
        }
        if (SuggestFragment.class.getSimpleName().equals(tag)) {
            fragment = new SuggestFragment();
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
