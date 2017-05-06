//
//  UIImage+extern.m
//  YilidiSeller
//
//  Created by yld on 16/3/29.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "UIImage+extern.h"

@implementation UIImage (Extern)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha
{
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAlpha(context, alpha);
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
        
    }
}

- (UIImage *)imageScaledToSize:(CGSize)size
{
    @autoreleasepool {
        //avoid redundant drawing
        if (CGSizeEqualToSize(self.size, size))
        {
            return self;
        }
        
        //create drawing context
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        
        //draw
        [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        
        //capture resultant image
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //return image
        return image;
    }
}


@end
