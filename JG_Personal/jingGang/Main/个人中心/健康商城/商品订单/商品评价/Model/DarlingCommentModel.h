//
//  DarlingCommentModel.h
//  jingGang
//
//  Created by 张康健 on 15/8/18.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

//宝贝评论model
@interface DarlingCommentModel : NSObject

//评论文字内容
@property (nonatomic,copy)NSString *commentTextContent;

//是否添加了图片
@property (nonatomic, assign)BOOL isAddedPhoto;

//图片，imageArr
@property (nonatomic,copy)NSMutableArray *commentImgArr;

//图片urlArr
@property (nonatomic,copy)NSMutableArray *commentImgUrlArr;

//图片urlStr,用竖线连接起来的
@property (nonatomic, copy)NSString *joinedImgUrlStr;

//评级,描述相符
@property (nonatomic, assign)NSInteger descriptionStars;

//评级,服务态度
@property (nonatomic, assign)NSInteger serviceAltitudeStars;

//评级，物流服务
@property (nonatomic, assign)NSInteger deliveryServiceStars;

//总评价,1中评2好评3差评
@property (nonatomic, assign)NSInteger commentLevel;


#pragma mark - 商品模型给的
@property (nonatomic, copy)NSString * goodsId;
//goodsPrice
@property (nonatomic, strong)NSNumber* goodsCount;

@property (nonatomic, copy)NSString* goodsPrice;

//goodsGspVal
@property (nonatomic, strong)NSString* goodsGspVal;




@end
