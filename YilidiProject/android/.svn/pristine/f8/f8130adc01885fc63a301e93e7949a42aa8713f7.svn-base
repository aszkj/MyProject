package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.CheckCodeLoginFragment;
import com.yldbkd.www.buyer.android.fragment.FindPwdCheckFragment;
import com.yldbkd.www.buyer.android.fragment.FindPwdResetFragment;
import com.yldbkd.www.buyer.android.fragment.LoginFragment;
import com.yldbkd.www.buyer.android.fragment.PasswordFragment;
import com.yldbkd.www.buyer.android.fragment.RelatedPhoneNumFragment;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.CountDown;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;

import java.lang.ref.WeakReference;

/**
 * 登录相关页面Activity
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class LoginActivity extends BaseActivity {

    private boolean isDoubleExist = false;
    private Fragment fragment = null;

    public static final long MILLIS_IN_FUTURE = 60 * 1000L;
    private static final long COUNT_DOWN_INTERVAL = 500L;
    private CountDown countDown;
    private CountDownHandler handler = new CountDownHandler(this);

    private CountDownListener countDownListener;

    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (LoginFragment.class.getSimpleName().equals(tag)) {
            fragment = new LoginFragment();
        }

        if (CheckCodeLoginFragment.class.getSimpleName().equals(tag)) {
            fragment = new CheckCodeLoginFragment();
        }
        if (FindPwdCheckFragment.class.getSimpleName().equals(tag)) {
            fragment = new FindPwdCheckFragment();
        }
        if (FindPwdResetFragment.class.getSimpleName().equals(tag)) {
            fragment = new FindPwdResetFragment();
        }
        if (PasswordFragment.class.getSimpleName().equals(tag)) {
            fragment = new PasswordFragment();
        }
        if (RelatedPhoneNumFragment.class.getSimpleName().equals(tag)) {
            fragment = new RelatedPhoneNumFragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.common_activity);
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);
    }

    @Override
    public void onBackPressed() {
        KeyboardUtils.close(this);
        if (fragment instanceof LoginFragment) {
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
        } else {
            super.onBackPressed();
        }
    }

    public void startCountDown(long millisInFuture) {
        countDown = new CountDown(millisInFuture, COUNT_DOWN_INTERVAL, handler);
        countDown.start();
    }

    public void setCountDownListener(CountDownListener countDownListener) {
        this.countDownListener = countDownListener;
    }

    static class CountDownHandler extends Handler {
        WeakReference<LoginActivity> activityWeakReference;

        public CountDownHandler(LoginActivity activity) {
            this.activityWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(Message msg) {
            LoginActivity activity = activityWeakReference.get();
            if (activity == null || activity.countDownListener == null) {
                return;
            }
            switch (msg.what) {
                case CountDown.COUNT_DOWN_TIMER:
                    activity.countDownListener.countTimer((Long) msg.obj);
                    break;
                case CountDown.COUNT_DOWN_FINISH:
                    activity.countDownListener.countFinish();
                    break;
            }
        }
    }

    public interface CountDownListener {
        void countTimer(long millisUntilFinished);

        void countFinish();
    }
}
