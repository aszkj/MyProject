//
//  UIBarButtonItem+WNXBarButtonItem.m
//  WNXHuntForCity
//
//  Created by MacBook on 15/6/29.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import "UIBarButtonItem+WNXBarButtonItem2.h"

@implementation UIBarButtonItem (WNXBarButtonItem2)

+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action
{
    UIImage *normalImage = [UIImage imageNamed:image];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:normalImage forState:UIControlStateNormal];
//    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

+ (UIBarButtonItem *)initWithNormalImageBig:(NSString *)image target:(id)target action:(SEL)action
{
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenHeight-35, 30, 35, 35);
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height
{
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, height);
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

#pragma mark - 靖港项目的返回按钮
+ (UIBarButtonItem *)initDLSalerBackItemWihtAction:(SEL)action target:(id)target{

    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 12, 22)];
    [button_na setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [button_na addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button_na];
    
}



+ (UIBarButtonItem *)barButtonItemSpace:(NSInteger)itemSpace {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (!itemSpace) {
        itemSpace = -12;
    }
    negativeSpacer.width = itemSpace;
    return negativeSpacer;
}



@end
