package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.BrandClassityFragment;
import com.yldbkd.www.seller.android.fragment.ClassificationTabFragment;

/**
 * 分类品牌相关页面activity
 * <p>
 * Created by lizhg on 17/1/9.
 */
public class ClassificationActivity extends BaseActivity {
    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (ClassificationTabFragment.class.getSimpleName().equals(tag)) {
            fragment = new ClassificationTabFragment();
        }
        if (BrandClassityFragment.class.getSimpleName().equals(tag)) {
            fragment = new BrandClassityFragment();
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
