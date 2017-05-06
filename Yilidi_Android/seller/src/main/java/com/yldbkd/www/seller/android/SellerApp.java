package com.yldbkd.www.seller.android;

import android.app.Activity;
import android.app.Application;
import android.text.TextUtils;

import com.baidu.mapapi.SDKInitializer;
import com.igexin.sdk.PushManager;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.SystemUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.seller.android.activity.BaseActivity;
import com.yldbkd.www.seller.android.bean.Brand;
import com.yldbkd.www.seller.android.bean.StoreBase;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.Logger;

import java.util.ArrayList;
import java.util.List;

/**
 * 买家系统应用基本类
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public class SellerApp extends Application {

    private static SellerApp app;
    // 登录状态
    private Boolean isLogin;
    // 店铺基本信息
    private StoreBase store;
    // 邀请注册用户数
    private Integer inviteCount = 0;
    // VIP用户数
    private Integer vipUserCount = 0;
    // 推送相关的唯一手机标识符
    private String clientId;


    // 当前小区ID
    private Integer communityId;
    // 当前小区名称
    private String communityName;
    // 定位的经纬度
    private Double latitude, longitude;
    private String jsonKey;
    private String domain;
    private Integer loadingCount = 0;
    private final CharSequence loadingFlag = "0";
    private String deviceId;

    private String sessionId;

    // 记录注册时的手机号码
    public static String registPhone;
    public static boolean isRestTimer;
    //品牌排序数据缓存
    public List<Brand> brandsList = new ArrayList<>();

    public SellerApp() {
    }

    public static SellerApp getInstance() {
        return app;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        app = this;

        // 初始化时获取手机的DeviceId用于统计
        deviceId = SystemUtils.getDeviceId(this);

        // 初始化图片缓存信息,使用ImageLoader
        ImageLoaderUtils.initImageLoader(getApplicationContext());

        // 初始化异常信息捕获，发送与否自定义

        // 百度地图初始化
        SDKInitializer.initialize(getApplicationContext());

        // 个推推送初始化
        PushManager.getInstance().initialize(this.getApplicationContext());
    }

    public Boolean isLogin() {
        return isLogin;
    }

    public void setIsLogin(Boolean isLogin) {
        this.isLogin = isLogin;
    }

    public String getJsonKey() {
        if (jsonKey == null) {
            return "1";
        }
        return jsonKey;
    }

    public void setJsonKey(String jsonKey) {
        this.jsonKey = jsonKey;
    }

    public boolean isDebug() {
        return Constants.DEBUG.equals(getResources().getString(R.string.debug));
    }

    public String getDomain() {
        if (TextUtils.isEmpty(domain)) {
            domain = getResources().getString(R.string.domain);
        }
        return domain;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public Integer getCommunityId() {
        return communityId == null ? 0 : communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Integer getInviteCount() {
        return inviteCount;
    }

    public void setInviteCount(Integer inviteCount) {
        this.inviteCount = inviteCount;
    }

    public Integer getVipUserCount() {
        return vipUserCount;
    }

    public void setVipUserCount(Integer vipUserCount) {
        this.vipUserCount = vipUserCount;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public StoreBase getStore() {
        return store;
    }

    public void setStore(StoreBase store) {
        this.store = store;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void addLoading() {
        synchronized (loadingFlag) {
            loadingCount += 1;
        }
        Logger.d("当前需要Loading的计数：" + loadingCount);
        Activity activity = AppManager.getAppManager().currentActivity();
        ((BaseActivity) activity).getProgressHandler().obtainMessage(Constants.HandlerCode.PROGRESS_SHOW).sendToTarget();
    }

    public void removeLoading() {
        synchronized (loadingFlag) {
            loadingCount -= 1;
        }
        Activity activity = AppManager.getAppManager().currentActivity();
        if (activity == null) {
            Logger.e("当前Activity不存在，请检查！");
            return;
        }
        if (loadingCount <= 0) {
            loadingCount = 0;
            ((BaseActivity) activity).getProgressHandler().obtainMessage(Constants.HandlerCode.PROGRESS_HIDE)
                    .sendToTarget();
        }
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
}
