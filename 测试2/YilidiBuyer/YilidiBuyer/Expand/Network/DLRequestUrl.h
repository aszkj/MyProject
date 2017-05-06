//
//  DLRequestUrl.h
//  YilidiSeller
//
//  Created by yld on 16/3/23.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#ifndef DLRequestUrl_h
#define DLRequestUrl_h

//#define ServerDomain @"192.168.0.92"

//联调主机
//#define BASEURL @"http://192.168.1.65:8090/interfaces/buyer/"
//#define ServerDomain @"http://buyertest.yldbkd.com"
//#define ImgServerDomain  @"http://upload.yldbkd.com"
//#define POSTIMAGEURL @"http://optest.yldbkd.com/"

//测试
#define BASEURL @"http://buyertest.yldbkd.com/interfaces/buyer/"
#define ServerDomain @"http://buyertest.yldbkd.com"
#define ImgServerDomain  @"http://uploadtest.yldbkd.com"
#define POSTIMAGEURL @"http://optest.yldbkd.com/"
//
//正式
//#define BASEURL @"http://buyer.yldbkd.com:8080/interfaces/buyer/"
//#define ServerDomain @"http://buyer.yldbkd.com"
//#define ImgServerDomain  @"http://upload.yldbkd.com"
//#define POSTIMAGEURL @"http://op.yldbkd.com/"

#define kUrl_HomeIcon                  @"/images/home/"
#define kUrl_CordovaTestHtml           @"/h5/cordovatest.html"

#pragma mark ------------------ login&register -------------
#define kUrl_WechatLogin      @"user/weixinlogin"
#define kUrl_QQLogin          @"user/qqlogin"
#define kUrl_Login            @"user/login"
#define kUrl_Logout           @"user/logout"
#define kUrl_Regist           @"user/regist"
#define kUrl_VerificationCode @"system/sendcaptcha"
#define kUrl_VerfivationCheck @"system/checkcaptcha"
#define kUrl_ForgotPassword   @"user/resetpassword"
#define kUrl_Changepassword   @"user/updatepassword"
#define kUrl_Binding          @"oauth2/user/bind"
#define kUrl_PostUserImage    @"operation/upload/userImage"

#pragma mark ------------------ home -------------------
#define kUrl_HomeHeaderLoopPlayUrl @"system/getimagerotate"
#define kUrl_HomeClassGoodsList   @"product/homezones"
#define kUrl_GoodsDetail          @"product/productdetail"
#define kUrl_GoodsSearch          @"product/searchproducts"
#define kUrl_GoodsSearchHoteKey   @"system/hotproductkey"
#define kUrl_GoodsTypeList        @"product/getproducttype"
#define kUrl_GetPerfectureGoods   @"product/zoneproduct"
#define kUrl_GetClassZoneProducts     @"product/themeinfo"
#define kUrl_SearchGoodsInfoByQrCode  @"product/productbybarcode"
#define kUrl_GetNearbyStoreList    @"store/locationlist"
#define kUrl_GetSeckillActivityInfoList @"activity/seckillinfolist"
#define kUrl_GetSekillGoodsList     @"activity/seckillproducts"
#define kUrl_GetHomeSeckillActivityInfo @"activity/activityseckillinfo"
#define kUrl_GetHomeFloorInfo           @"product/homefloors"
#define kUrl_GetFloorProducts       @"product/floorproducts"
#define kUrl_GetUserInfo             @"user/userinfo"
#define kUrl_GetTypeUrl                @"system/gettypeurl"
#define kUrl_PostUserHeaderUrl         @"user/updateavatar"
#define kUrl_AccountInfoUrl            @"user/accountinfo"
#pragma mark ------------------ RedPacket -------------------
#define kUrl_GetGrabRedPacketGameInfo  @"activity/userredenvelopeinfo"
#define kUrl_GetBeginGrabRedPacketGameInfo  @"activity/startgrabredenvelope"
#define kUrl_GetGrabRedPacket  @"activity/grabredenvelope"
#define kUrl_UserFeedback   @"user/saveBuyerFeedback"
#define kUrl_ShareFriends   @"share/sharetoweixinfriends"
#define kUrl_ShareToMoments @"share/sharetomoments"
#define kUrl_ShareTosms     @"share/sharetosms"



#pragma mark ------------------ Community -------------------
#define kUrl_CommunitySearch      @"user/communitysearch"
#define kUrl_LocateNearbyRegion   @"user/locationlist"
#define kUrl_GetCommunityDetailInfo @"user/communityinfo"
#define kUrl_GetUserticktInfo @"activity/userticketinfo"

#pragma mark ------------------ adress -------------------
#define kUrl_GetAdressList      @"useraddress/addresslist"
#define kUrl_SetDefaultAdress    @"shippingAddress/setDefault"
#define kUrl_DeleteAdress           @"useraddress/invaliduseraddress"
#define kUrl_GetAdressDetail        @"useraddress/addressdetail"
#define kUrl_GetDefaultAdress       @"shippingAddress/getDefault"
#define kUrl_EditAddAdress             @"useraddress/addupdateuseraddress"
#define kUrl_NearByAdress           @"place/around"
#define kUrl_KeyWordsSearchAdress   @"place/text"
#define kUrl_CanbeShippedCityList @"shippingAddress/citys"

#pragma mark -------------------shopCart-------------------
#define kUrl_SychronizeShopCart   @"cart/synchronouscart"
#define kUrl_ConfirmShopCartData  @"cart/confirmcart"
#define kUrl_AdjustShopCartNumber @"cart/adjustmentcartcount"
#define kUrl_ClearShopCartInfo    @"cart/clearcart"

#define kUrl_AddShopCart                 @"shoppingCart/add"
#define kUrl_ShopCartList                @"shoppingCart/list"
#define kUrl_CalculateShopCartTotalPrice @"shoppingCart/calculatePrice"
#define kUrl_ChangeShopCartGoodsNumber   @"shoppingCart/editNumber"
#define kUrl_DeleteShopCartGoods         @"shoppingCart/delete"
#define kUrl_GetShopCartTotalNumber      @"shoppingCart/getTotalNumber"
#pragma mark --------------------shop----------------------
#define kUrl_GetNeartyDefaultShop       @"user/location"
#define kUrl_GoodsFirstLevelCategary    @"goodsSort/category"
#define kUrl_GoodsSecondLevelCategary   @"goodsSort/subCategory"
#define kUrl_GetCurrentGoodsList        @"goods/currentShopList"
#pragma mark --------------------order---------------------
#define kUrl_GetMakeSureOrderData       @"userOrder/goConfirm"
#define kUrl_SubmmitOrder               @"cart/settlementorder"
#define kUrl_CreateOrder                @"cart/createorder"
#define kUrl_OrderGoodsList             @"userOrder/cofirmGoodsList"
#define kUlr_CanbeshippedTimeList       @"receiveGoodsTime/list"
#define kUrl_OrderDetail                @"order/orderdetail"
#define kUrl_OrderList                  @"order/orderlist"
#define kUrl_OrderCancel                @"order/cancel"
#define kUrl_orderConfirm               @"order/confirm"
#define kUrl_GetSelfTakeOrderPayResultPageInfo  @"order/paysuccessinfo"
#define kUrl_GetTicketTotalAmount       @"cart/settlementordertickets"
#pragma mark --------------------pay---------------------
#define kUrl_AliPayNeedInfo             @"pay/alipayapporderparam"
#define kUrl_WxPayNeedInfo              @"pay/wxpayapporderparam"

#endif /* DLRequestUrl_h */
