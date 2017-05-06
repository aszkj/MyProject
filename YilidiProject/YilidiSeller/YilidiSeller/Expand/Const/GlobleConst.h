//
//  GlobleConst.h
//  YilidiSeller
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#ifndef GlobleConst_h
#define GlobleConst_h
#pragma mark - 全局常量

#define kTopBarHeight 40
#define kNormalGap 10
#define kSmallGap  5
#define kBiggerGap 15

#define kDefaultlatitude 22.5229
#define kDefaultlongtitude  113.9274      

#define KTypeCodeLogin                      @0
#define KTypeLoginPassword                  @1
#define KTypeLogin                          @2
#define KTypeForgotPassword                 @2
#define KTypeChangPassword                  @4


#define TOP_LEVEL_CLASS @"TOP_LEVEL_CLASS"

#define KSelectedBgColor UIColorFromRGB(0x298ccf)

#define kDefaulDarkGrayColor UIColorFromRGB(0x333333)
#define kDefaulLightGrayColor UIColorFromRGB(0x8b8b8b)


#define kGoodsSortNumberByStock 1
#define kGoodsSortNumberBySaleVolume 2

#define kGoodsSortTypeNumberFromLowToHigh 1
#define kGoodsSortTypeNumberFromHighToLow 2


#define kShelfNumberAll 0
#define kShelfNumberOnShelf 1
#define kShelfNumberOffShelf 2

#define kOrderTypeNumberNomal 1
#define kOrderTypeNumberOther 2


#define kHomeGoodsClassTypeHotSaleNumber @"3"
#define kHomeGoodsClassTypeDiscoutNumber @"2"
#define kHomeGoodsClassTypeNewGoodsNumber @"1"
#define kDefaultShopId 7

#define kGoodsTypeNumberDefaultShop 1000
#define kGoodsTypeNumberNewProduct 1
#define kGoodsTypeNumberSpecialPrice 2
#define kGoodsTypeNumberCommunityHoteSale  3
#define kGoodsTypeNumberCommnuntiyWellSelect 4

#define kGoodsSortNumberFromLowtoHighByPrice -1
#define kGoodsSortNumberFromHightoLowByPrice 1
#define kGoodsSortNumberFromLowtoHighBySalesVolume -2
#define kGoodsSortNumberFromHightoLowBySalesVolume 2

#define kGoodsTypeTitleNewProduct  @"新品"
#define kGoodsTypeTitleSpecialPrice  @"特价"
#define kGoodsTypeTitleCommunityHoteSale  @"社区热卖"
#define kGoodsTypeTitleCommunityWellSelected  @"社区优选"


#define SELLERTOKEN                @"sellerToken"
#define CLIENTID                   @"clientId"
#define PUSHNOTIFYMSGTYPE           @"PUSHNOTIFYMSGTYPE_ORDERACCEPT"

#define HomeResponeData         @"homeData"
#define YiLiDiMerchantSessionID @"YiLiDiSessionID"
#define UNLOGIN_YiLiDiSessionID @"UNLOGIN_YiLiDiSessionID"
#define SESSIONID [kUserDefaults objectForKey:YiLiDiMerchantSessionID]
#define UNLOGIN_SESSIONID [kUserDefaults objectForKey:UNLOGIN_YiLiDiSessionID]

#define KShareStockKey @"KShareStockKey"
#define IsShareStock [[kUserDefaults objectForKey:KShareStockKey] boolValue]

/**
 *  请求分页参数
 */
#define kRequestPageNumKey  @"pageNum"
#define kRequestPageSizeKey @"pageSize"
#define kTotalPages         @"totalPages"
#define kRequestDefaultPageSize 12
#define kRequestDefaultPageNum  1

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

//关于我们
#define H5PAGETYPE_ABOUT_US @"1"
//常见问题
#define H5PAGETYPE_COMMON_QUESTION @"2"


#define YiLiDiSessionID @"YiLiDiSessionID"


#define SubmitStatus 1
#define AuditStatus  2
#define AuditNotThroughStatus 3
#define DeliveryStatus 4
#define InspectionStatus 5
#define InspectionCompleteStatus 6
#define GoodsFinishStatus 7
#define ControversyStatus 8
#define CustomerServiceStatus 9



#endif /* GlobleConst_h */
