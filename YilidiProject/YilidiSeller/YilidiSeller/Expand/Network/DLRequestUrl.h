//
//  DLRequestUrl.h
//  YilidiSeller
//
//  Created by yld on 16/3/23.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#ifndef DLRequestUrl_h
#define DLRequestUrl_h

//#define TestDomain @"192.168.0.201"

//测试服务器
#define BASEURL @"http://sellertest.yldbkd.com/interfaces/seller/"
#define TestDomain @"sellertest.yldbkd.com"
//连调主机
//#define BASEURL @"http://192.168.1.124:8090/interfaces/seller/"

//正式服务器
//#define BASEURL @"http://seller.yldbkd.com:8080/interfaces/seller/"
//#define TestDomain @"http://seller.yldbkd.com"

#pragma mark ------------------ login&register -------------
#define kUrl_Login @"user/login"
#define kUrl_Logout @"user/logout"
#define kUrl_VerificationCode @"system/sendcaptcha"
#define kUrl_VerfivationCheck @"system/checkcode"
#define kUrl_ForgotPassword @"user/resetpassword"
#define kUrl_Changepassword @"user/updatepassword"
#define kUrl_Logout         @"user/logout"


#pragma mark ------------------ storeManagement -------------
#define kUrl_Store @"store/detailinfo"
#define kUrl_EditorStore @"store/updateinfo"
#define kUrl_Feeback @"setting/feeback"
#define kUrl_StoreInfo @"store/settlesimpleinfo"
#define kUrl_Setting   @"setting/helpaddress"
#define kUrl_GetUserInfo   @"user/userinfo"

#pragma mark ------------------ Classification -------------------
#define kUrl_Brand          @"brand/searchbrand"
#define kUrl_BrandPaging     @"brand/searchproductbybrand"


#pragma mark ------------------ invoice -------------
#define kUrl_InvoiceList  @"allot/orderlist"
#define kUrl_InvoiceOrdertails @"allot/orderdetails"
#define kUrl_InvoiceSubmit @"allot/confirmcheckallot"
#define kUrl_InvoiceInspection @"allot/checkallot"

#pragma mark ------------------ statistical -------------
#define kUrl_VipStatistical @"statistic/vipuserdetail"
#define kUrl_RebatesStatistical @"statistic/settledetail"
#define kUrl_SummaryStatistical @"statistic/summerizeinfo"


#pragma mark ------------------ home -------------------
#define kUrl_HomeHeaderLoopPlayUrl  @"billboard/list"
#define kUrl_HomeGetClassGoods      @"goods/typePrefecture"
#define kUrl_GetGoodsListByType       @"goods/listByType"
#define kUrl_GoodsSearch              @"product/searchproducts"
#define kUrl_GoodsCoupon              @"agentShopCoupon/list"
#define kUrl_receiveCoupon              @"userCoupon/receive"
#define kUrl_GoodsDetail                @"goods/detail"
#define kUrl_HomeIndexstat              @"statistic/indexstat"
#define kUrl_InvitationRecord           @"user/inviteusers"
#define kUrl_InvitationStatistical      @"statistic/invitecount"
#define kUrl_SaveClientid               @"store/saveclientid"
#define kUrl_Summerizetotal             @"statistic/summerizetotal"

#define kUrl_Feedback                   @"setting/feeback"

#pragma mark ------------------ GoodsManage --------------------
#define kUrl_GetGoodsTypelist @"product/getproducttype"
#define kUrl_SetGoodsOnOffShelf @"product/enabledflag"
#define kUrl_GetBrandGoodsList  @"brand/searchproductbybrand"

#pragma mark -------------------DispatchGoodsManage-------------------
#define kUrl_SearchDispatchGoodsByGoodsClass @"product/searchproductsfortrans"
#define kUrl_ConfiureDispatchGoods  @"allot/confirmallot"
#define kUrl_CreateDispatchGoodsOrder @"allot/createallot"

#pragma mark --------------------shop----------------------
#pragma mark --------------------order---------------------
#define kUrl_OrderDetail                @"order/orderdetails"
#define kUrl_CancelOrder                @"order/cancel"
#define kUrl_OrderList                  @"order/orderlist"
#define kUrl_TakeOrder                  @"order/accept"
#define kUrl_DeliveryGoods              @"order/delivery"
#define kUrl_EnsureCustomerRecieGoods   @"order/finish"

#endif /* DLRequestUrl_h */