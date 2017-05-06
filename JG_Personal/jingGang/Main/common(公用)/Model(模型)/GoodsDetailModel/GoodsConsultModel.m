    //
//  GoodsConsultModel.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsConsultModel.h"
#import "GlobeObject.h"

@implementation GoodsConsultModel


-(id)initWithJSONDic:(NSDictionary *)json{

    self = [super initWithJSONDic:json];
    if (self) {
        
        //咨询内容高度
        CGSize consultHeightSize = kStringSize(_consultContent, 15, kScreenWidth-51, 1000);
        //回复内容高度
        CGSize repyHeightSize = kStringSize(_consultReply, 15, kScreenWidth-51, 1000);
        _cellHeight = consultHeightSize.height + repyHeightSize.height + 89;
        
    }
    return self;
}



@end
