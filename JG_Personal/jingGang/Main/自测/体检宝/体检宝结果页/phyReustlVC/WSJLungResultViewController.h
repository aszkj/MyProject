//
//  WSJLungResultViewController.h
//  jingGang
//
//  Created by thinker on 15/7/29.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    lungCapacityType, //肺活量结果界面
    bloodOxygenType     //血氧结果界面
}WSJResultType;

@interface WSJLungResultViewController : UIViewController

//设置界面类型
@property (nonatomic, assign) WSJResultType type;
//肺活量值
@property (nonatomic, assign) NSInteger lungValue;

//血氧值 0 ~ 100范围
@property (nonatomic, assign) NSInteger heartRateValue;

@end
