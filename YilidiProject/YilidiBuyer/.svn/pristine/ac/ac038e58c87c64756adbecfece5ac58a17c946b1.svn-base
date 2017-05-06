//
//  GlobleConst.h
//  YilidiBuyer
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#ifndef GlobleConst_h
#define GlobleConst_h
#import "ShopCartGoodsManager.h"
#import "CommunityDataManager.h"
#import "UserDataManager.h"

#pragma mark - 全局常量

#define kTopBarHeight 40
#define kNormalGap 10
#define kSmallGap  5
#define kBiggerGap 15

#define kUIExternReponsedEdge 8
#define YLDBIGVALUE     9999999
#define YLDSMALLVALUE   0.11111



#define OBJECTFORKEY(dict,key)              [dict objectForKey:key]
#define KRequestTypeOne                     @"one"
#define KRequestTypeTwo                     @"two"
#define KRequestTypeThree                   @"Three"
#define KRequestTypeFour                    @"Four"
#define KRequestTypeFive                    @"Five"
#define KRequestTypeSix                     @"Six"

#define KTypeCodeLogin                      @0
#define KTypeLoginPassword                  @1
#define KTypeLogin                          @2
#define KTypeForgotPassword                 @3
#define KTypeChangPassword                  @4
#define KTypeBingdingPhone                  @5
#define KTypemodifyPhone                    @6

#define kDefaultlatitude 22.539509
#define kDefaultlongtitude  114.03692

#define kDefaultSeaLatitude 114.03692
#define kDefaultSeaLongtitude 114.03692

#define kHomeGoodsClassTypeHotSaleNumber @"3"
#define kHomeGoodsClassTypeDiscoutNumber @"2"
#define kHomeGoodsClassTypeNewGoodsNumber @"1"
#define kDefaultShopId 7

#define kGoodsTypeNumberDefaultShop 1000
#define kGoodsTypeNumberNewProduct 1
#define kGoodsTypeNumberSpecialPrice 2
#define kGoodsTypeNumberCommunityHoteSale  3
#define kGoodsTypeNumberCommnuntiyWellSelect 4

#define kPerfectVipGoodsNumber 5

#define kGoodsSortNumberFromLowtoHighByPrice -1
#define kGoodsSortNumberFromHightoLowByPrice 1
#define kGoodsSortNumberFromLowtoHighBySalesVolume -2
#define kGoodsSortNumberFromHightoLowBySalesVolume 2

#define kGoodsTypeTitleNewProduct  @"新品"
#define kGoodsTypeTitleSpecialPrice  @"特价"
#define kGoodsTypeTitleCommunityHoteSale  @"社区热卖"
#define kGoodsTypeTitleCommunityWellSelected  @"社区优选"

#define kHomeDisplayGoodsMaxCount 4

#define kGoodsSortNumberByPrice 1
#define kGoodsSortNumberBySaleVolume 2

#define kGoodsSortTypeNumberFromLowToHigh 1
#define kGoodsSortTypeNumberFromHighToLow 2

#define APP_ID @"wxadf10b780467d1f7"
#define APP_SECRET @"84f6e5434034547a3e9b971e5209d43b"

/**
 *  各种提示
 */
#define kAlertStoreIsClosed @"该店铺已暂停营业\n无法购买商品了"
#define kAlertTitleSwitchSelfTakeStore  ([ShopCartGoodsManager sharedManager].shopCartGoodsNumber > 0  ? @"当前的选择为自提方式，需要到店自提，店铺切换以后购物车数据会被清空，您是否需要切换店铺？":@"当前的选择为自提方式，需要到店自提，您是否需要切换店铺？")
#define kAlertTitleSwitchCommunityNotInShipRange  ([ShopCartGoodsManager sharedManager].shopCartGoodsNumber > 0  ? @"此区域不在当前店铺配送范围，店铺切换以后购物车数据会被清空，您是否需要切换店铺？":@"此区域不在当前店铺配送范围，您是否需要切换店铺？")
#define kAlertTitleSwitchCommunityNoStoreAndNotInShipRange  ([ShopCartGoodsManager sharedManager].shopCartGoodsNumber > 0  ? @"此区域暂无门店，我们正在加紧开通该区域的店铺，店铺切换以后购物车数据会被清空，您是否还需要切换店铺？":@"此区域暂无门店，我们正在加紧开通该区域的店铺，您是否需要切换店铺？")

