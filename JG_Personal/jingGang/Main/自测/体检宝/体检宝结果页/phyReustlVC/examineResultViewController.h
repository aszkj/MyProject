//
//  examineResultViewController.h
//  jingGang
//
//  Created by thinker on 15/7/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger{
    k_Blindnes, //色盲界面
    k_Eye   //视力界面
}WSJEyeType;

@interface examineResultViewController : UIViewController


@property (nonatomic, assign) WSJEyeType type;
//测试视力值
@property (nonatomic, copy) NSString *eyeValue;

//判断是否是色盲结果界面，色盲答对个数
@property (nonatomic, assign) NSInteger blindnessValue;

@end
