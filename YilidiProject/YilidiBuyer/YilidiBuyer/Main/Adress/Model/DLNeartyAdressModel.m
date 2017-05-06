//
//  DLNeartyAdressModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLNeartyAdressModel.h"

@implementation DLNeartyAdressModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self =  [super initWithDefaultDataDic:dic];
    if (self) {
        self.mainAdress = dic[@"name"];
        self.detailAdress = dic[@"address"];
        self.regionPath = dic[@"regionPath"];
        self.distance = dic[@"distance"];
    }
    return self;
}


@end
