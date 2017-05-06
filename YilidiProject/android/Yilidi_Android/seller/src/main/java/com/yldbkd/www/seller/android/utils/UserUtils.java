package com.yldbkd.www.seller.android.utils;

import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import com.google.gson.Gson;
import com.yldbkd.www.library.android.common.PreferenceUtils;
import com.yldbkd.www.seller.android.SellerApp;
import com.yldbkd.www.seller.android.bean.StoreBase;

/**
 * 用户信息工具类
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class UserUtils {

    /**
     * 保存用户登陆后的信息
     *
     * @param userName 用户名
     */
    public static void saveUserInfo(String userName, StoreBase store) {
        SellerApp app = SellerApp.getInstance();
        app.setIsLogin(true);
        app.setStore(store);
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(app.getApplicationContext());
        if (sharedpreferences == null) {
            return;
        }
        editor = sharedpreferences.edit();
        editor.putBoolean(PreferenceName.User.IS_LOGIN, true);
        editor.putString(PreferenceName.User.LOGIN_NAME, userName);
        editor.putString(PreferenceName.User.STORE_BASE, new Gson().toJson(store));
        editor.apply();
    }

    /**
     * 获取用户登陆状态
     *
     * @return
     */
    public static boolean isLogin() {
        SellerApp app = SellerApp.getInstance();
        Boolean isLogin = app.isLogin();
        if (isLogin == null) {
            // 此时代表着刚打开APP，还没有进行登陆状态使用的情况，因需要记住登陆状态所以使用SharedPreference来替换该状态
            isLogin = PreferenceUtils.getBooleanPref(app.getApplicationContext(), PreferenceName.User.IS_LOGIN, false);
            app.setIsLogin(isLogin);
        }
        return isLogin;
    }

    /**
     * 获取登陆用户名
     *
     * @return 未登陆情况下返回null
     */
    public static String getLoginName() {
        return PreferenceUtils.getStringPref(SellerApp.getInstance().getApplicationContext(), PreferenceName.User.LOGIN_NAME, null);
    }

    /**
     * 获取用户店铺信息
     *
     * @return
     */
    public static StoreBase getStore() {
        SellerApp app = SellerApp.getInstance();
        StoreBase store = app.getStore();
        if (store == null) {
            // 此时代表着刚打开APP，还没有进行登陆状态使用的情况，因需要记住登陆状态所以使用SharedPreference来替换该状态
            String storeStr = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.User.STORE_BASE, null);
            store = new Gson().fromJson(storeStr, StoreBase.class);
            app.setStore(store);
        }
        return store;
    }

    /**
     * 清除用户登陆信息（在用户注销时，登陆超时情况下使用）
     */
    public static void clearLoginInfo() {
        SellerApp app = SellerApp.getInstance();
        app.setIsLogin(false);
        app.setStore(null);
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(app.getApplicationContext());
        if (sharedpreferences != null) {
            editor = sharedpreferences.edit();
            editor.remove(PreferenceName.User.IS_LOGIN);
            editor.remove(PreferenceName.User.STORE_BASE);
            editor.remove(PreferenceName.PREF_COOKIES);
            editor.apply();
        }
    }
}
