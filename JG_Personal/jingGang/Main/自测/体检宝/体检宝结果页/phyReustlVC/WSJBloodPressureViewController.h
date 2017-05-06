//
//  WSJBloodPressureViewController.h
//  jingGang
//
//  Created by thinker on 15/7/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WSJBloodPressureViewController : UIViewController

- (instancetype)initWithPop:(void(^)())popBlock;

//高压
@property (nonatomic, assign) NSInteger highPressure;
//低压
@property (nonatomic, assign) NSInteger lowPressure;

@end
