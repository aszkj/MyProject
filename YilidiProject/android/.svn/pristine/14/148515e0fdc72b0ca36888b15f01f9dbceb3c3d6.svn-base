package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.AllotProductFragment;
import com.yldbkd.www.seller.android.fragment.BrandProductFragment;
import com.yldbkd.www.seller.android.fragment.ClassProductFragment;

/**
 * 商品相关页面activity
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class ProductActivity extends BaseActivity {
    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (ClassProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new ClassProductFragment();
        }
        if (AllotProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new AllotProductFragment();
        }
        if (BrandProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new BrandProductFragment();
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
