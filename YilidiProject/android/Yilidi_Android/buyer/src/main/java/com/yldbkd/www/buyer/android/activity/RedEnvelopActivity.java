package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.widget.RelativeLayout;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.RedEnvelopEntranceFragment;
import com.yldbkd.www.buyer.android.fragment.RedEnvelopFragment;

/**
 * 红包相关Activity
 * <p>
 * Created by linghuxj on 2016/10/9.
 */

public class RedEnvelopActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (RedEnvelopFragment.class.getSimpleName().equals(tag)) {
            fragment = new RedEnvelopFragment();
        }
        if (RedEnvelopEntranceFragment.class.getSimpleName().equals(tag)) {
            fragment = new RedEnvelopEntranceFragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.common_activity);
        RelativeLayout layout = (RelativeLayout) findViewById(R.id.common_activity);
        layout.setBackgroundColor(ContextCompat.getColor(this, R.color.red_envelop_entra_bg));
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);
    }
}
