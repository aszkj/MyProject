//
//  ZFActionSheet.m
//  YXJ
//
//  Created by yld on 16/4/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ZFActionSheet.h"

#define Height_44 44
#define Height_50 50
#define Height_60 60
#define lineHeight  0.5
#define LineSpacing 5

#define ZFSize_5  5
#define ZFSize_13 15
#define ZFSize_14 14
#define ZFSize_17 17
#define ZFSize_40 40

#define kScreenCenter self.window.center

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZFActionSheet ()
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString  *title;
@property (nonatomic, strong) NSArray *confirms;
@property (nonatomic, strong) NSString *cancel;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, assign) ZFActionSheetStyle style;
@end

@implementation ZFActionSheet

+ (ZFActionSheet *)actionSheetWithTitle:(NSString *)title confirms:(NSArray *)confirms cancel:(NSString *)cancel style:(ZFActionSheetStyle)style
{
    return [[self alloc] initWithTitle:title confirms:confirms cancel:cancel style:style];
}
#pragma mark - 初始化控件
- (instancetype)initWithTitle:(NSString *)title confirms:(NSArray *)confirms cancel:(NSString *)cancel style:(ZFActionSheetStyle)style
{
    self = [super init];
    if (self) {
        self.title = title;
        self.confirms = confirms;
        self.cancel = cancel;
        self.style = style;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}
- (UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.alpha = 0.4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapAction)];
        [_shadowView addGestureRecognizer:tap];
    }
    return _shadowView;
}
- (void)createSubViews
{
    CGFloat titleHeight = 0;
    CGFloat confirmHeight = 0;
    CGFloat separatorHeight = 0;
    CGFloat cancelHeight = 0;
    
    /** 提示信息 */
    if (self.title && self.title.length) {
        UIFont *font = [UIFont systemFontOfSize:ZFSize_13];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = LineSpacing;
        NSDictionary *attributes = @{NSFontAttributeName:font,
                           NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize maxSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        CGSize titleSize = [self.title boundingRectWithSize:maxSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes
                                             context:nil].size;
        titleHeight = titleSize.height + ZFSize_40;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        // titleLabel.backgroundColor = [UIColor orangeColor];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:ZFSize_13];
        titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, titleHeight);
        titleLabel.text = self.title;
        [self addSubview:titleLabel];
    }
    
    /** 选项按钮 */
    CGFloat buttonHeight;
    if (SCREEN_WIDTH <= 320) {
        buttonHeight = Height_44;
    }else if (SCREEN_WIDTH <=375){
        buttonHeight = Height_50;
    }else{
        buttonHeight = Height_60;
    }
    for (int i=0; i<self.confirms.count; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        if ((!self.title || !self.title.length) && i==0) {
            line.frame = CGRectZero;
        }else{
            line.frame = CGRectMake(0, titleHeight + i*(buttonHeight+lineHeight), SCREEN_WIDTH, lineHeight);
        }
        
        line.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.200];
        [self addSubview:line];
        confirmHeight += lineHeight;
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        // confirm.backgroundColor = [UIColor purpleColor];
        confirm.frame = CGRectMake(0, line.frame.origin.y+lineHeight, SCREEN_WIDTH, buttonHeight);
        [confirm setTitle:self.confirms[i] forState:UIControlStateNormal];
        confirm.titleLabel.font = [UIFont systemFontOfSize:ZFSize_17];
        [confirm setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        if (self.style == ZFActionSheetStyleDestructive) {
            [confirm setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else if(self.style == ZFActionSheetStyleCancel){
            confirm.titleLabel.font = [UIFont boldSystemFontOfSize:ZFSize_17];
        }
        [confirm addTarget:self action:@selector(button:clickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirm];
        confirmHeight += buttonHeight;
    }
    
    /** 确定/取消之间的分割线 */
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.400];
    // separator.backgroundColor = [UIColor blackColor];
    separator.frame = CGRectMake(0, titleHeight + confirmHeight, SCREEN_WIDTH, ZFSize_5);
    [self addSubview:separator];
    separatorHeight = ZFSize_5;
    
    /** 取消 */
    CGFloat cancleHeight;
    if (SCREEN_WIDTH <= 320) {
        cancleHeight = Height_44;
    }else if (SCREEN_WIDTH <=375){
        cancleHeight = Height_50;
    }else{
        cancleHeight = Height_60;
    }
    
    CGFloat cancelY = titleHeight + confirmHeight + separatorHeight;
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    // cancel.backgroundColor = [UIColor yellowColor];
    cancel.frame = CGRectMake(0, cancelY, SCREEN_WIDTH, cancleHeight);
    [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancel setTitle:self.cancel forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:ZFSize_17];
    [cancel addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    cancelHeight = cancleHeight;
    
    CGFloat ActionSheetHeight = titleHeight + confirmHeight + separatorHeight + cancelHeight;
    self.frame = CGRectMake(0, SCREEN_HEIGHT - ActionSheetHeight, SCREEN_WIDTH, ActionSheetHeight);
}

#pragma mark - 显示界面
- (void)showInView:(id)obj
{
    [obj addSubview:self.shadowView];
    [obj addSubview:self];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @(0);
    opacity.duration = 0.2;
    [self.shadowView.layer addAnimation:opacity forKey:nil];

    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(kScreenCenter.x, SCREEN_HEIGHT)];
    move.duration = 0.2;
    [self.layer addAnimation:move forKey:nil];
}

#pragma mark - 代理方法
- (void)button:(UIButton *)button clickAtIndex:(NSUInteger)index
{
//    if ([self.delegate respondsToSelector:@selector(clickAction:atIndex:)]) {
//        [self animationHideShadowView];
//        [self animationHideActionSheet];
//        NSInteger index = [self.confirms indexOfObject:button.titleLabel.text];
//        [self.delegate clickAction:self atIndex:index];
//    }
    
    if (_sheetBlock!=nil) {
        [self animationHideShadowView];
        [self animationHideActionSheet];
         NSInteger index = [self.confirms indexOfObject:button.titleLabel.text];
        _sheetBlock(index);
    }
}

#pragma mark - 背景点击事件
- (void)tapAction
{
    [self animationHideShadowView];
    [self animationHideActionSheet];
    if (self.hideSheeBlock) {
        self.hideSheeBlock();
    }
}

#pragma mark - 取消
- (void)cancelButtonClick
{
    [self animationHideShadowView];
    [self animationHideActionSheet];
    if (self.hideSheeBlock) {
        self.hideSheeBlock();
    }
}

#pragma mark - 隐藏动画
- (void)animationHideShadowView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
    }];
}
- (void)animationHideActionSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (CGFloat) height
{
    return self.frame.size.height;
}

@end
