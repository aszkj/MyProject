//
//  UIView+Design.m
//  
//
//  Created by 1 on 15/4/21.
//
//

#import "UIView+Design.h"
#import <objc/runtime.h>


@implementation UIView (Design)

@dynamic cornerRadius,borderColor,borderWidth;
@dynamic barTintGradientColorStart,barTintGradientColorEnd,gradientColors;

static CGFloat const kDefaultOpacity = 1.0f;

#define CornerRadius_Key @"CornerRadius_Key"
#define BorderWidth_Key @"BorderWidth_Key"
#define BorderColor_Key @"BorderColor_Key"
#define barTintGradientColorStart_Key @"barTintGradientColorStart_Key"
#define barTintGradientColorEnd_Key @"barTintGradientColorEnd_Key"
#define gradientLayer_Key @"gradientLayer_Key"
#define gradientColors_Key @"gradientColors_Key"

#pragma mark - UIView + gradientColor
- (NSArray *)gradientColors{
    return objc_getAssociatedObject(self, gradientColors_Key);
}

- (void)setGradientColors:(NSArray *)gradientColors
{
    objc_setAssociatedObject(self, gradientColors_Key, gradientColors,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (CAGradientLayer *)gradientLayer{
    return objc_getAssociatedObject(self, gradientLayer_Key);
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer
{
    objc_setAssociatedObject(self, gradientLayer_Key, gradientLayer,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)barTintGradientColorEnd{
    return objc_getAssociatedObject(self, barTintGradientColorEnd_Key);
}

- (void)setBarTintGradientColorEnd:(UIColor *)barTintGradientColorEnd
{
    objc_setAssociatedObject(self, barTintGradientColorEnd_Key, barTintGradientColorEnd,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (UIColor *)barTintGradientColorStart{
    return objc_getAssociatedObject(self, barTintGradientColorStart_Key);
}

- (void)setBarTintGradientColorStart:(UIColor *)barTintGradientColorStart
{
    objc_setAssociatedObject(self, barTintGradientColorStart_Key, barTintGradientColorStart,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsDisplay];
}

- (void)drawGradientColor
{
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    if (self.gradientColors) {
        colors = [[NSMutableArray alloc] initWithArray:self.gradientColors];
    }else{
        if (self.barTintGradientColorStart) {
            [colors addObject:self.barTintGradientColorStart];
        }
        if (self.barTintGradientColorEnd) {
            [colors addObject:self.barTintGradientColorEnd];
        }
    }

    
    if ( self.gradientLayer == nil )
    {
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.opacity = kDefaultOpacity;
//        self.gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.gradientLayer.frame = self.bounds;
        
        if (colors.count > 0) {
            [self setBarTintGradientColors:colors.copy];
        }
    }
}



- (void)setBarTintGradientColors:(NSArray *)barTintGradientColors
{
    if (self.gradientLayer == nil) {
        self.gradientColors = [[NSArray alloc] initWithArray:barTintGradientColors];
        [self setNeedsDisplay];
    }
    
    NSMutableArray * colors = nil;
    if (barTintGradientColors != nil)
    {
        colors = [NSMutableArray arrayWithCapacity:[barTintGradientColors count]];
        
        // determine elements in the array are colours
        // and add them to the colors array
        [barTintGradientColors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIColor class]])
            {
                // UIColor class
                [colors addObject:(id)[obj CGColor]];
            }
            else if ( CFGetTypeID( (__bridge void *)obj ) == CGColorGetTypeID() )
            {
                // CGColorRef
                [colors addObject:obj];
            }
            else
            {
                // obj is not a supported type
                @throw [NSException exceptionWithName:@"BarTintGraidentColorsError" reason:@"object in barTintGradientColors array is not a UIColor or CGColorRef" userInfo:nil];
            }
        }];
        
    }
    
    // set the graident colours to the laery
    self.gradientLayer.colors = colors;
    [self.gradientLayer removeFromSuperlayer];
    [self.layer insertSublayer:self.gradientLayer atIndex:0];//作为背景图层插入

}

#pragma mark - UIView + corner and broder

- (CGFloat)cornerRadius{
    NSNumber *key = (NSNumber *)objc_getAssociatedObject(self, CornerRadius_Key);
    return key.doubleValue;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    objc_setAssociatedObject(self, CornerRadius_Key, [NSNumber numberWithDouble:cornerRadius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)borderWidth{
    NSNumber *key = (NSNumber *)objc_getAssociatedObject(self, BorderWidth_Key);
    return key.doubleValue;
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    objc_setAssociatedObject(self, BorderWidth_Key, [NSNumber numberWithDouble:borderWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor{
    return objc_getAssociatedObject(self, BorderColor_Key);
}

-(void)setBorderColor:(UIColor *)borderColor{
    objc_setAssociatedObject(self, BorderColor_Key, borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = self.borderColor.CGColor;
}

#pragma mark - UIView + DarwShapLayer
- (void)addShapLayer
{
    //给tableVIew添加两个圆角
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
    shapLayer.frame = self.layer.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:shapLayer.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    shapLayer.path = maskPath.CGPath;
    [self.layer addSublayer:shapLayer];
}

@end
