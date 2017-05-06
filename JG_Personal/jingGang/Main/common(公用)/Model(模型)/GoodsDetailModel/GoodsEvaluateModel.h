//
//  GoodsEvaluateModel.h
//  jingGang
//
//  Created by 张康健 on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsEvaluateModel : BaseModel

//id
@property (nonatomic, copy) NSNumber *GoodsEvaluateModelID;
//addTime
@property (nonatomic, copy) NSDate *addTime;
//描述相符评价 对卖家描述相符评价
@property (nonatomic, copy) NSNumber *descriptionEvaluate;
//买家评价  买家评价，评价类型，1为好评，0为中评，-1为差评
@property (nonatomic, copy) NSNumber *evaluateBuyerVal;
//晒单图片
@property (nonatomic, copy) NSString *evaluatePhotos;
//评价状态  0为正常，1为禁止显示，2为取消评价
@property (nonatomic, copy) NSNumber *evaluateStatus;
//成交时的价格
@property (nonatomic, copy) NSString *goodsPrice;
//id
@property (nonatomic, copy) NSNumber *serviceEvaluate;
//发货速度评价  对卖家发货速度评价
@property (nonatomic, copy) NSNumber *shipEvaluate;
//评价时间
@property (nonatomic, copy) NSDate *addevaTime;
//管理员操作备注
@property (nonatomic, copy) NSString *evaluateAdminInfo;
//买家评价信息
@property (nonatomic, copy) NSString *evaluateInfo;
//商品属性值
@property (nonatomic, copy) NSString *goodsSpec;
//评价回复
@property (nonatomic, copy) NSString *reply;
//id
@property (nonatomic, copy)NSString *addevaInfo;
//
@property (nonatomic, copy) NSString *addevaPhotos;
//买家昵称
@property (nonatomic,  copy) NSString *nickName;
//商品名称
@property (nonatomic,  copy) NSString *goodsName;
//店铺名称
@property (nonatomic, copy) NSString *storeName;
//头像
@property (nonatomic,  copy) NSString *headImgPath;


@end
