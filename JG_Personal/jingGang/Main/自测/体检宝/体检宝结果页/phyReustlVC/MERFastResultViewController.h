//
//  MERFastResultViewController.h
//  jingGang
//
//  Created by thinker on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MERFastResultViewController : UIViewController

/**
 *  心率值
 */
@property (nonatomic, assign) NSInteger heartRateValue;

/**
 *  血氧值 0 ~ 100范围
 */
@property (nonatomic, assign) NSInteger OxygenValue;

/**
 *  高压
 */
@property (nonatomic, assign) NSInteger highPressure;
/**
 *  低压
 */
@property (nonatomic, assign) NSInteger lowPressure;

@end
