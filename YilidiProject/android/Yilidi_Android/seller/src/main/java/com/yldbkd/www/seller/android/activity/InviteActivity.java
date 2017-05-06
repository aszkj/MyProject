package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.InviteCodeFragment;
import com.yldbkd.www.seller.android.fragment.InviteListFragment;

/**
 * 邀请会员相关Activity
 * <p/>
 * Created by linghuxj on 16/5/30.
 */
public class InviteActivity extends BaseActivity {

    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (InviteCodeFragment.class.getSimpleName().equals(tag)) {
            fragment = new InviteCodeFragment();
        }
        if (InviteListFragment.class.getSimpleName().equals(tag)) {
            fragment = new InviteListFragment();
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
