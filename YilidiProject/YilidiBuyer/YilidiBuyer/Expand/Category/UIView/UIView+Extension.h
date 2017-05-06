//
//  UIView+Extension.h
//  jingGang
//
//  Created by dengxf on 15/10/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**
 *  基于UIView显示遮罩层 */
- (void)showHud;

/**
 *  基于UIView隐藏遮罩层 */
- (void)hiddenHud;

@end
