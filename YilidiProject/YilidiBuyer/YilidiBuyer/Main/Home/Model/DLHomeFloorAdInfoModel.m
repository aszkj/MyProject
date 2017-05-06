//
//  DLHomeFloorAdInfoModel.m
//  YilidiBuyer
//
//  Created by yld on 16/9/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeFloorAdInfoModel.h"

@implementation DLHomeFloorAdInfoModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.floorAdtitle = dic[@"titleName"];
        self.floorAdLinkTypeNumber = dic[@"linkType"];
        self.floorAdLinkData = dic[@"linkData"];
        self.floorAdImageUrl = dic[@"imageUrl"];
    }
    return self;
}


@end
