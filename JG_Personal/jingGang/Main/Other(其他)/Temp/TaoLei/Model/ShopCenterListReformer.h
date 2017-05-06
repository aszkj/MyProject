//
//  PropertyListReformer.h
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyListReformerKeys.h"
#import "APIManager.h"

@interface ShopCenterListReformer : NSObject <AddressReformerProtocol>



+ (NSString *)getTransContextFromData:(NSDictionary *)originData;
- (NSDictionary *)getReturnDicfromData:(NSDictionary *)originData;


- (NSDictionary *)getOrderDatafromData:(NSDictionary *)originData fromManager:(APIManager *)manager;

- (NSDictionary *)getAddressfromData:(NSDictionary *)originData;
- (NSArray *)getTransList:(NSArray *)orderListArray;
- (NSArray *)getCouponInfoList:(NSArray *)orderListArray;
- (NSArray *)getGoodsCartListList:(NSArray *)orderListArray;
- (NSArray *)getshopStores:(NSArray *)orderListArray;

@end
