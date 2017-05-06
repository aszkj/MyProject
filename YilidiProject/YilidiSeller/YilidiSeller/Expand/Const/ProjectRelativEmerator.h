//
//  ProjectRelativEmerator.h
//  YilidiSeller
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#ifndef ProjectRelativEmerator_h
#define ProjectRelativEmerator_h
#pragma mark - 工程中用的枚举

typedef NS_ENUM(NSInteger,TextEditorStatus) {
    TextEditorDefaultStatus    = 0,
    TextEditorPhoneFieldTag,
    TextEditorCodeFieldTag,
    TextEditorPassWordFieldTag,
};

typedef NS_ENUM(NSInteger,ButtonStatus) {
    ButtonDefaultStatus    = 0,
    ButtonAvailableStatus,
    ButtonAvailableNotStatus,
};

typedef enum : NSUInteger {
    GoodsSearchModal,
    GoodsShowPreviewHorizonalModal,
    GoodsShowPreviewVerticalModal,
} GoodsSearchShowModal;

typedef NS_ENUM(NSInteger,SelectShipWay) {
    ShipWay_DeliveryGoodsHome,//送货上门
    ShipWay_SelfTake,//自提
};

typedef NS_ENUM(NSInteger,SearchType) {
    SearchType_Goods,
    SearchType_Order,
};


#endif /* ProjectRelativEmerator_h */
