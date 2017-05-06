//
//  AdRecommendModel.h
//  jingGang
//
//  Created by 张康健 on 15/8/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface AdRecommendModel : BaseModel

//推荐id
@property (nonatomic,  copy) NSString *itemId;
//广告描述
@property (nonatomic,  copy) NSString *adText;
//广告标题
@property (nonatomic,  copy) NSString *adTitle;
//广告链接
@property (nonatomic,  copy) NSString *adUrl;
//广告类型：1:资讯（链接），2商品，3商户，4资讯（静港项目）（链接）
@property (nonatomic,  copy) NSString *adType;
//广告图片
@property (nonatomic,  copy) NSString *adImgPath;
//查询时间戳
@property (nonatomic,  copy) NSString *timeStamp;
//商品当前价格
@property (nonatomic, copy) NSNumber *goodsCurrentPrice;
//商品手机专享价
@property (nonatomic, copy) NSNumber *goodsMobilePrice;
//商品名称
@property (nonatomic, copy) NSString *goodsName;
//是否有手机专享价
@property (nonatomic, copy) NSNumber *hasMobilePrice;


@end
