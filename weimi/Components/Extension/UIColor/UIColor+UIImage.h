//
//  UIColor+UIImage.h
//  jingGang
//
//  Created by zhupeng on 15-9-1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIColor (UIImage)

- (UIImage *)translateIntoImage;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
