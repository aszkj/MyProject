//
//  DLNearChannelModel.m
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLNearChannelModel.h"

@implementation DLNearChannelModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.selltype = dic[@"selltype"];
        self.selltypeName = dic[@"selltypeName"] ;
        self.shopId = dic[@"shopId"];
        self.shopName = dic[@"shopName"];
        self.shopImgUrl = dic[@"shopImgUrl"];
        self.shopKey = dic[@"shopKey"];
    }
    return self;
}

@end
