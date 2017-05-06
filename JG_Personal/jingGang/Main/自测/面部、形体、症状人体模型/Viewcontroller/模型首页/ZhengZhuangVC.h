//
//  ZhengZhuangVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GloableEmerator.h"

typedef enum : NSUInteger {
    Body_Model_Type, //身体模型
    Face_Model_type,//面部模型
    Figure_Model_type,//形体模型
}ModelType;

@interface ZhengZhuangVC : UIViewController

- (instancetype)initWithFaceWebPush:(void(^)())pushFace;

//模型类型
@property (nonatomic,assign)ModelType zz_ModelType;

@property (nonatomic, assign)ListType listType;

//分类ID
@property (nonatomic, assign)NSInteger fenlieID;

//模型的h5链接
@property (nonatomic,strong)NSString *zz_ModelHtmlUrl;



@end
