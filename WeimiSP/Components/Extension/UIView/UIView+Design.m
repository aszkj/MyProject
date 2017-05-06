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

@end

@implementation UIView (Frame)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)maxX {
    return self.x + self.width;
}

- (void)setMaxX:(CGFloat)maxX {
    self.x += maxX - self.maxX;
}

- (CGFloat)maxY {
    return self.y + self.height;
}

- (void)setMaxY:(CGFloat)maxY {
    self.y += maxY - self.maxY;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}


@end

