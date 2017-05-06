//
//  UIImage+SizeAndTintColor.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SizeAndTintColor)


/**
 *  使用blend改变图片颜色.
    使用CG离屏渲染,大量复用的时候记得缓存(shouldRasterize = YES，记住还要设置rasterizationScale = contentsScale)
 *
 *  @param tintColor 需要的颜色
 *
 *  @return 新的图片(纯色系)
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
/**
 *  使用blend改变图片颜色.
 使用CG离屏渲染,大量复用的时候记得缓存(shouldRasterize = YES，记住还要设置rasterizationScale = contentsScale)
 *
 *  @param tintColor 需要的颜色
 *
 *  @return 新的图片(渐变色系)
 */
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;


+ (UIImage *)snapshot:(UIView *)view;
+ (UIImage *)imageFromView: (UIView *) theView;
+ (UIImage *)setImage:(UIImage *)image withAlpha:(CGFloat)alpha;
+ (UIImage *)imageWithCustomColor:(UIColor *)color;

- (UIImage*)cutImageWithScaled:(CGSize)newSize;
- (UIImage*)cutImageWithRadius:(int)radius;
- (UIImage*)cutImageToEclipseWithScaled:(CGSize)newSize;

- (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;
@end
