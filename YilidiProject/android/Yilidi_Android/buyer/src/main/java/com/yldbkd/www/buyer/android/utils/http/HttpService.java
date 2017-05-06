package com.yldbkd.www.buyer.android.utils.http;

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
     * 3.1 发送验证码接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/system/sendcaptcha")
    void sendIdCode(@Field("param") String param, HttpBack callback);

    /**
     * 3.2 注册接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/user/regist")
    void register(@Field("param") String param, HttpBack callback);

    /**
     * 3.3 登录接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/login")
    void login(@Field("param") String param, HttpBack callback);

    /**
     * 3.4 退出登录接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/user/logout")
    void logOut(@Field("param") String param, HttpBack callback);

    /**
     * 3.5 手机验证码验证接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/system/checkcaptcha")
    void checkMobileCode(@Field("param") String param, HttpBack callback);

    /**
     * 3.6 重置密码接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/user/resetpassword")
    void resetPassword(@Field("param") String param, HttpBack callback);

    /**
     * 3.7 轮播广告列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/system/getimagerotate")
    void getAdverts(@Field("param") String param, HttpBack callback);

    /**
     * 3.8 定位查询获取当前小区信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/location")
    void getLocation(@Field("param") String param, HttpBack callback);

    /**
     * 3.9 定位小区列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/user/locationlist")
    void getLocationList(@Field("param") String param, HttpBack callback);

    /**
     * 3.10 商品类型列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/product/getproducttype")
    void getProductType(@Field("param") String param, HttpBack callback);

    /**
     * 3.11 收货地址列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/useraddress/addresslist")
    void getUserAddressList(@Field("param") String param, HttpBack callback);

    /**
     * 3.12 收货地址详细信息接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/useraddress/addressdetail")
    void getAddressDetail(@Field("param") String param, HttpBack callback);

    /**
     * 3.13 小区搜索接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/user/communitysearch")
    void communitySearch(@Field("param") String param, HttpBack callback);


    /**
     * 3.14 获取热门商品关键字接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/system/hotproductkey")
    void getHotProductKey(@Field("param") String param, HttpBack callback);


    /**
     * 3.15 所需区域的地址信息字典数据接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/system/loadarea")
    void loadArea(@Field("param") String param, HttpBack callback);

    /**
     * 3.16 搜索当前店铺商品列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/product/searchproducts")
    void searchProducts(@Field("param") String param, HttpBack callback);

    /**
     * 3.17 店铺信息接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/store/shopinformation")
    void getStoreInformation(@Field("param") String param, HttpBack callback);

    /**
     * 3.18 查询商品详情
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/product/productdetail")
    void getProductDetail(@Field("param") String param, HttpBack callback);


    /**
     * 3.19 确认购物车接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/confirmcart")
    void confirmCart(@Field("param") String param, HttpBack callback);


    /**
     * 3.20 新增/修改收货地址信息接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/useraddress/addupdateuseraddress")
    void updateUserAddress(@Field("param") String param, HttpBack callback);

    /**
     * 3.21 订单结算接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/settlementorder")
    void settlementOrder(@Field("param") String param, HttpBack callback);

    /**
     * 3.22 生成订单接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/createorder")
    void commitOrder(@Field("param") String param, HttpBack callback);


    /**
     * 3.23 获取消息列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/user/messagelist")
    void getMessageList(@Field("param") String param, HttpBack callback);


    /**
     * 3.24 查询用户订单列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/order/orderlist")
    void getOrderesList(@Field("param") String param, HttpBack callback);


    /**
     * 3.25 查询用户订单详情数据接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/order/orderdetail")
    void getOrderesDetail(@Field("param") String param, HttpBack callback);


    /**
     * 3.26 同步购物车数据接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/synchronouscart")
    void synchronizeCart(@Field("param") String param, HttpBack callback);

    /**
     * 3.27 取消订单接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/order/cancel")
    void cancelOrder(@Field("param") String param, HttpBack callback);


    /**
     * 3.28 订单确认收货接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/order/confirm")
    void receiveOrder(@Field("param") String param, HttpBack callback);

    /**
     * 3.29 调整购物车数量接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/adjustmentcartcount")
    void modifyCart(@Field("param") String param, HttpBack callback);

    /**
     * 3.30 获取订单支付宝支付信息接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/pay/alipayapporderparam")
    void getAliPayInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.31 获取订单微信支付信息接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/pay/wxpayapporderparam")
    void getWXPayInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.32 修改密码接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/user/updatepassword")
    void modifyPassword(@Field("param") String param, HttpBack callback);

    /**
     * 3.33 清除用户购物车数据接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/clearcart")
    void clearCartProduct(@Field("param") String param, HttpBack callback);

    /**
     * 3.34 获取类型所对应的规则或协议页面URL地址接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/system/gettypeurl")
    void getRuleAgreementURL(@Field("param") String param, HttpBack callback);

    /**
     * 3.35 获取首页专区列表接口
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/product/homezones")
    void getHomePrefecture(@Field("param") String param, HttpBack callback);

    /**
     * 3.36 删除收获地址
     */

    @FormUrlEncoded
    @POST("/interfaces/buyer/useraddress/invaliduseraddress")
    void deleteUserAddress(@Field("param") String param, HttpBack callback);


    /**
     * 3.38 获取专区商品信息列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/zoneproduct")
    void zoneProduct(@Field("param") String param, HttpBack callback);

    /**
     * 3.39 查询用户信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/userinfo")
    void userInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.40 根据小区ID获取小区详细信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/communityinfo")
    void communityById(@Field("param") String param, HttpBack callback);

    /**
     * 3.41 根据二维码或者条码获取商品信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/productbybarcode")
    void productByBarcode(@Field("param") String param, HttpBack callback);

    /**
     * 3.42 经纬度获取店铺信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/store/locationlist")
    void getStoreList(@Field("param") String param, HttpBack callback);

    /**
     * 3.43 支付成功页面数据信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/order/paysuccessinfo")
    void paySuccessOrderInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.44 分类专区商品列表
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/homeclasszoneproducts")
    void zoneProductList(@Field("param") String param, HttpBack callback);

    /**
     * 3.45 查询秒杀活动信息列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/activity/seckillinfolist")
    void seckillInfoList(@Field("param") String param, HttpBack callback);

    /**
     * 3.46 查询首页正在活动的秒杀活动信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/activity/activityseckillinfo")
    void seckillInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.47 根据秒杀活动ID查询活动商品列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/activity/seckillproducts")
    void seckillProducts(@Field("param") String param, HttpBack callback);

    /**
     * 3.48 查询专题信息数据
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/themeinfo")
    void seminarInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.49 查询首页楼层相关信息数据接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/homefloors")
    void homeFloors(@Field("param") String param, HttpBack callback);

    /**
     * 3.50 根据楼层ID查询楼层商品列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/floorproducts")
    void floorProducts(@Field("param") String param, HttpBack callback);

    /**
     * 3.51 用户活动期内参与抢红包活动信息数据接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/activity/userredenvelopeinfo")
    void userRedEnvelopInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.52	用户开始抢红包活动信息数据接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/activity/startgrabredenvelope")
    void startGradRedEnvelop(@Field("param") String param, HttpBack callback);

    /**
     * 3.53 抢红包接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/activity/grabredenvelope")
    void gradRedEnvelop(@Field("param") String param, HttpBack callback);

    /**
     * 3.54 微信第三方登录接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/weixinlogin")
    void wxLogin(@Field("param") String param, HttpBack callback);

    /**
     * 3.55 QQ第三方登录接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/qqlogin")
    void qqLogin(@Field("param") String param, HttpBack callback);

    /**
     * 3.56 用户奖券列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/activity/userticketinfo")
    void userticketList(@Field("param") String param, HttpBack callback);


    /**
     * 3.57 用户修改头像接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/updateavatar")
    void changeUserImage(@Field("param") String param, HttpBack callback);

    /**
     * 3.58 用户手机号绑定接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/oauth2/user/bind")
    void bindMobile(@Field("param") String param, HttpBack callback);

    /**
     * 3.59 用户账本信息总汇接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/accountinfo")
    void accountInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.60 意见反馈接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/saveBuyerFeedback")
    void feedback(@Field("param") String param, HttpBack callback);

    /**
     * 3.61 购物车奖券结算信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/settlementordertickets")
    void settlementOrderTickets(@Field("param") String param, HttpBack callback);

    /**
     * 3.62 分享送好礼信息总汇接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/shareactivityinfo")
    void shareActivityinfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.63	分享送好礼邀请排行榜接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/invitetop")
    void shareInviteTop(@Field("param") String param, HttpBack callback);

    /**
     * 3.64	分享送好礼我的邀请记录接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/myinvite")
    void shareMyInvite(@Field("param") String param, HttpBack callback);

    /**
     * 3.65	分享送好礼我的邀请总汇接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/myinvitesummary")
    void shareMyInviteSummary(@Field("param") String param, HttpBack callback);

    /**
     * 3.66	获取分享微信好友信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/sharetoweixinfriends")
    void shareWEChat(@Field("param") String param, HttpBack callback);

    /**
     * 3.67	获取分享微信朋友圈信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/sharetomoments")
    void shareWECircle(@Field("param") String param, HttpBack callback);

    /**
     * 3.68	获取分享短信信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/sharetosms")
    void shareSms(@Field("param") String param, HttpBack callback);

    /**
     * 3.69	根据分享唯一标识获取分享活动信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/infobysharecode")
    void getShareActInfoByCode(@Field("param") String param, HttpBack callback);

    /**
     * 3.70	分享送好礼新用户领取注册信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/share/acceptinvite")
    void getAcceptInvite(@Field("param") String param, HttpBack callback);

    /**
     * 3.71	根据类型查询品牌列表信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/brand/searchbrand")
    void searchBrand(@Field("param") String param, HttpBack callback);

    /**
     * 3.73	根据品牌编码查询商品分页列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/brand/searchproductbybrand")
    void searchBrandProduct(@Field("param") String param, HttpBack callback);

    /**
     * 3.74	商品加入购物车前业务判断接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/validationbeforeaddcart")
    void validationBeforeAddCart(@Field("param") String param, HttpBack callback);

    /**
     * 3.75	新版同步调整购物车数量接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/asycnchangecart")
    void asycnchangeCart(@Field("param") String param, HttpBack callback);

    /**
     * 3.76	获取购物车信息列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/cart/cartinfo")
    void getCartInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.77	根据关键字搜索品牌列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/brand/searchbykeywords")
    void searchBrandByKeywords(@Field("param") String param, HttpBack callback);

    /**
     * 3.78	应用首页图标数据列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/home/appicons")
    void getFunctionLogo(@Field("param") String param, HttpBack callback);

    /**
     * 3.79	评价店铺商品相关内容接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/evaluate/saveevaluation")
    void saveEvalution(@Field("param") String param, HttpBack callback);

    /**
     * 3.80	获取商品评价内容信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/getevaluations")
    void getEvalution(@Field("param") String param, HttpBack callback);

    /**
     * 3.81	获取商品评价内容汇总信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/getevaluationsummary")
    void getEvaluationSummary(@Field("param") String param, HttpBack callback);

    /**
     * 3.82	收藏商品接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/collectsaleproduct")
    void collectSaleProduct(@Field("param") String param, HttpBack callback);

    /**
     * 3.82	查询用户收藏的商品列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/saleproductcollections")
    void getCollects(@Field("param") String param, HttpBack callback);

    /**
     * 3.84	取消已收藏商品接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/product/cancelwithcollected")
    void collectCancelSaleProduct(@Field("param") String param, HttpBack callback);

    /**
     * 3.85	修改用户个人资料接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/modifyuserinfo")
    void modifyUserInfo(@Field("param") String param, HttpBack callback);

    /**
     * 3.86	用户绑定微信接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/bind/bindwx")
    void bindWX(@Field("param") String param, HttpBack callback);

    /**
     * 3.87	取消用户绑定微信接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/bind/unbindwx")
    void unbindWX(@Field("param") String param, HttpBack callback);

    /**
     * 3.88	用户绑定QQ接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/bind/bindqq")
    void bindQQ(@Field("param") String param, HttpBack callback);

    /**
     * 3.89	取消用户绑定QQ接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/bind/unbindqq")
    void unbindQQ(@Field("param") String param, HttpBack callback);

    /**
     * 3.90	用户更改绑定手机接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/bind/changemobilewithbinding")
    void changeMobile(@Field("param") String param, HttpBack callback);

    /**
     * 3.91	上传用户头像图片接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/upload/userImage")
    void uploadUserImage(@Field("param") String param, HttpBack callback);

    /**
     * 3.92	上传用户评论图片接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/upload/evaluateimage")
    void uploadEvaluateImage(@Field("param") String param, HttpBack callback);

    /**
     * 3.93 同步当前手机推送标识符到服务器接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/user/saveclientid")
    void saveClientId(@Field("param") String param, HttpBack callback);

    /**
     * 3.94	用户消息汇总信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/message/usermessages")
    void userMessage(@Field("param") String param, HttpBack callback);

    /**
     * 3.95	根据消息类型查询用户消息列表接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/message/usermessagesbytype")
    void checkedMessageByType(@Field("param") String param, HttpBack callback);

    /**
     * 3.96	查询用户消息详细内容接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/message/messagedetail")
    void messageDetail(@Field("param") String param, HttpBack callback);

    /**
     * 3.97	查询订单退款详细信息接口
     */
    @FormUrlEncoded
    @POST("/interfaces/buyer/order/refundinfo")
    void getRefundInfo(@Field("param") String param, HttpBack callback);
}
