package com.yldbkd.www.buyer.android.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.view.View;
import android.view.animation.AlphaAnimation;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.igexin.sdk.PushManager;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.User;
import com.yldbkd.www.buyer.android.fragment.MessageFragment;
import com.yldbkd.www.buyer.android.service.PushIntentService;
import com.yldbkd.www.buyer.android.service.PushService;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.LocationUtils;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.buyer.android.utils.PreferenceName;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.utils.update.UpdateManager;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.PreferenceUtils;

import java.lang.ref.WeakReference;

/**
 * 启动页面Activity
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class SplashActivity extends BaseActivity {

    private MyHandler handler = new MyHandler(this);
    private LocationUtils locationUtils = LocationUtils.getInstance();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //通知
        if (isNotification() && isAppOnline()) {
            Intent intent = MessageActivity.newInstance(this, MessageFragment.class.getSimpleName());
            startActivity(intent);
            this.finish();
            return;
        }

        View view = View.inflate(this, R.layout.splash_activity, null);
        setContentView(view);
        // 开启渐变动画效果
        AlphaAnimation aa = new AlphaAnimation(0.3f, 1.0f);
        aa.setDuration(1000);
        view.startAnimation(aa);

        // 初始化请求定位
        locationUtils.init(this, 0); // 只请求一次
        locationUtils.registerLocationListener(new LocationListener());
        locationUtils.startLoc();

        // 检查并更新
        final Runnable update = new Runnable() {
            @Override
            public void run() {
                UpdateManager.getUpdateManager().checkAppUpdate(SplashActivity.this, handler);
            }
        };
        Handler delayHandler = new Handler();
        delayHandler.postDelayed(update, 1000);

        if (UserUtils.isLogin()) {
            RetrofitUtils.getInstance().userInfo(ParamUtils.getParam(null), new HttpBack<User>(this) {
                @Override
                public void onSuccess(User user) {
                    UserUtils.saveUserInfo(user.getUserName(), user.getMemberType(), user.getVipExpireDate(), user.getUserImageUrl(),
                            user.getNickName(), user.getUserSex(), user.getBirthday(), user.getBindQQInfo(), user.getBindWXInfo());
                }

                @Override
                public void onFailure(String msg) {
                }

                @Override
                public void onTimeOut() {
                }
            });
        }
        //个推
        PushManager.getInstance().initialize(this.getApplicationContext(), PushService.class);
        PushManager.getInstance().registerPushIntentService(this.getApplicationContext(), PushIntentService.class);
    }

    private boolean isAppOnline() {
        return AppManager.isOpenApp(LoginActivity.class.getSimpleName() + MainActivity.class.getSimpleName());
    }

    private boolean isNotification() {
        return getIntent().getBooleanExtra(Constants.BundleName.IS_NOTIFICATION, false);
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

    private class LocationListener implements BDLocationListener {

        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            Logger.d("定位结束：" + bdLocation.getLocType());
            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation) {
                Logger.d("定位成功：" + bdLocation.getLatitude() + " - " + bdLocation.getLongitude() + " ，精度：" +
                        bdLocation.getRadius());
                CommunityUtils.setLongitude(bdLocation.getLongitude());
                CommunityUtils.setLatitude(bdLocation.getLatitude());
                CommunityUtils.setInitLocation(true);
            }
            if (locationUtils != null) {
                locationUtils.stopLoc();
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
            intent = new Intent(this, MainActivity.class);
        }
        intent.putExtra(Constants.BundleName.IS_NOTIFICATION, isNotification());
        startActivity(intent);
        finish();
    }

    /**
     * 是否是第一次打开应用
     */
    private boolean isFirstOpen() {
        return !PreferenceUtils.getBooleanPref(getApplicationContext(), PreferenceName.FIRST_OPEN, false);
    }

    /**
     * 屏蔽掉用户在该页面时回退的操作
     */
    @Override
    public void onBackPressed() {
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
