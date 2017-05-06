package com.yldbkd.www.buyer.android.utils;

import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.text.TextUtils;

import com.google.gson.Gson;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.bean.QQData;
import com.yldbkd.www.buyer.android.bean.WXData;
import com.yldbkd.www.library.android.common.PreferenceUtils;

/**
 * 用户信息工具类
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class UserUtils {
    /**
     * 保存用户登陆后的信息
     *
     * @param userName      用户名
     * @param memberType    会员类型,0-普通会员,1-铂金会员
     * @param vipExpireDate 会员有效期
     * @param userImageUrl  用户头像
     */
    public static void saveUserInfo(String userName, int memberType, String vipExpireDate, String userImageUrl,
                                    String nickName, Integer sex, String birthday, QQData qqData, WXData wxData) {
        BuyerApp app = BuyerApp.getInstance();
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        app.isLogin = true;
        app.loginName = userName;
        app.memberType = memberType;
        app.vipExpireDate = vipExpireDate;
        app.userImageUrl = userImageUrl;
        app.nickName = nickName;
        app.sex = sex;
        if (TextUtils.isEmpty(birthday) || birthday.length() < 10) {
            app.birthday = null;
        } else {
            app.birthday = birthday.substring(0, 10);
        }
        app.qqData = qqData;
        app.wxData = wxData;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(app.getApplicationContext());
        if (sharedpreferences == null) {
            return;
        }
        editor = sharedpreferences.edit();
        editor.putBoolean(PreferenceName.User.IS_LOGIN, app.isLogin);
        editor.putString(PreferenceName.User.LOGIN_NAME, app.loginName);
        editor.putString(PreferenceName.User.USER_NAME, app.loginName);
        editor.putInt(PreferenceName.User.MEMBER_TYPE, app.memberType);
        editor.putString(PreferenceName.User.VIP_EXPIREDATE, app.vipExpireDate);
        editor.putString(PreferenceName.User.USER_IMAGE_URL, app.userImageUrl);
        editor.putString(PreferenceName.User.USER_NICK_NAME, app.nickName);
        editor.putInt(PreferenceName.User.USER_SEX, app.sex);
        editor.putString(PreferenceName.User.USER_BIRTHDAY, app.birthday);
        editor.putString(PreferenceName.User.USER_QQ_DATA, new Gson().toJson(app.qqData));
        editor.putString(PreferenceName.User.USER_WX_DATA, new Gson().toJson(app.wxData));
        editor.apply();
    }

    /**
     * 获取用户等级  0-普通用户  1-铂金会员
     */
    public static Integer getMemberType() {
        BuyerApp app = BuyerApp.getInstance();
        if (isLogin()) {
            if (app.memberType == null) {
                app.memberType = PreferenceUtils.getIntPref(app.getApplicationContext(),
                        PreferenceName.User.MEMBER_TYPE, 0);
            }
        } else {
            app.memberType = Constants.MemberType.NORMAL;
        }
        return app.memberType;
    }

    /**
     * 获取用户VIP到期时间
     */
    public static String getExpireDate() {
        BuyerApp app = BuyerApp.getInstance();
        if (getMemberType() == Constants.MemberType.VIP) {
            if (app.vipExpireDate == null) {
                app.vipExpireDate = PreferenceUtils.getStringPref(app.getApplicationContext(),
                        PreferenceName.User.VIP_EXPIREDATE, null);
            }
        }
        return app.vipExpireDate;
    }

    /**
     * 获取用户头像
     */
    public static String getUserIamgeUrl() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.userImageUrl == null) {
            app.userImageUrl = PreferenceUtils.getStringPref(app.getApplicationContext(),
                    PreferenceName.User.USER_IMAGE_URL, null);
        }
        return app.userImageUrl;
    }

    /**
     * 设置用户头像
     */
    public static void setUserIamgeUrl(String imageUrl) {
        BuyerApp app = BuyerApp.getInstance();
        app.userImageUrl = imageUrl;
        PreferenceUtils.setStringPref(app.getApplicationContext(),
                PreferenceName.User.USER_IMAGE_URL, imageUrl);
    }

    /**
     * 设置用户昵称
     */
    public static void setNickName(String nickname) {
        BuyerApp app = BuyerApp.getInstance();
        app.nickName = nickname;
        PreferenceUtils.setStringPref(app.getApplicationContext(),
                PreferenceName.User.USER_NICK_NAME, nickname);
    }

    /**
     * 设置用户性别
     */
    public static void setGender(int sex) {
        BuyerApp app = BuyerApp.getInstance();
        app.sex = sex;
        PreferenceUtils.setIntPref(app.getApplicationContext(),
                PreferenceName.User.USER_SEX, sex);
    }

    /**
     * 设置用户生日
     */
    public static void setBirthday(String birthday) {
        BuyerApp app = BuyerApp.getInstance();
        app.birthday = birthday;
        PreferenceUtils.setStringPref(app.getApplicationContext(),
                PreferenceName.User.USER_BIRTHDAY, birthday);
    }

    /**
     * 设置用户绑定QQ信息
     */
    public static void setQQData(QQData qqData) {
        BuyerApp app = BuyerApp.getInstance();
        app.qqData = qqData;
        PreferenceUtils.setStringPref(app.getApplicationContext(),
                PreferenceName.User.USER_QQ_DATA, new Gson().toJson(qqData));
    }

    /**
     * 设置用户绑定微信信息
     */
    public static void setWXData(WXData wxData) {
        BuyerApp app = BuyerApp.getInstance();
        app.wxData = wxData;
        PreferenceUtils.setStringPref(app.getApplicationContext(),
                PreferenceName.User.USER_WX_DATA, new Gson().toJson(wxData));
    }

    /**
     * 获取用户登陆状态
     *
     * @return
     */
    public static boolean isLogin() {
        BuyerApp app = BuyerApp.getInstance();
        Boolean isLogin = app.isLogin;
        if (isLogin == null) {
            // 此时代表着刚打开APP，还没有进行登陆状态使用的情况，因需要记住登陆状态所以使用SharedPreference来替换该状态
            app.isLogin = PreferenceUtils.getBooleanPref(app.getApplicationContext(), PreferenceName.User.IS_LOGIN, false);
            isLogin = app.isLogin;
        }
        return isLogin;
    }

    /**
     * 获取登陆用户名
     *
     * @return 未登陆情况下返回null
     */
    public static String getUserName() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.loginName == null) {
            app.loginName = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.User.LOGIN_NAME, null);
        }
        return app.loginName;
    }

    /**
     * 获取登陆用户名
     *
     * @return 未登陆情况下返回null
     */
    public static String getLoginName() {
        return getUserName();
    }

    /**
     * 获取用户昵称
     */
    public static String getNickName() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.nickName == null) {
            app.nickName = PreferenceUtils.getStringPref(app.getApplicationContext(),
                    PreferenceName.User.USER_NICK_NAME, null);
        }
        return app.nickName;
    }

    /**
     * 获取用户性别
     */
    public static Integer getSex() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.sex == null) {
            app.sex = PreferenceUtils.getIntPref(app.getApplicationContext(),
                    PreferenceName.User.USER_SEX, 1);
        }
        return app.sex;
    }

    /**
     * 获取用户生日
     */
    public static String getBirthday() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.birthday == null) {
            app.birthday = PreferenceUtils.getStringPref(app.getApplicationContext(),
                    PreferenceName.User.USER_BIRTHDAY, null);
        }
        return app.birthday;
    }

    /**
     * 获取用户绑定QQ信息
     */
    public static QQData getQQData() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.qqData == null) {
            String qqDataString = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.User.USER_QQ_DATA, null);
            if (qqDataString == null) {
                return null;
            }
            app.qqData = new Gson().fromJson(qqDataString, QQData.class);
        }
        return app.qqData;
    }

    /**
     * 获取用户绑定微信信息
     */
    public static WXData getWXData() {
        BuyerApp app = BuyerApp.getInstance();
        if (app.wxData == null) {
            String wxDataString = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.User.USER_WX_DATA, null);
            if (wxDataString == null) {
                return null;
            }
            app.wxData = new Gson().fromJson(wxDataString, WXData.class);
        }
        return app.wxData;
    }

    /**
     * 清除用户登陆信息（在用户注销时，登陆超时情况下使用）
     */
    public static void clearLoginInfo() {
        BuyerApp app = BuyerApp.getInstance();
        app.isLogin = false;
        app.sessionId = null;
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(app.getApplicationContext());
        if (sharedpreferences != null) {
            editor = sharedpreferences.edit();
            editor.remove(PreferenceName.User.IS_LOGIN);
            editor.remove(PreferenceName.User.USER_NAME);
            editor.remove(PreferenceName.PREF_COOKIES);
            editor.apply();
        }
        CartUtils.clearCart();
    }
}
