//
//  JGActivityColumnHelper.h
//  jingGang
//
//  Created by dengxf on 15/12/10.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGActivityHotSaleApiBO.h"
@interface JGActivityColumnHelper : NSObject

@property (strong,nonatomic) JGActivityHotSaleApiBO *apiBO;

+ (instancetype)sharedInstanced;

- (void)gtActivityResponseDic:(NSDictionary *)resDic isShow:(void(^)(JGActivityHotSaleApiBO *apiBO))showBlock;

@end
