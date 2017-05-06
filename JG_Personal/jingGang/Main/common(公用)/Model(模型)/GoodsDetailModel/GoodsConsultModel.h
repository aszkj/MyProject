//
//  GoodsConsultModel.h
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsConsultModel : BaseModel

//id
@property (nonatomic,  copy) NSNumber *GoodsConsultModelID;
//咨询时间
@property (nonatomic,  copy) NSString *addTime;
//咨询用户id
@property (nonatomic,  copy) NSNumber *consultUserId;
//咨询用户名
@property (nonatomic,  copy) NSString *consultUserName;
//回复时间
@property (nonatomic,  copy) NSDate *replyTime;
//回复用户名
@property (nonatomic,  copy) NSString *replyUserName;
//满意数
@property (nonatomic,  copy) NSNumber *satisfy;
//店铺名称
@property (nonatomic,  copy) NSString *storeName;
//不满意数量
@property (nonatomic,  copy) NSNumber *unsatisfy;
//是否为自营商品咨询 0为第三方 1为自营
@property (nonatomic,  copy) NSNumber *whetherSelf;
//咨询内容
@property (nonatomic,  copy) NSString *consultContent;
//回复内容
@property (nonatomic,  copy) NSString *consultReply;
//商品信息
@property (nonatomic,  copy) NSString *goodsInfo;

#pragma mark 新增 cell行高
@property NSInteger cellHeight;

@end
