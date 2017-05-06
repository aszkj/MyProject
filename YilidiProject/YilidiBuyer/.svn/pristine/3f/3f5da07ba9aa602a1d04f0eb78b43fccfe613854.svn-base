//
//  WXPayRequestModel.m
//  jingGang
//
//  Created by 张康健 on 15/8/18.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WXPayRequestModel.h"

@implementation WXPayRequestModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.appid = dic[@"appId"];
        self.noncestr = dic[@"nonceStr"];
        self.package1 = dic[@"packageValue"];
        self.partnerid = dic[@"partnerId"];
        self.prepayid = dic[@"prepayId"];
        self.timestamp = dic[@"timeStamp"];
        self.sign = dic[@"sign"];
    }
    return self;
}

@end
