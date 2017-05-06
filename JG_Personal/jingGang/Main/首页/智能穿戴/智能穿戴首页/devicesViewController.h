//
//  devicesViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSlideSegmentController.h"

@interface devicesViewController : UIViewController

@property (strong, nonatomic) JYSlideSegmentController *slideSegmentController;

//是否从自测页面进入
@property (nonatomic,assign)BOOL commInFromTest;

@end
