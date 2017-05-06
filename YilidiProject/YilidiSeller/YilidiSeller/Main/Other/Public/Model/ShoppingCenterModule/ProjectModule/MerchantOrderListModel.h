//
//  OrderListModel.h
//  YilidiSeller
//
//  Created by yld on 16/5/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "MerchantOrderListBaseModel.h"

@interface MerchantOrderListModel : MerchantOrderListBaseModel

/**
 *  预计送达时间
 */
@property (nonatomic,copy)NSString *expectedDeliveryTime;

@property (nonatomic,copy)NSString *buyerMobile;
@end

@interface MerchantOrderListModel (objectArr)

+ (NSArray *)objectArrWithOrderArr:(NSArray *)orderArr;

@end