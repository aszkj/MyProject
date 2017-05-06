package com.yldbkd.www.seller.android.utils.http;

import retrofit.http.Field;
import retrofit.http.FormUrlEncoded;
import retrofit.http.POST;

/**
 * 请求数据接口
 * <p/>
 * Created by linghuxj on 15/9/23.
 */
public interface HttpService {

    /**
     * 3.1	发送验证码
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/system/sendcaptcha")
    void sendCaptcha(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.2  登录
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/user/login")
    void login(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.3  退出登录
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/user/logout")
    void loginOut(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.4  手机验证码验证
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/system/checkcode")
    void checkCode(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.5  重置(忘记)密码
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/user/resetpassword")
    void resetPassword(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.6  修改密码
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/user/updatepassword")
    void updatePassword(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.7  获取合伙人首页统计信息
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/statistic/indexstat")
    void indexStatistics(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.8  获取邀请用户信息列表
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/user/inviteusers")
    void inviteUsers(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.9  订单列表
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/order/orderlist")
    void orderList(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.10 订单详情
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/order/orderdetails")
    void orderDetail(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.11 订单接单
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/order/accept")
    void acceptOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.12 订单取消
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/order/cancel")
    void cancelOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.13 订单配送
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/order/delivery")
    void deliveryOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.14 订单收货
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/order/finish")
    void finishOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.15 获取商品类型列表
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/product/getproducttype")
    void productTypes(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.16 根据类型或关键字查询店铺中商品信息列表
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/product/searchproducts")
    void searchProducts(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.17	批量设置商品上下架

     */
    @FormUrlEncoded
    @POST("/interfaces/seller/product/enabledflag")
    void changeProductStatus(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.18 根据类型查询调货商品信息列表
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/product/searchproductsfortrans")
    void searchAllotProducts(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.19 确认调货单
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/allot/confirmallot")
    void confirmAllotOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.20 生成调货单
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/allot/createallot")
    void createAllotOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.21 调货单列表
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/allot/orderlist")
    void allotOrderList(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.22 调货单详情
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/allot/orderdetails")
    void allotOrderDetail(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.23 调货单验货
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/allot/checkallot")
    void checkAllotOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.24 调货单确认
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/allot/confirmcheckallot")
    void acceptAllotOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.25 获取店铺详细信息
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/store/detailinfo")
    void storeDetail(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.26 获取店铺首页结算信息
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/store/settlesimpleinfo")
    void storeSettle(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.27 修改店铺详细信息
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/store/updateinfo")
    void updateStore(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.28 获取统计汇总信息
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/statistic/summerizeinfo")
    void statisticsSummerize(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.29 铂金会员统计详细信息
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/statistic/vipuserdetail")
    void statisticsVip(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.30 订单结算统计详细信息
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/statistic/settledetail")
    void statisticsOrder(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.31 意见反馈
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/setting/feeback")
    void feeback(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.32 帮助中心地址
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/setting/helpaddress")
    void helpAddress(@Field("param") String param, HttpBack httpBack);

    /**
     * 3.33 查询用户信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/user/userinfo")
    void userInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.34 获取合伙人邀请会员数量信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/statistic/invitecount")
    void inviteCount(@Field("param") String param, HttpBack callback);

    /**
     * 3.35 同步当前手机推送标识符到服务器接口
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/store/saveclientid")
    void saveClientId(@Field("param") String param, HttpBack callback);

    /**
     * 3.36 根据类型查询品牌列表信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/brand/searchbrand")
    void searchBrand(@Field("param") String param, HttpBack callback);

    /**
     * 3.37	根据品牌编码查询商品分页列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/brand/searchproductbybrand")
    void searchProductByBrand(@Field("param") String param, HttpBack callback);
    /**
     * 3.38	合伙人相关数据统计接口
     */
    @FormUrlEncoded
    @POST("/interfaces/seller/statistic/summerizetotal")
    void getSummerizeTotal(@Field("param") String param, HttpBack callback);
}
