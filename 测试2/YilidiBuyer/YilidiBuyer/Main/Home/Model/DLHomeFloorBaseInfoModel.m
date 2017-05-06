//
//  DLHomeFloorBaseInfoModel.m
//  YilidiBuyer
//
//  Created by yld on 16/9/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeFloorBaseInfoModel.h"
#import "NSDictionary+SUISafeAccess.h"
#import "NSArray+subArrToIndex.h"
#import "GoodsModel.h"


@implementation DLHomeFloorBaseInfoModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.floorId = dic[@"floorId"];
        self.floorName = dic[@"floorName"];
        self.floorLinkTypeNumber = dic[@"linkType"];
        self.floorLinkData = dic[@"linkData"];
        if (self.floorName && self.floorLinkData) {
          self.floorLinkData = [self.floorLinkData stringByAppendingString:[NSString stringWithFormat:@"&floorName=%@",self.floorName]];
        }
        self.floorIconImageUrl = dic[@"floorImageUrl"];
        NSArray *floorGoodsList = [dic sui_arrayForKey:@"floorProductList"];
        floorGoodsList = [floorGoodsList subArrayToIndex:4];
        self.floorProductList = [GoodsModel objectGoodsModelWithGoodsArr:floorGoodsList];
    }
    return self;
}


@end
