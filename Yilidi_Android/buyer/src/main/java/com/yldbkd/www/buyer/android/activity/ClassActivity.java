package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.BrandClassityFragment;
import com.yldbkd.www.buyer.android.fragment.BrandProductFragment;
import com.yldbkd.www.buyer.android.fragment.ClassFragment;
import com.yldbkd.www.buyer.android.fragment.ClassificationProductFragment;
import com.yldbkd.www.buyer.android.fragment.ClassificationProductTabFragment;

/**
 * 分类管理Activity
 * <p/>
 * Created by linghuxj on 15/10/13.
 */
public class ClassActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (ClassFragment.class.getSimpleName().equals(tag)) {
            fragment = new ClassFragment();
        }
        if (BrandProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new BrandProductFragment();
        }
        if (BrandClassityFragment.class.getSimpleName().equals(tag)) {
            fragment = new BrandClassityFragment();
        }
        if (ClassificationProductTabFragment.class.getSimpleName().equals(tag)) {
            fragment = new ClassificationProductTabFragment();
        }
        if (ClassificationProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new ClassificationProductFragment();
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
