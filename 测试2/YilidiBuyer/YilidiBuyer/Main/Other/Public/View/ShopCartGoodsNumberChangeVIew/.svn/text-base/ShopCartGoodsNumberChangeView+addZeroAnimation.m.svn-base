//
//  ShopCartGoodsNumberChangeView+addZeroAnimation.m
//  YilidiBuyer
//
//  Created by yld on 16/5/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsNumberChangeView+addZeroAnimation.h"
#import "NSObject+SUIAdditions.h"

const void *subButtonKey = @"subButtonKey";
const void *subAddKey = @"subAddKey";

@implementation ShopCartGoodsNumberChangeView (addZeroAnimation)

- (void)showAddZeroAnimation:(BOOL)addZeroAnimation
                   addButton:(UIButton *)addButton
                   subButton:(UIButton *)subButton

{
    NSMutableArray *defaultProjectAnimations = [NSMutableArray arrayWithCapacity:0];
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    CGPoint fromPoint = CGPointZero;
    CGPoint toPoint = CGPointZero;
    CGFloat rationAngle = 0.0;
    if (addZeroAnimation) {//加零动画
        fromPoint = addButton.center;
        toPoint = subButton.center;
        rationAngle = M_PI_2;
    }else {
        fromPoint = subButton.center;
        toPoint = addButton.center;
        rationAngle = -M_PI_2;
    }
    
    translation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    translation.toValue = [NSValue valueWithCGPoint:toPoint];
    [defaultProjectAnimations addObject:translation];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //kCAMediaTimingFunctionLinear 表示时间方法为线性，使得足球匀速转动
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotation.fromValue = [NSNumber numberWithFloat:rationAngle];
    [defaultProjectAnimations addObject:rotation];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = defaultProjectAnimations;
    groups.duration = 0.3;
    groups.removedOnCompletion=NO;
    if (addZeroAnimation) {
        groups.fillMode = kCAFillModeForwards;
    }else {
        groups.fillMode = kCAFillModeRemoved;

    }
    //动态绑定subButton和加减类型
    [self sui_setAssociatedRetainObject:subButton key:subButtonKey];
    [self sui_setAssociatedAssignObject:@(addZeroAnimation) key:subAddKey];
    groups.delegate = self;
    [subButton.layer addAnimation:groups forKey:@"group"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    BOOL isAdd = [[self sui_getAssociatedObjectWithKey:subAddKey] boolValue];
    if (!isAdd) {
        UIButton *subButton = (UIButton *)[self sui_getAssociatedObjectWithKey:subButtonKey];
        if (subButton) {
            subButton.hidden = YES;
        }
        [subButton.layer removeAllAnimations];
    }
}


@end