#define kAlertDeliveryGoodsHomeStoreIsAfterBussinessTime [NSString stringWithFormat:@"现在下单预计明日%@后配送\n我们会通知老板准时送达", [kCurrentStore storeBeginShipTime]]
#define kAlertSelfTakeStoreIsAfterBussinessTime @"请在明天营业时间内到店铺自提\n否则订单将自动取消"
#define kAlertDeliveryGoodsHomeStoreIsFrontOfBussinessTime [NSString stringWithFormat:@"现在下单预计今日%@后配送\n我们会通知老板准时送达", [kCurrentStore storeBeginShipTime]]
#define kAlertSelfTakeStoreIsFrontOfBussinessTime @"请在今日营业时间内到店铺自提\n否则订单将自动取消"
#define kAlertDifferentGoodsToShopCart @"vip商品需要单独购买，为此购物车会清空，是否继续购买？"
#define kAlertUserLocationHasChanged   @"系统检测到您的当前位置发生了变化，是否切换到当前对应的店铺？"
#define kAlertBuyyingPennyGoods        @"亲，你已经购买过过该一分钱商品了"
#define kAlertGoodsNowCountBiggerThanlimitCount        @"购买数量大于秒杀限购数量"
#define kAlertGoodsStockNotEnough      @"该商品库存不足"
#define kAlertStoreClosed  @"当前店铺已暂停营业"



#define kAlertStoreNotOnBusinessTime  kCurrentShipWay == ShipWay_DeliveryGoodsHome ? kAlertDeliveryGoodsHomeStoreIsAfterBussinessTime : kAlertSelfTakeStoreIsAfterBussinessTime
#define kAlertStoreFrontOfTheBusinessTime  kCurrentShipWay == ShipWay_DeliveryGoodsHome ? kAlertDeliveryGoodsHomeStoreIsFrontOfBussinessTime : kAlertSelfTakeStoreIsFrontOfBussinessTime


#define FunctionTemporarilyNotOpenAlert @"尚未开启！敬请期待！"

#define kBuyerAppstoreLinkAdress  @"https://itunes.apple.com/cn/app/yi-li-di/id1136196562?mt=8"

/**
 *  网络请求code
 */
//服务器报错
#define RequestFailedServiceErrorCode -1
//请求失败
#define RequestFailedCode 0
//请求成功
#define RequestSuccessCode 1
//未登录或登录超时
#define RequestFailedUnloginCode 2
//强制升级
#define RequestNeedForceUpdate 3

/**
 *  请求分页参数
 */
#define kRequestPageNumKey  @"pageNum"
#define kRequestPageSizeKey @"pageSize"
#define kRequestDefaultPageSize 12
#define kRequestDefaultPageNum  1
#define kTotalPages         @"totalPages"


#define KLongtitudeKey @"longitude"
#define KLatitudeKey @"latitude"


/**
 *  首页几个部分的索引
 */
#define MainPageIndex 0
#define GoodsClassPageIndex 1
#define ShopCartPageIndex 2
//#define MyOrderPageIndex 3
#define MePageIndex 3
#define MainTabbarItemCount 4

#define MainShopCartIconPoint CGPointMake((kScreenWidth/MainTabbarItemCount)*(ShopCartPageIndex+1)-(kScreenWidth/MainTabbarItemCount)/2, kScreenHeight-20)
#define ListPageShopCartIconPoint CGPointMake(kScreenWidth-34-50/2, kScreenHeight-58 - 50/2)

#define kPerfectureGoodsTypeVIPNumber  1
#define kPerfectureGoodsTypePennyGoodsNumber  2
#define kPerfectureGoodsTypePerWeekRecommondGoodsNumber  3

#define kDeliveryNumberShipHome 1
#define kDeliveryNumberSelfTake 2


/**
 *  各种链接跳
 */
//无链接
#define kLinkDataNoLink 0
//跳商品分类
#define kLinkDataToGoodsClass 1
//跳专区页面，一分钱，VIP等
#define kLinkDataToH5Page 2
//跳分类专区页面(废弃)
#define kLinkDataToClassSpecialRegion 3
//跳专题页
#define kLinkDataToSubjectPage 4
//跳活动页
#define kLinkDataToActivityPage 5
//跳商品详情
#define kLinkDataToGoodsDetailPage 6
//网站资讯、公告
#define kLinkDataToInformationPage 7
//跳楼层商品页
#define kLinkDataToFloorGoodsPage 3


