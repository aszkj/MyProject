//
//  StoreModel.h
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "StoreBaseModel.h"

@interface StoreModel : StoreBaseModel

@property (nonatomic,copy)NSString *storeBusinessDisplayTime;

/**
 *  店铺送货时间说明
 */
@property (nonatomic,copy)NSString *deliveryTimeNote;
/**
 *  店铺自提时间说明
 */
@property (nonatomic,copy)NSString *pickUpTimeNote;

/**
 *  店铺是否在营业时间
 *
 *  @return -1 在营业时间之前，0 在营业时间 1 超出了营业时间
 */
-(NSInteger)storeOnTheBussinessTime;

-(NSString *)storeBeginShipTime;

-(NSDictionary *)modelDic;

@end


