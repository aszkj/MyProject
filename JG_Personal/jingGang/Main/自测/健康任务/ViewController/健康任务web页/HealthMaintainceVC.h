//
//  HealthMaintainceVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthMaintainceVC : UIViewController

@property (nonatomic,strong)NSString *mainTainceRelativePath;

@property (nonatomic,strong)NSString *mainTainceTitle;

//大任务编号
@property (nonatomic,assign)NSInteger bigTaskNum;


//小任务编号
@property (nonatomic,assign)NSInteger smallTaskNum;


@end
