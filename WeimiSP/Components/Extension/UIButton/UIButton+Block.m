//
//  UIButton+Block.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (Block)
-(void)addActionHandler:(TouchedBlock)touchHandler{
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)actionTouched:(UIButton *)btn{
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end

@implementation TQEasyIconInfo

- (instancetype)initWithSpacing:(CGFloat)spacing iconDirection:(TQEasyIconDirection)direction
{
    self = [super init];
    if (self) {
        self.iconWithTitleSpacing = spacing;
        self.iconDirection        = direction;
    }
    return self;
}

@end

@implementation UIButton (TQEasyIcon)

#pragma mark - icon direction property

@dynamic iconInfo;

static char* const ASSOCIATION_ICON_INFO = "ASSOCIATION_ICON_INFO";

- (void)setIconInfo:(TQEasyIconInfo *)iconInfo
{
    objc_setAssociatedObject(self,ASSOCIATION_ICON_INFO,iconInfo,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TQEasyIconInfo *)iconInfo
{
    id obj = objc_getAssociatedObject(self,ASSOCIATION_ICON_INFO);
    
    if (obj == nil)
    {
        obj = [[TQEasyIconInfo alloc] initWithSpacing:0 iconDirection:0];
    }
    
    return obj;
}

#pragma mark - setIconIn L,R,T,B

- (void)setIconInLeft
{
    [self setIconInLeftWithSpacing:0];
}

- (void)setIconInRight
{
    [self setIconInRightWithSpacing:0];
}

- (void)setIconInTop
{
    [self setIconInTopWithSpacing:0];
}

- (void)setIconInBottom
{
    [self setIconInBottomWithSpacing:0];
}

#pragma mark - setIconIn L,R,T,B With Spacing

- (void)setIconInLeftWithSpacing:(CGFloat)Spacing
{
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   =   (Spacing / 2),
        .bottom = 0,
        .right  = - (Spacing / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = - (Spacing / 2),
        .bottom = 0,
        .right  =   (Spacing / 2),
    };
    
    TQEasyIconInfo *iconInfo = [[TQEasyIconInfo alloc] initWithSpacing:Spacing iconDirection:TQEasyIconInLeft];
    
    [self setIconInfo:iconInfo];
}

- (void)setIconInRightWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = - (img_W + Spacing / 2),
        .bottom = 0,
        .right  =   (img_W + Spacing / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   =   (tit_W + Spacing / 2),
        .bottom = 0,
        .right  = - (tit_W + Spacing / 2),
    };
    
    TQEasyIconInfo *iconInfo = [[TQEasyIconInfo alloc] initWithSpacing:Spacing iconDirection:TQEasyIconInRight];
    
    [self setIconInfo:iconInfo];
}

- (void)setIconInTopWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    =   (tit_H / 2 + Spacing / 2),
        .left   = - (img_W / 2),
        .bottom = - (tit_H / 2 + Spacing / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = - (img_H / 2 + Spacing / 2),
        .left   =   (tit_W / 2),
        .bottom =   (img_H / 2 + Spacing / 2),
        .right  = - (tit_W / 2),
    };
    
    TQEasyIconInfo *iconInfo = [[TQEasyIconInfo alloc] initWithSpacing:Spacing iconDirection:TQEasyIconInTop];
    
    [self setIconInfo:iconInfo];
}

- (void)setIconInBottomWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = - (tit_H / 2 + Spacing / 2),
        .left   = - (img_W / 2),
        .bottom =   (tit_H / 2 + Spacing / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    =   (img_H / 2 + Spacing / 2),
        .left   =   (tit_W / 2),
        .bottom = - (img_H / 2 + Spacing / 2),
        .right  = - (tit_W / 2),
    };
    
    TQEasyIconInfo *iconInfo = [[TQEasyIconInfo alloc] initWithSpacing:Spacing iconDirection:TQEasyIconInBottom];
    
    [self setIconInfo:iconInfo];
}

@end

@implementation UIButton (Design)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (void)setEnlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end