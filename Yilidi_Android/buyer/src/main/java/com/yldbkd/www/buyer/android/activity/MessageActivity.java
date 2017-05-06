package com.yldbkd.www.buyer.android.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.MessageActivityDetailFragment;
import com.yldbkd.www.buyer.android.fragment.MessageActivityFragment;
import com.yldbkd.www.buyer.android.fragment.MessageFragment;
import com.yldbkd.www.buyer.android.fragment.MessageListFragment;

/**
 * 我的消息Activity
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class MessageActivity extends BaseActivity {

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (MessageFragment.class.getSimpleName().equals(tag)) {
            fragment = new MessageFragment();
        }
        if (MessageListFragment.class.getSimpleName().equals(tag)) {
            fragment = new MessageListFragment();
        }
        if (MessageActivityFragment.class.getSimpleName().equals(tag)) {
            fragment = new MessageActivityFragment();
        }
        if (MessageActivityDetailFragment.class.getSimpleName().equals(tag)) {
            fragment = new MessageActivityDetailFragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.common_activity);
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);
    }

    public static Intent newInstance(Context context, String fragment) {
        Intent intent = new Intent(context, MessageActivity.class);
        intent.setAction(fragment);
        return intent;
    }
}
