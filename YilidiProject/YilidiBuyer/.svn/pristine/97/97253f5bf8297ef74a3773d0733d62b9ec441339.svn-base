//
//  UIColor+FJColor.m
//  Zebra
//
//  Created by cy-fengjian on 15/9/30.
//  Copyright © 2015年 cy-fengjian. All rights reserved.
//

#import "UIColor+FJColor.h"

@implementation UIColor (FJColor)

+ (UIColor *)colorWithHex:(long)hex andAlpha:(CGFloat)alpha{
 
    float red = ((float)((hex & 0xFF0000)>>16))/255.0;
    float green = ((float)((hex & 0xFF00)>>8))/255.0;
    float blue = ((float)(hex & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}
@end
