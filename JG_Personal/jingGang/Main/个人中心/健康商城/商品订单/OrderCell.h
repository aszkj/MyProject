//
//  OrderCell.h
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsInfo.h"

typedef NS_ENUM(NSInteger, TLShopType) {
    TLShopTypeStatusUnknown = -1,
    TLShopTypeDefault       = 0,
    TLShopTypeOfficial      = 1,
};

typedef NS_ENUM(NSInteger, TLPurchaseStatus) {
    TLPurchaseStatusUnknown     = -1,
    TLPurchaseStatusWaitPay     = 0,
    TLPurchaseStatusWaitSend    = 1,
    TLPurchaseStatusWaitRecieve = 2,
    TLPurchaseStatusWaitComment = 3,
    TLPurchaseStatusPlusComment = 5,
    TLPurchaseStatusTimeOut     = 6,
    TLPurchaseStatusClosed      = 4,
};

typedef NS_ENUM(NSInteger, TLOperationType) {
    TLOperationTypeCancel         = -1, //取消订单
    TLOperationTypeDelete         = 0,  //删除订单
    TLOperationTypePay            = 1,  //支付
    TLOperationTypeCheckLogistics = 2,  //查看物流
    TLOperationTypeWriteComment   = 3,  //写评价
    TLOperationTypeRecieve        = 4, //签收
    TLOperationTypeReturn         = 5, //退货

};


typedef void(^ButtonPressBlock)(NSInteger operationType, NSIndexPath *indexPath);
typedef void(^TapGestureBlock)(NSIndexPath *indexPath);
@interface OrderCell : UITableViewCell

@property (nonatomic) TLShopType shopType;
@property (nonatomic) TLPurchaseStatus purchaseStatus;
@property (copy) ButtonPressBlock buttonPressBlock;
@property (copy) TapGestureBlock tapBlack;
@property (nonatomic, getter = isAssociatedAction) BOOL associatedAction;
@property (nonatomic) NSIndexPath *indexPath;

@property (nonatomic) NSArray *shopLogos;

- (void)configWithReformedOrder:(NSDictionary *)orderData;
- (void)setgoodsViews:(NSArray<__kindof GoodsInfo *> *)array;
- (void)setAddTime:(NSString *)addTime;


@end
