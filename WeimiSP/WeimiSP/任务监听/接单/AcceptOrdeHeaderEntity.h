//
//  AcceptOrdeHeaderEntity.h
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcceptOrdeHeaderEntity : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *acceptOrderNum;
@property (nonatomic, copy, readonly) NSString *income;
@property (nonatomic, copy, readonly) NSString *completeOrderNum;
@property (nonatomic, copy, readonly) NSString *completeOrderPercentage;

@end
