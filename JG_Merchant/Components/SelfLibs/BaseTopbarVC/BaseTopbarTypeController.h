//
//  BaseTopbarTypeController.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl+setAttribute.h"
#import "HMSegmentedControl.h"
@interface BaseTopbarTypeController : UIViewController

@property (nonatomic, strong)HMSegmentedControl *topBarHMSegmentedControl;

//内容视图数组
@property (nonatomic, copy)NSArray *contentViewsArr;

//控制器title
@property (nonatomic, copy)NSString *topVCtitle;

//topBar title
@property (nonatomic, copy)NSArray *sectionTitles;

#pragma mark - 供子类调用 - 加载子内容视图
-(UIView *)loadContentViewWithName:(NSString *)viewName;

#pragma mark - 供子类重写 - 点击上面topbar
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl;


@end
