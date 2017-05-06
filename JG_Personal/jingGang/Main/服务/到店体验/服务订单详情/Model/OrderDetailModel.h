//
//  OrderDetailModel.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

@end


@interface JGOrderDetailModel : NSObject

@property (copy , nonatomic) NSString *groudId;
@property (copy , nonatomic) NSString *status;
@property (copy , nonatomic) NSString *groupName;
@property (copy , nonatomic) NSString *groupAccPath;
@property (copy , nonatomic) NSString *groupSn;
@property (copy , nonatomic) NSString *totalPrice;

- (instancetype)initWithDict:(NSDictionary *)dic;

@end