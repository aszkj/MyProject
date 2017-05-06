//
//  blindnessResultViewController.h
//  jingGang
//
//  Created by thinker on 15/7/28.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    k_Blindness, //色盲界面
    k_Hearing,   //听力界面
    k_Astigma    //散光界面
}WSJEyeResultType;


@interface blindnessResultViewController : UIViewController

//选择哪种结果视图
@property (nonatomic, assign) WSJEyeResultType type;

//判断是否是色盲结果界面，色盲答对个数
@property (nonatomic, assign) NSInteger blindnessValue;


//判断是否是听力结果界面
@property (nonatomic, assign) NSInteger minValue;//听到的最小音频
@property (nonatomic, assign) NSInteger maxValue;//听到的最大音频



//判断是否散光 yes 散光  no 正常
@property (nonatomic, assign) BOOL isAstigmatism;

@end
