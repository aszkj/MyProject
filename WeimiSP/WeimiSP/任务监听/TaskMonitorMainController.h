//
//  TaskMonitorMainController.h
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XKJHSlideSwitchView;
@class MyTaskMonitorController;
@class AcceptOrdeController;
@class PersonalCenterViewController;

@interface TaskMonitorMainController : UIViewController

@property (nonatomic, strong) XKJHSlideSwitchView *slideSwitchView;
@property (nonatomic, strong) PersonalCenterViewController *myTaskMonitorController;
@property (nonatomic, strong) AcceptOrdeController *acceptOrdeController;

@end
