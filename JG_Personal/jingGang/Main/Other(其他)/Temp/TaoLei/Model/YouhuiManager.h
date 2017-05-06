//
//  YouhuiManager.h
//  jingGang
//
//  Created by thinker on 15/8/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouhuiManager : NSObject

@property (nonatomic) long youhuiId;
@property (nonatomic) long needPrice;
@property (nonatomic) long minusPrice;
@property (nonatomic) NSString *youhuiDescription;

- (id)initWithCoupon:(NSDictionary *)couponInfo;

@end
