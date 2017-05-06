package com.yldbkd.www.seller.android.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.view.View;
import android.view.animation.AlphaAnimation;

import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.StoreBase;
import com.yldbkd.www.seller.android.fragment.LoginFragment;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.UserUtils;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.utils.update.UpdateManager;

import java.lang.ref.WeakReference;

/**
 * 启动页面Activity
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class SplashActivity extends BaseActivity {

    private MyHandler handler = new MyHandler(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (isNotification() && isAppOnline()) {
            this.finish();
            return;
        }
        View view = View.inflate(this, R.layout.activity_splash, null);
        setContentView(view);
        // 开启渐变动画效果
        AlphaAnimation aa = new AlphaAnimation(0.3f, 1.0f);
        aa.setDuration(1000);
        view.startAnimation(aa);

        // 检查并更新
        final Runnable update = new Runnable() {
            @Override
            public void run() {
                UpdateManager.getUpdateManager().checkAppUpdate(SplashActivity.this, handler);
            }
        };
        Handler delayHandler = new Handler();
        delayHandler.postDelayed(update, 2000);

        if (UserUtils.isLogin()) {
            RetrofitUtils.getInstance().userInfo(ParamUtils.getParam(null), new HttpBack<StoreBase>() {
                @Override
                public void onSuccess(StoreBase storeBase) {
                    UserUtils.saveUserInfo(UserUtils.getLoginName(), storeBase);
                }

                @Override
                public void onFailure(String msg) {
                }

                @Override
                public void onTimeOut() {
                }
            });
        }
    }

    static class MyHandler extends Handler {
        WeakReference<Activity> mActivityReference;

        MyHandler(Activity activity) {
            mActivityReference = new WeakReference<>(activity);
        }

        @Override
        public void handleMessage(Message msg) {
            final Activity activity = mActivityReference.get();
            if (activity == null) {
                return;
            }
            if (msg.what == UpdateManager.NO_VERSION_UPDATE
                    || msg.what == UpdateManager.CHECK_VERSION_FINISH) {
                this.postDelayed(new Runnable() {
                    public void run() {
                        ((SplashActivity) activity).directTo();
                    }
                }, 2000);
            }
        }
    }

    /**
     * 跳转页面操作
     */
    private void directTo() {
        Intent intent;
        if (isFirstOpen()) {
            intent = new Intent(this, GuideActivity.class);
        } else {
            if (!UserUtils.isLogin()) {
                intent = new Intent(this, LoginActivity.class);
                intent.setAction(LoginFragment.class.getSimpleName());
            } else {
                intent = new Intent(this, MainActivity.class);
            }
        }
        startActivity(intent);
        finish();
    }

    private boolean isNotification() {
        return getIntent().getBooleanExtra(Constants.BundleName.IS_NOTIFICATION, false);
    }

    private boolean isAppOnline() {
        return AppManager.isOpenApp(LoginActivity.class.getSimpleName() + MainActivity.class.getSimpleName());
    }

    /**
     * 是否是第一次打开应用
     */
    private boolean isFirstOpen() {
        return false;//!PreferenceUtils.getBooleanPref(getApplicationContext(), PreferenceName.FIRST_OPEN, false);
    }

    /**
     * 屏蔽掉用户在该页面时回退的操作
     */
    @Override
    public void onBackPressed() {
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }
}
