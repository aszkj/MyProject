//
//  DLAnimatePerformer.m
//  YilidiSeller
//
//  Created by yld on 16/4/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAnimatePerformer.h"

@interface DLAnimatePerformer()

@property (nonatomic, strong)CALayer *performAnimationLayer;


@end

@implementation DLAnimatePerformer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _initAnimateAttribute];
    }
    return self;
}

- (void)_initAnimateAttribute {
    
    self.animateDuration = 0.6f;
    self.animateCompledRemoved = YES;
    self.animateShowContainerView = [UIApplication sharedApplication].keyWindow;
    self.animateGroups = [NSMutableArray arrayWithCapacity:0];
    self.animateViewFrame = CGRectZero;
    self.animateStartPoint = CGPointZero;
}

- (void)performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:(UIImageView *)animateGoodsImgView
                                                         animateViewFrame:(CGRect)animateViewFrame
                                                 animateShowContainerView:(UIView *)animateShowContainerView
                                                          animateEndPoint:(CGPoint)animatiEndPoint
                                                       animateDidEndBlock:(AnimateDidEndBlock)animateDidEndBlock
{
    if (self.performAnimationLayer.superlayer) {
        return;
    }
    [self _initAnimateAttribute];
    self.animateViewFrame = animateViewFrame;
    self.animateShowContainerView = animateShowContainerView;
    self.animateImgView = animateGoodsImgView;
    self.animateDidEndBlock = animateDidEndBlock;
    self.animateEndPoint = animatiEndPoint;
    [self _beginDefaultAnimateConfigure];
}

- (void)performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:(UIImageView *)animateGoodsImgView
                                                          animateEndPoint:(CGPoint)animatiEndPoint
                                                       animateDidEndBlock:(AnimateDidEndBlock)animateDidEndBlock
{
    [self performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animateGoodsImgView animateViewFrame:self.animateViewFrame animateShowContainerView:self.animateShowContainerView animateEndPoint:animatiEndPoint animateDidEndBlock:animateDidEndBlock];

}


- (void)setAnimateImgView:(UIImageView *)animateImgView {
    
    _animateImgView = animateImgView;
    //为什么要在这个属性的setter方法里面初始化，，因为这个self.animateViewFrame这个属性的初始值最好是和_animateImgView的大小是一样的，也就是，self.animateViewFrame这个属性的初始值依赖_animateImgView这个属性的初始值，而不像有些属性初始化时可以取任意指定的值，所以它的初始化要放在它依赖的属性初始化时设置，
    if (CGRectEqualToRect(self.animateViewFrame, CGRectZero)) {
        self.animateViewFrame = self.animateImgView.frame;
    }
}

- (void)_beginDefaultAnimateConfigure {
    
    [self configureAnimateLayer];
    self.animateGroups = [self getDefaultProjectAnimations];
    [self beginGroupAnimate];
}

- (void)beginGroupAnimate {
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = self.animateGroups;
    groups.duration = self.animateDuration;
    groups.removedOnCompletion=self.animateCompledRemoved;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [self.performAnimationLayer addAnimation:groups forKey:@"group"];
    
}

- (void)setAnimateEndPoint:(CGPoint)animateEndPoint {
    _animateEndPoint = animateEndPoint;
    [self _confirurgureBesialPathStartMiddelPoint];
}

- (void)_initAnimateStartPoint {
    
    if (CGPointEqualToPoint(self.animateStartPoint, CGPointZero)) {
        self.animateStartPoint = [self.animateShowContainerView convertPoint:self.animateImgView.center fromView:self.animateImgView.superview];
    }
}

-(void)_confirurgureBesialPathStartMiddelPoint {
    [self _initAnimateStartPoint];
    self.animateBezialMiddelPoint = [self getDefaultBesialMiddlePoint];
}

- (void)configureAnimateLayer {
    UIImageView *imageView=[[UIImageView alloc]initWithImage:self.animateImgView.image];
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.frame = self.animateViewFrame;
    imageView.hidden=YES;
    imageView.center=self.animateStartPoint;
    self.performAnimationLayer.contents=imageView.layer.contents;
    self.performAnimationLayer.frame=imageView.frame;
    self.performAnimationLayer.opacity=1;
    [self.animateShowContainerView.layer addSublayer:self.performAnimationLayer];
}

- (NSArray *)getDefaultProjectAnimations {
    
    NSMutableArray *defaultProjectAnimations = [NSMutableArray arrayWithCapacity:0];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:self.animateStartPoint];
    [path addQuadCurveToPoint:self.animateEndPoint controlPoint:self.animateBezialMiddelPoint];
    
    CAKeyframeAnimation *pathAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    [defaultProjectAnimations addObject:pathAnimation];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0.9);
    scaleAnimation.toValue = @(0.2);
    [defaultProjectAnimations addObject:scaleAnimation];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(0.8);
    alphaAnimation.toValue = @(0.2);
    [defaultProjectAnimations addObject:alphaAnimation];
    return [defaultProjectAnimations copy];
}



- (CGPoint)getDefaultBesialMiddlePoint {
    //贝塞尔曲线中间点
    float sx=self.animateStartPoint.x;
    float sy=self.animateStartPoint.y;
    float ex=self.animateEndPoint.x;
    float ey=self.animateEndPoint.y;
    float x=sx+(ex-sx)/2;
    float y=sy+(ey-sy)*0.5-300*((ey-sy)/530.0)-30;
    CGPoint centerPoint=CGPointMake(x,y);
    return centerPoint;
}

- (CALayer *)performAnimationLayer {
    
    if (!_performAnimationLayer) {
        _performAnimationLayer = [CALayer new];
    }
    return _performAnimationLayer;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.performAnimationLayer removeAllAnimations];
    [self.performAnimationLayer removeFromSuperlayer];
    if (self.animateDidEndBlock) {
        self.animateDidEndBlock();
    }
}

- (void)performCommmonGroupAimations:(NSArray *)groupAnimations
                  showAnimateImgView:(UIImageView *)showAnimateImgView
            showAnimateContainerView:(UIView *)showAnimateContainerView
                  animateDidEndBlock:(AnimateDidEndBlock)animateDidEndBlock
{
    self.animateImgView = showAnimateImgView;
    self.animateShowContainerView = showAnimateContainerView;
    [self _initAnimateStartPoint];
    self.animateDidEndBlock = animateDidEndBlock;
    [self configureAnimateLayer];
    self.animateGroups = groupAnimations;
    [self beginGroupAnimate];

}





@end
