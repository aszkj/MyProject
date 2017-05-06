package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.ConfirmCartFragment;
import com.yldbkd.www.buyer.android.fragment.PaySuccessFragment;
import com.yldbkd.www.buyer.android.fragment.PaySuccessVipFragment;

/**
 * 订单结算Activity
 * <p/>
 * Created by lizhg on 16/06/13.
 */
public class CalcCenterActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (ConfirmCartFragment.class.getSimpleName().equals(tag)) {
            fragment = new ConfirmCartFragment();
        }
        if (PaySuccessFragment.class.getSimpleName().equals(tag)) {
            fragment = new PaySuccessFragment();
        }
        if (PaySuccessVipFragment.class.getSimpleName().equals(tag)) {
            fragment = new PaySuccessVipFragment();
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
