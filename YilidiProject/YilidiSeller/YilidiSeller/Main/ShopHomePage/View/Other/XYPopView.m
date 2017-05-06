//
//  XYPopView.m
//  pop
//
//  Created by  yld on 16/6/3.
//  Copyright © 2016年  yld.All rights reserved.
//

#import "XYPopView.h"

#define kWindow [[UIApplication sharedApplication].delegate window]
#define kButtonHeight 30
#define kFont [UIFont systemFontOfSize:12]

@implementation XYPopView
{
    NSArray *buttonItems;
    CGFloat popViewX;
    CGFloat popViewY;
    BOOL isShow;
    UIButton *button;
}

- (instancetype)initWithSuperView:(UIView *)superView
{
    if (self = [super init]) {
        [self loadUI:superView];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView items:(NSArray *)items
{
    if (self = [super init]) {
        buttonItems = [NSArray arrayWithArray:items];
        [self loadUI:superView];
    }
    return self;
}
/**
 *  设置按钮数组
 *
 *  @param items 数组按钮
 */
- (void)setItems:(NSArray *)items
{
    _items = items;
    buttonItems = [NSArray arrayWithArray:items];
}
/**
 *  设置弹出视图的背景色
 *
 *  @param backColor 背景色,默认白色
 */
- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    self.backColor = backColor;
}
/**
 *  弹出视图边框颜色
 *
 *  @param PopBorderColor 默认黑色
 */
- (void)setPopBorderColor:(UIColor *)PopBorderColor
{
    _PopBorderColor = PopBorderColor;
    self.layer.borderColor = PopBorderColor.CGColor;
}
/**
 *  显示弹出视图,再次点击消失
 */
- (void)showPopView
{
    if (!isShow) {
        [kWindow addSubview:self];
        [UIView animateWithDuration:0.333 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, buttonItems.count * kButtonHeight);
        }];
    }else{
        [UIView animateWithDuration:0.333 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    isShow = !isShow;
}
//按钮点击事件
- (void)buttonClick:(UIButton *)sender
{

    if (_popviewBlock) {
        _popviewBlock(sender.tag);
        [self showPopView];
    }
}
/**
 *  布局
 *
 *  @param superView superView description
 */
- (void)loadUI:(UIView *)superView
{
    isShow = NO;
    popViewX = superView.frame.origin.x;
    popViewY = superView.frame.origin.y;
    
    UIView *sup = superView;
    while ([sup.superview isKindOfClass:[UIView class]]) {
        popViewX += sup.superview.frame.origin.x;
        popViewY += sup.superview.frame.origin.y;
        NSLog(@"%f", popViewX);
        sup = sup.superview;
    }
    self.frame = CGRectMake(popViewX, superView.frame.size.height + popViewY, superView.frame.size.width, 0);
    [self setButton];
    self.layer.borderWidth = 1;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
}
/**
 *  设置按钮
 */
- (void)setButton
{
        for (int i = 0; i < buttonItems.count; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:buttonItems[i] forState:UIControlStateNormal];
        button.titleLabel.font = kFont;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.5;
        button.frame = CGRectMake(0, kButtonHeight * i, self.frame.size.width, kButtonHeight);
        [self addSubview:button];
    }
    if ([buttonItems lastObject]) {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

@end