/**
 *  H5页面typeCode值
 */
//关于我们
#define H5PAGETYPE_ABOUT_US @"H5PAGETYPE_ABOUT_US"
//常见问题
#define H5PAGETYPE_COMMON_QUESTION @"H5PAGETYPE_COMMON_QUESTION"
//合伙人加盟
#define H5PAGETYPE_PARTNER_JOIN @"H5PAGETYPE_PARTNER_JOIN"
//新人专享
#define H5PAGETYPE_FRESHMAN_EXCLUSIVE @"H5PAGETYPE_FRESHMAN_EXCLUSIVE"
//注册有礼
#define H5PAGETYPE_REGISTER_GIFT @"H5PAGETYPE_REGISTER_GIFT"
//牛奶促销
#define H5PAGETYPE_MILK_PROMOTION  @"H5PAGETYPE_MILK_PROMOTION"
//升级VIP
#define H5PAGETYPE_UPGRADE_VIP @"H5PAGETYPE_UPGRADE_VIP_NEW"
//分享有礼
#define H5PAGETYPE_SHARE_PAGE  @"H5PAGETYPE_SHARE_PAGE"



#define kLinkDataToGoodsClassCodeKey @"classCode"
#define kLinkDataToSpecialRegionCodeKey @"h5PageType"
#define kClassSpecialRegionCodeKey @"zoneCode"

#define CLIENTID                   @"clientId"
#define PUSHNOTIFYMSGTYPE           @"PUSHNOTIFYMSGTYPE_ORDERACCEPT"

#define BUYERTOKEN  @"BUYERTOKEN"

#define YiLiDiSessionID @"YiLiDiSessionID"
#define UNLOGIN_YiLiDiSessionID @"UNLOGIN_YiLiDiSessionID"
#define KSetCookieKey   @"KSetCookieKey"
#define KUserInfoKey    @"KUserInfoKey"

#define IsInstallationWechat @"notWechat"

#define UserIsLogin [[UserDataManager sharedManager] userIsLogin]
#define GetUserInfo (DLUserInfoModel *)[[UserDataManager sharedManager] userInfo]
#define kCommunityId [CommunityDataManager sharedManager].communityModel.communityId
#define kCommunityStoreId [CommunityDataManager sharedManager].currentStore.storeId
#define kCurrentStore [CommunityDataManager sharedManager].currentStore
#define kCurrentCummunity [CommunityDataManager sharedManager].communityModel
#define kCurrentShipWay [CommunityDataManager sharedManager].selectedShipWay
#define kCurrentCummunityStoreBusinessStatus [CommunityDataManager sharedManager].currentStore.storeStatus.integerValue
#define kCurrentStoreOnbusinessTimeNumber   [kCurrentStore storeOnTheBussinessTime]

#define kDefaultCommunityId @"4"
#define SESSIONID [kUserDefaults objectForKey:YiLiDiSessionID]
#define UNLOGIN_SESSIONID [kUserDefaults objectForKey:UNLOGIN_YiLiDiSessionID]

 
/**
 *  首页轮播图类型
 */
#define ADVERTISEMENTTYPE_HOMEBANNER @"ADVERTISEMENTTYPE_HOMEBANNER"

/**
 *  首页秒杀广告
 */
#define ADVERTISEMENTTYPE_SECKILL    @"ADVERTISEMENTTYPE_SECKILL"

/**
 *  首页专题多位置广告
 */
#define ADVERTISEMENTTYPE_SEMINAR    @"ADVERTISEMENTTYPE_SEMINAR"
//首页节假日广告
#define ADVERTISEMENTTYPE_FESTIVALACT @"ADVERTISEMENTTYPE_FESTIVALACT"

//登录广告
#define ADVERTISEMENTTYPE_LOGIN       @"ADVERTISEMENTTYPE_LOGIN"

/*
 活动类型
 */
#define kActivityType @"activityType"
//秒杀活动
#define ACTIVITYTYPE_SECKILL  @"ACTIVITYTYPE_SECKILL"
//抢红包活动
#define ACTIVITYTYPE_REDENVELOPE @"ACTIVITYTYPE_REDENVELOPE"

/**
 *  商品类型Code
 */
#define TOP_CLASS_CODE  @"TOP_LEVEL_CLASS"

#endif /* GlobleConst_h */
