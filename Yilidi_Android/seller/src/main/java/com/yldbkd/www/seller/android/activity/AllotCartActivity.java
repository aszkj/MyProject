package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.AllotCartFragment;
import com.yldbkd.www.seller.android.fragment.AllotResultFragment;

/**
 * 调货单生成相关页面activity
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class AllotCartActivity extends BaseActivity {
    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (AllotCartFragment.class.getSimpleName().equals(tag)) {
            fragment = new AllotCartFragment();
        }
        if (AllotResultFragment.class.getSimpleName().equals(tag)) {
            fragment = new AllotResultFragment();
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
