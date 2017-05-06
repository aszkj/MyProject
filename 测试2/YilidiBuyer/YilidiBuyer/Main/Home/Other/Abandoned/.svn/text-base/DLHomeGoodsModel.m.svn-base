//
//  DLHomeGoodsModel.m
//  YilidiBuyer
//
//  Created by yld on 16/4/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeGoodsModel.h"

@implementation DLHomeGoodsModel
- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.goodsId = dic[@"goodsId"];
        self.goodsName = dic[@"goodsName"];
        self.goodsPrice = dic[@"vipPrice"];
        self.imgUrl = dic[@"thumbnail"];
        self.goodsDescribe = dic[@"desc"];
        self.oldPrice = dic[@"ordinaryPrice"];
        self.desc = dic[@"desc"];
        self.stand = dic[@"standard"];
        self.goodsNumber = dic[@"goodsNumber"];
        self.salesVolume = [dic[@"salesVolume"] longLongValue];
        [self checkSelfPropertyValueNumllSituation];
        
    }
    return self;
}
- (void)_avoidErrorHander {
    
}
@end



@implementation DLHomeGoodsModel (objectGoodsModel)

+ (NSArray *)objectGoodsModelWithGoodsArr:(NSArray *)goodsArr
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsArr.count];
    for (NSDictionary *dic in goodsArr) {
        DLHomeGoodsModel *model = [[DLHomeGoodsModel alloc] initWithDefaultDataDic:dic];
        [tempArr addObject:model];
    }
    
    return [tempArr copy];
}

@end

