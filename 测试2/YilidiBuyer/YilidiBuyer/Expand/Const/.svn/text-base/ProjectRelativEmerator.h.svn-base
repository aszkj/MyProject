//
//  ProjectRelativEmerator.h
//  YilidiBuyer
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#ifndef ProjectRelativEmerator_h
#define ProjectRelativEmerator_h
#pragma mark - 工程中用的枚举

typedef enum : NSUInteger {
    GoodsSearchModal,
    GoodsShowPreviewHorizonalModal,
    GoodsShowPreviewVerticalModal,
} GoodsSearchShowModal;

typedef enum : NSUInteger {
    SelectGoodsAllCategaryType,
    SelecteGoodsTotalSortType,
} SiftGoodsRuleType;

typedef enum : NSUInteger {
    AddAdressType,
    EditAdressType
} OperatorAddressType;

typedef enum : NSUInteger {
    AdressListType,
    ManageAdresslistType,
} AdresslistType;


typedef NS_ENUM(NSInteger,SearchType) {
    SearchType_Goods,
    SearchType_Area,
};

typedef NS_ENUM(NSInteger,TextEditorStatus) {
    TextEditorDefaultStatus    = 0,
    TextEditorPhoneFieldTag,
    TextEditorCodeFieldTag,
    TextEditorPassWordFieldTag,
};

typedef NS_ENUM(NSInteger,ComeToNearBySearchPageType) {
    ComeToNearBySearchPage_FromSwicthCommunity,
    ComeToNearBySearchPage_FromEditAddAdress,
};

typedef NS_ENUM(NSInteger,ComeToLocationNearyByRegionPageType) {
    LocationNearyByRegionPage_FromSwicthCommunity,
    LocationNearyByRegionPage_FromEditAddAdress,
};

typedef NS_ENUM(NSInteger,RequestRedPacketGameInfoResultErrorType) {
    CannotGrapRedPacket,//不能抢红包
    NoRedPacketGame,//没有红包游戏了
    CanGrapRedPacket//能抢红包
};

typedef NS_ENUM(NSInteger,SelectTicketType){
    CouponTicket,//优惠券
    PledgeTicket,//抵用券
    UnknownTicket,//未知，占位的
};


typedef NS_ENUM(NSInteger,ComeToAdresModuleType) {
    ComeToAdresModule_FromShopCart,
    ComeToAdresModule_FromManageAdress,
};

typedef NS_ENUM(NSInteger,PayType) {
    PayType_Alipay,
    PayType_WxPay,
};

typedef NS_ENUM(NSInteger,SeckillActivityStatus) {
    SeckillActivityStatus_hasBegan,//已开始
    SeckillActivityStatus_crazySaling,//疯抢中
    SeckillActivityStatus_soonBegin//即将开始
};

typedef NS_ENUM(NSInteger,ShopCartGoodsStatus) {
    ShopCartGoodsStatus_canBuy,//能买
    ShopCartGoodsStatus_isOffShelf,//已下架
    ShopCartGoodsStatus_hasGot,//已领取，一分钱
    ShopCartGoodsStatus_NoStock,//没库存
    ShopCartGoodsStatus_hasGrabedOver,//抢光了
};


typedef NS_ENUM(NSInteger,SelectShipWay) {
    ShipWay_DeliveryGoodsHome,//送货上门
    ShipWay_SelfTake,//自提
};

typedef NS_ENUM(NSInteger,LinkType) {
    LinkType_To_GoodsClass,//跳商品分类
    LinkType_To_SpecialRegion,//跳专区
    LinkType_To_NoPage,//无链接
};

typedef NS_ENUM(NSInteger,GoodsType) {
    GoodsType_NormalGoods,          //普通商品，
    GoodsType_NormalPennyGoods,     //普通一分钱商品
    GoodsType_VipGoods,             //vip商品
    GoodsType_Unknown,              //未知类型商品，

};

typedef NS_ENUM(NSInteger, ComeToLoginPageType) {//进入登录页的类型
    UnloginedComin_FromPerHomePageNotShopCartAndFirstHomePage,//未登录情况下，从每个首页进入，只限订单、个人中心
    UnloginedComin_FromNormalPageToShopCartToLoginPage,//未登录，一般页面点击购物车进入登录页
    UnloginedComin_FromNotPerHomePage,//未登录情况下，不是每个首页进入，比如商品详情
    UnloginedComin_FromLogout,//未登录情况下,退出登录，进入登录页
    LoginedComin_FromSessionInvalidate,//已经登录情况下,网络请求Session失效，进入登录页
};

#endif /* ProjectRelativEmerator_h */
