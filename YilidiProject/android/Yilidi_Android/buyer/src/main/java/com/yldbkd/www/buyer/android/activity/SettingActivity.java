package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.AccountSafeFragment;
import com.yldbkd.www.buyer.android.fragment.FeedBackFragment;
import com.yldbkd.www.buyer.android.fragment.SettingFragment;
import com.yldbkd.www.buyer.android.fragment.UpdateNickNameFragment;
import com.yldbkd.www.buyer.android.fragment.UserInfoFragment;

/**
 * @创建者     李贞高
 * @创建时间   2017/2/20 18:18
 * @描述	      设置
 *
 * @更新者     $Author$
 * @更新时间   $Date$
 * @更新描述
 */
public class SettingActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (SettingFragment.class.getSimpleName().equals(tag)) {
            fragment = new SettingFragment();
        }
        if (UserInfoFragment.class.getSimpleName().equals(tag)) {
            fragment = new UserInfoFragment();
        }
        if (AccountSafeFragment.class.getSimpleName().equals(tag)) {
            fragment = new AccountSafeFragment();
        }
        if (FeedBackFragment.class.getSimpleName().equals(tag)) {
            fragment = new FeedBackFragment();
        }
        if (UpdateNickNameFragment.class.getSimpleName().equals(tag)) {
            fragment = new UpdateNickNameFragment();
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
