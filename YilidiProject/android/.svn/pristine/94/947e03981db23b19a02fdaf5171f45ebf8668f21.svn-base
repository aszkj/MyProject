package com.yldbkd.www.seller.android.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;

import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.LoginFragment;
import com.yldbkd.www.seller.android.fragment.MainFragment;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.UserUtils;

/**
 * 合伙人端首页页面Activity
 * <p/>
 * Created by linghuxj on 16/5/25.
 */
public class MainActivity extends BaseActivity {

    private boolean isDoubleExist = false;

    @Override
    Fragment newFragmentByTag(String tag) {
        return new MainFragment();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (!UserUtils.isLogin()) {
            Intent intent = new Intent(this, LoginActivity.class);
            intent.setAction(LoginFragment.class.getSimpleName());
            startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
            return;
        }
        setCustomContentView(R.layout.activity_common);
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == Constants.RequestCode.LOGIN_CODE && resultCode == Activity.RESULT_OK) {
            setCustomContentView(R.layout.activity_common);
            showFragment(getIntent().getAction(), getIntent().getExtras(), false);
        }
    }

    @Override
    public void onBackPressed() {
        if (isDoubleExist) {
            AppManager.getAppManager().appExit();
            return;
        }
        isDoubleExist = true;
        ToastUtils.show(this, getString(R.string.double_exit_notify));
        new Handler().postDelayed(new Runnable() {

            @Override
            public void run() {
                isDoubleExist = false;
            }
        }, 2000);
    }
}
