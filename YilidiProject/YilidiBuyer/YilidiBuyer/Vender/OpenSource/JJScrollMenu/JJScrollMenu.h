//
//  JJScrollMenu.h
//  market
//
//  Created by 邹俊 on 2016/8/3.
//  Copyright © 2016年 尚娱网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJScrollMenu : UIView


/**
 * 标题
 */
@property (nonatomic, strong) NSArray *menuTitles;

@property (nonatomic, assign) int currentIndex;

/**
 * 标题栏背景颜色
 */
@property (nonatomic, strong) UIColor *menuBackgroundColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *normalFontColor;
@property (nonatomic, strong) UIColor *selectedFontColor;
@property (nonatomic, assign) int normalFontSize;
@property (nonatomic, assign) int selectedFontSize;




@property (nonatomic, strong) NSArray *contentControllers;




@end
