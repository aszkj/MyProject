package com.yldbkd.www.seller.android.utils;

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
        // 用户店铺信息
        public static final String STORE_BASE = "storeBase";
        // 用户名
        public static final String LOGIN_NAME = "loginName";
        // 小区ID
        public static final String COMMUNITY_ID = "communityId";
        // 小区名称
        public static final String COMMUNITY_NAME = "communityName";
    }

    /**
     * 搜索相关
     */
    public static class Search {
        // 搜索历史
        public static final String SEARCH_PRODUCT_HISTORY = "searchProductHistory";
        public static final String SEARCH_ORDER_HISTORY = "searchOrderHistory";
    }

    /**
     * 购物车相关
     */
    public static class Cart {
        // 购物车数据信息
        public static final String CART_INFO = "cartInfo";
    }

    /**
     * 推送相关
     */
    public static class Receiver {
        // 唯一标识符
        public static final String CLIENT_ID = "clientId";
    }

}
