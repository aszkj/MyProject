//
//  UIView+UIImage.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView (UIImage)

+ (UIImage *)getImageFromView:(UIView *)view;
+ (UIImage *)imageFromView:(UIView *)view atFrame:(CGRect)frame;

@end
