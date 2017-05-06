//
//  SelfTestPerDayJinhuaModel.h
//  jingGang
//
//  Created by 张康健 on 15/6/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SelfTestPerDayJinhuaModel : NSObject

//广告描述
@property (nonatomic,  copy) NSString *adText;
//广告标题
@property (nonatomic,  copy) NSString *adTitle;
//广告链接
@property (nonatomic,  copy) NSString *adUrl;
//广告类型：1:资讯（链接），2商品，3商户，4静港项目（链接）
@property (nonatomic,  copy) NSString *adType;
//广告图片
@property (nonatomic,  copy) NSString *adImgPath;


@end
