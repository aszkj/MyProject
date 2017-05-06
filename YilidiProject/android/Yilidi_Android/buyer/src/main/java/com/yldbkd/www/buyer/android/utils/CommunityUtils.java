package com.yldbkd.www.buyer.android.utils;

import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.text.TextUtils;

import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.library.android.common.PreferenceUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 判断店铺信息工具类
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class CommunityUtils {

    private static boolean isInitLocation = true;

    public static boolean isStoreOn(Store store) {
        if (store == null) {
            return false;
        }
        if (store.getStoreStatus() == null || Constants.StoreStatus.PAUSE.equals(store.getStoreStatus())) {
            return false;
        }
        String beginTime = store.getBusinessHoursBegin();
        String endTime = store.getBusinessHoursEnd();
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat(Constants.TIME_FORMAT, Locale.getDefault());
        String currentTime = dateFormat.format(date);
        return currentTime.compareTo(beginTime) >= 0 && currentTime.compareTo(endTime) <= 0;
    }

    public static Community getCurrentCommunity() {
        return BuyerApp.getInstance().community;
    }

    public static Store getCurrentStore() {
        return BuyerApp.getInstance().store;
    }

    public static Integer getCurrentCommunityId() {
        return getCurrentCommunity() == null ? null : getCurrentCommunity().getCommunityId();
    }

    public static String getCurrentCommunityName() {
        return getCurrentCommunity() == null ? "" : getCurrentCommunity().getCommunityName();
    }

    public static Double getLatitude() {
        return BuyerApp.getInstance().latitude;
    }

    public static Double getLongitude() {
        return BuyerApp.getInstance().longitude;
    }

    public static Integer getCurrentStoreId() {
        BuyerApp app = BuyerApp.getInstance();
        Store store = getCurrentStore();
        if (store == null) {
            int id = PreferenceUtils.getIntPref(app.getApplicationContext(), PreferenceName.Store.STORE_ID, -1);
            return id == -1 ? null : id;
        } else {
            return store.getStoreId();
        }
    }

    public static void setCurrentCommunity(Community community) {
        BuyerApp.getInstance().community = community;
        if (community == null || community.getStoreInfo() == null) {
            return;
        }
        setCurrentStore(community.getStoreInfo());
    }

    public static void setCurrentStore(Store store) {
        BuyerApp.getInstance().store = store;
        if (store == null) {
            setCurrentStoreId(null);
        } else {
            setCurrentStoreId(store.getStoreId());
        }
    }

    private static void setCurrentStoreId(Integer storeId) {
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(BuyerApp.getInstance().getApplicationContext());
        if (sharedpreferences == null) {
            return;
        }
        editor = sharedpreferences.edit();
        if (storeId == null) {
            editor.remove(PreferenceName.Store.STORE_ID);
        } else {
            editor.putInt(PreferenceName.Store.STORE_ID, storeId);
        }
        editor.apply();
    }

    public static void setLatitude(Double latitude) {
        BuyerApp.getInstance().latitude = latitude;
    }

    public static void setLongitude(Double longitude) {
        BuyerApp.getInstance().longitude = longitude;
    }

    public static void setInitLocation(boolean isInit) {
        isInitLocation = isInit;
    }

    public static boolean isInitLocation() { // 使用初始化定位获取信息，只使用一次
        return isInitLocation;
    }

    public static String notifyStoreBusinessSendTime(Store store) {
        if (store == null) {
            return null;
        }
        String beginTime = store.getBusinessHoursBegin();
        if (TextUtils.isEmpty(beginTime)) {
            return null;
        }
        String[] split = beginTime.split(":");
        return String.valueOf(String.valueOf(Integer.valueOf(split[0]) + 1) + String.valueOf(":") + split[1]);
    }

    public static String getCurrentStoreStatus() {
        Store store = getCurrentStore();
        if (store == null) {
            return Constants.StoreStatus.PAUSE;
        }
        if (store.getStoreStatus() == null) {
            return Constants.StoreStatus.PAUSE;
        }
        return store.getStoreStatus();
    }

    public static void isTokeByMyself(boolean isToke) { // 是否选择自提店铺
        BuyerApp.getInstance().isTokeByMyself = isToke;
    }

    public static boolean getIsTokeByMyself() { // 是否选择自提店铺
        return BuyerApp.getInstance().isTokeByMyself;
    }
}
