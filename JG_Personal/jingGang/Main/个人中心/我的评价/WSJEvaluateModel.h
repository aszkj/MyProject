//
//  WSJEvaluateModel.h
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WSJEvaluateModel : NSObject

@property (nonatomic, assign) float height;
@property (nonatomic, assign) float O2OHeight;
//商品id
@property (nonatomic, copy) NSNumber *goodsID;
//用户头像 *
@property (nonatomic, copy) NSString *titleImageURL;
//用户名   *
@property (nonatomic, copy) NSString *titleName;
//用户评论 *
@property (nonatomic, copy) NSString *evaluateContent;
@property (nonatomic, assign) CGFloat evaluateHeight;
//评论时间和类型  *
@property (nonatomic, copy) NSString *date;

//图片内容 *
@property (nonatomic, strong) NSMutableArray *dataImageArray;
//掌柜回复 *
@property (nonatomic, copy) NSString *shopkeeper;
@property (nonatomic, assign) CGFloat shopkeeperHeight;
//追加评论 *
@property (nonatomic, copy) NSString *supplement;
@property (nonatomic, assign) CGFloat supplementHeight;


//我的评论
@property (nonatomic, assign) BOOL isMeEvaluate;

//星星数量
@property (nonatomic, assign) NSInteger starCount;

@end
