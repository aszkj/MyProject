//
//  JGBloodPressureTestErrorView.m
//  jingGang
//
//  Created by dengxf on 16/2/19.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGBloodPressureTestErrorView.h"

@interface JGBloodPressureTestErrorView ()

@property(nonatomic, assign) BOOL isShowed;

@end

@implementation JGBloodPressureTestErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JGBaseColor;
        [self setup];
    }
    return self;
}

- (void)setup {
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.backgroundColor = JGClearColor;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = JGFont(18);
    titleLab.textColor = JGBlackColor;
    titleLab.x = 0;
    titleLab.y = 19;
    titleLab.width = ScreenWidth;
    titleLab.height = NavBarHeight;
    [self addSubview:titleLab];
    [titleLab setText:@"血压测试"];
    
    CGFloat width = 344.0 / 2;
    CGFloat height = width;
    CGFloat x = (ScreenWidth - width) / 2;
    CGFloat y = CGRectGetMaxY(titleLab.frame) + 28;
    UIImageView *noneImg = [[UIImageView alloc] init];
    noneImg.image = [UIImage imageNamed:@"jg_testunResult"];
    noneImg.x = x;
    noneImg.y = y;
    noneImg.width = width;
    noneImg.height = height;
    [self addSubview:noneImg];

    UIButton *errorButton = [[UIButton alloc] init];
    errorButton.x = 0 ;
    errorButton.y = CGRectGetMaxY(noneImg.frame) + 10;
    errorButton.width = ScreenWidth;
    errorButton.height  = 30;
    errorButton.titleLabel.font = JGFont(18);
    [errorButton setTitleColor:JGBlackColor forState:UIControlStateNormal];
    [errorButton setTitle:@"未采集到血压的数值" forState:UIControlStateNormal];
    [errorButton setImage:[UIImage imageNamed:@"jg_testicon"] forState:UIControlStateNormal];
    errorButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    [self addSubview:errorButton];

    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.x = 50;
    detailLab.y = CGRectGetMaxY(errorButton.frame) + 10;
    detailLab.width = ScreenWidth - 100 ;
    detailLab.height = 60;
    detailLab.numberOfLines = 0;
    detailLab.backgroundColor = JGClearColor;
    [self addSubview:detailLab];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.font = JGFont(16);
    detailLab.text = @"请用手指充分覆盖摄像头，按住屏幕重新开始测量";
    
    JGTouchEdgeInsetsButton *closeButton = [JGTouchEdgeInsetsButton buttonWithType:UIButtonTypeCustom];
    closeButton.x = 15 ;
    closeButton.y = 20;
    closeButton.width = 60;
    closeButton.height = 60;
    closeButton.backgroundColor = JGRandomColor;
    closeButton.touchEdgeInsets = UIEdgeInsetsMake(-20, -15, 0, 0);
    [closeButton addTarget:self action:@selector(closeErrorView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
}

- (void)closeErrorView:(UIButton *)button {
    BLOCK_EXEC(self.closeViewActionBlock);
}

- (void)showView {
    if (self.isShowed) {
        return;
    }
    BLOCK_EXEC(self.showViewBlock,self);
    self.isShowed = YES;
}

- (void)dissMissCompleted:(void (^)())completed {
    if (self.isShowed) {
        BLOCK_EXEC(self.dismissViewBlock,self);
        BLOCK_EXEC(completed);
        self.isShowed = NO;
    }
}


@end
