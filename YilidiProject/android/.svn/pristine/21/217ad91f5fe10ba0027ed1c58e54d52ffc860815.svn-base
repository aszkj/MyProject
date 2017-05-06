package com.yldbkd.www.buyer.android;

import android.app.Activity;
import android.app.Application;
import android.text.TextUtils;

import com.tencent.mm.sdk.openapi.IWXAPI;
import com.umeng.analytics.MobclickAgent;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.Brand;
import com.yldbkd.www.buyer.android.bean.CartInfo;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.bean.QQData;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.buyer.android.bean.WXData;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.SystemUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 买家系统应用基本类
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public class BuyerApp extends Application {
    public static IWXAPI iwxapi;
    private static BuyerApp app;
    // 登录状态
    public Boolean isLogin;
    // 登录用户名
    public String loginName;
    // 会员类型,0-普通会员,1-铂金会员
    public Integer memberType;
    // 会员到期时间
    public String vipExpireDate;
    // 会员到期时间
    public String userImageUrl;
    // 会员昵称
    public String nickName;
    // 性别
    public Integer sex;
    // 生日
    public String birthday;
    // qq信息
    public QQData qqData;
    // 微信信息
    public WXData wxData;
    // 当前小区信息
    public Community community;
    // 当前店铺信息
    public Store store;
    // 定位的经纬度
    public Double latitude, longitude;
    // 同步购物车的标志
    public Boolean synchronizeCartFlag;
    // 保存服务器用户登录的sessionID
    public String sessionId;
    // 购物车信息Map
    public Map<Integer, CartInfo> cartMap;
    // 自提标记
    public Boolean isTokeByMyself = false;

    public Long changeTime;

    private String jsonKey;
    private String domain;

    private String deviceId;

    private Integer loadingCount = 0;
    private final CharSequence loadingFlag = "0";

    public List<SaleProduct> zoneVipProducts = new ArrayList<>();
    public List<SaleProduct> zone1FenProducts = new ArrayList<>();
    //品牌排序数据缓存
    public List<Brand> brandsList = new ArrayList<>();
    // 推送相关的唯一手机标识符
    private String clientId;

    public BuyerApp() {
    }

    public static BuyerApp getInstance() {
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

        MobclickAgent.setScenarioType(this, MobclickAgent.EScenarioType.E_UM_NORMAL);
        MobclickAgent.UMAnalyticsConfig umAnalyticsConfig = new MobclickAgent.UMAnalyticsConfig(this, getResources().getString(R.string.umeng_app_key), "");
        MobclickAgent.startWithConfigure(umAnalyticsConfig);
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

    public String getDeviceId() {
        return deviceId;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }
}
