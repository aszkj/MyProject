package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.CartFragment;
import com.yldbkd.www.buyer.android.fragment.PaySuccessFragment;
import com.yldbkd.www.buyer.android.viewCustomer.BackHandledFragment;
import com.yldbkd.www.buyer.android.viewCustomer.BackHandledInterface;

/**
 * 购买流程相关页面Activity
 * <p/>
 * Created by linghuxj on 15/10/20.
 */
public class PurchaseActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (CartFragment.class.getSimpleName().equals(tag)) {
            fragment = new CartFragment();
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
