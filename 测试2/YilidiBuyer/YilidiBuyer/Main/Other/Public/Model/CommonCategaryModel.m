//
//  CommonCategaryModel.m
//  JCTagViewTest
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommonCategaryModel.h"

@implementation CommonCategaryModel

@end
@implementation CommonCategaryModel (setGoodsCategary)

+ (CommonCategaryModel *)initWithGoodsCategaryDic:(NSDictionary *)goodsCategaryDic
{
    CommonCategaryModel *model = [[CommonCategaryModel alloc] init];
    model.categaryName = goodsCategaryDic[@"className"];
    model.categaryId = goodsCategaryDic[@"classCode"];
    return model;
}

@end