package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.WeeklyProductFragment;
import com.yldbkd.www.buyer.android.fragment.ZoneProductFragment;

/**
 * @author 李贞高
 * @version $Rev$
 * @time 2016/7/15 10:18
 * @des 专区activity
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class ZoneActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (WeeklyProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new WeeklyProductFragment();
        }
        if (ZoneProductFragment.class.getSimpleName().equals(tag)) {
            fragment = new ZoneProductFragment();
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
