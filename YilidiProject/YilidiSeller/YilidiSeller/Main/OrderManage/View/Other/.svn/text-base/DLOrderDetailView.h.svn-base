//
//  DLOrderDetailView.h
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantOrderDetailModel.h"
typedef void(^OrderDetaiLocationBlock)(CGFloat customerLatitude,CGFloat customerLongtitude,NSString*name,NSString*address);
typedef void(^EnsureTakeTheOrderBlock)(void);
typedef void(^CancelTakeOrderBlock)(void);
typedef void(^EnsureDeliverGoodsBlock)(void);

typedef void(^EnsureCustomerRecieveGoodsBlock)(void);

@interface DLOrderDetailView : UIView

@property (nonatomic,strong)OrderDetaiLocationBlock locationBlock;

@property (nonatomic,strong)EnsureTakeTheOrderBlock ensureTakeTheOrderBlock;

@property (nonatomic,strong)CancelTakeOrderBlock cancelTakeOrderBlock;

@property (nonatomic,strong)EnsureDeliverGoodsBlock ensureDeliverGoodsBlock;

@property (nonatomic,strong)EnsureCustomerRecieveGoodsBlock ensureCustomerRecieveGoodsBlock;

@property (nonatomic,strong)MerchantOrderDetailModel *detailModel;

@property (nonatomic,assign)BOOL comeForTheShipCode;



@end
