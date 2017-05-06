package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;

import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.CountDown;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.FindStep1Fragment;
import com.yldbkd.www.seller.android.fragment.FindStep2Fragment;
import com.yldbkd.www.seller.android.fragment.LoginCodeFragment;
import com.yldbkd.www.seller.android.fragment.LoginFragment;

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
        if (LoginFragment.class.getSimpleName().equals(tag)) {
            fragment = new LoginFragment();
        }
        if (LoginCodeFragment.class.getSimpleName().equals(tag)) {
            fragment = new LoginCodeFragment();
        }
        if (FindStep1Fragment.class.getSimpleName().equals(tag)) {
            fragment = new FindStep1Fragment();
        }
        if (FindStep2Fragment.class.getSimpleName().equals(tag)) {
            fragment = new FindStep2Fragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_common);
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
