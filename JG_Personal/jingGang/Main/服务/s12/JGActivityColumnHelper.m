//
//  JGActivityColumnHelper.m
//  jingGang
//
//  Created by dengxf on 15/12/10.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityColumnHelper.h"

static JGActivityColumnHelper *helper = nil;

@implementation JGActivityColumnHelper

+ (instancetype)sharedInstanced {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (helper == nil) {
            helper = [[JGActivityColumnHelper alloc] init];
        }
    });
    return helper;
}

- (void)gtActivityResponseDic:(NSDictionary *)resDic isShow:(void (^)(JGActivityHotSaleApiBO *))showBlock {
    if (resDic != nil) {
        
        JGActivityHotSaleApiBO *apiBO = [[JGActivityHotSaleApiBO alloc] initWithResponseDic:resDic];
        
        if (showBlock) {
            
            self.apiBO = apiBO;
            
            showBlock(apiBO);
        }
    }
}



@end
