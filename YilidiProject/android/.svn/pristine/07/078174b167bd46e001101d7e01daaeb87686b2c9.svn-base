package com.yldbkd.www.seller.android.utils;

import android.content.Context;

import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;

/**
 * 定位工具类
 */
public class LocationUtils {

    public LocationClient locationClient = null;

    private static final int SCAN_SPAN = 5 * 1000; // 默认0，只请求一次；每隔ms请求一次数据

    private static LocationUtils utils;
    private Context context;

    public static LocationUtils getInstance() {
        if (utils == null) {
            utils = new LocationUtils();
        }
        return utils;
    }

    public void init(Context context) {
        this.init(context, null);
    }

    public void init(Context context, Integer scanSpan) {
        utils.setContext(context);
        initLocation(scanSpan);
    }

    /**
     * 初始化定位信息
     */
    private void initLocation(Integer scanSpan) {
        locationClient = new LocationClient(context);
        LocationClientOption option = new LocationClientOption();
        option.setCoorType("bd09ll");// 可选，默认gcj02，设置返回的定位结果坐标系
        option.setScanSpan(scanSpan == null ? SCAN_SPAN : scanSpan);// 可选，默认0，即仅定位一次，设置发起定位请求的间隔需要大于等于1000ms才是有效的
        option.setOpenGps(true);// 可选，默认false,设置是否使用gps
        option.setLocationNotify(true);// 可选，默认false，设置是否当gps有效时按照1S1次频率输出GPS结果
        locationClient.setLocOption(option);
    }

    public void registerLocationListener(BDLocationListener listener) {
        locationClient.registerLocationListener(listener);
    }

    public void startLoc() {
        // 开启定位
        if (locationClient == null) {
            return;
        }
        locationClient.start();
    }

    public void stopLoc() {
        // 退出时销毁定位
        if (locationClient == null) {
            return;
        }
        locationClient.stop();
    }

    public void setContext(Context context) {
        this.context = context;
    }
}
