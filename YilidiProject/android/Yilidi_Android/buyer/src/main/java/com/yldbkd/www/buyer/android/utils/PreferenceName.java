package com.yldbkd.www.buyer.android.utils;

/**
 * Preferences数据存储名称
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class PreferenceName {

    // 第一次打开应用
    public static final String FIRST_OPEN = "firstOpen";

    public static final String PREF_COOKIES = "prefCookies";

    /**
     * 用户信息相关
     */
    public static class User {
        // 是否登录
        public static final String IS_LOGIN = "isLogin";
        // 用户名
        public static final String USER_NAME = "userName";
        // 用户名
        public static final String LOGIN_NAME = "loginName";
        // 登录名历史
        public static final String LOGIN_NAME_HISTORY = "loginNameHistory";
        // 客户等级
        public static final String MEMBER_TYPE = "memberType";
        // 会员有效期
        public static final String VIP_EXPIREDATE = "vipExpireDate";
        // 用户头像
        public static final String USER_IMAGE_URL = "userImageUrl";
        // 用户昵称
        public static final String USER_NICK_NAME = "userNickName";
        // 用户性别
        public static final String USER_SEX = "userSex";
        // 用户生日
        public static final String USER_BIRTHDAY = "userBirthday";
        // 用户QQ信息
        public static final String USER_QQ_DATA = "userQQData";
        // 用户微信信息
        public static final String USER_WX_DATA = "userWXData";
    }

    /**
     * 搜索相关
     */
    public static class Search {
        // 产品搜索历史
        public static final String SEARCH_HISTORY = "searchHistory";
        // 社区搜索历史
        public static final String SEARCH_Location_HISTORY = "searchLocationHistory";
    }

    /**
     * 购物车相关
     */
    public static class Cart {
        // 购物车数据信息
        public static final String CART_INFO = "cartInfo";
        // 是否同步
        public static final String IS_SYNCHRONIZE = "isSynchronize";
    }

    /**
     * 店铺相关
     */
    public static class Store {
        // 店铺基本ID
        public static final String STORE_ID = "storeId";
    }
    /**
     * 推送相关
     */
    public static class Service {
        // 唯一标识符
        public static final String CLIENT_ID = "clientId";
    }
}
