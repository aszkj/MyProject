//
//  ReplenishmentView.m
//  YilidiBuyer
//
//  Created by yld on 16/6/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "GoodsStatusView.h"
#import <Masonry/Masonry.h>

@interface GoodsStatusView()

@property (nonatomic, strong)UILabel *goodsStatusLabel;

@end

@implementation GoodsStatusView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    
    UIView *maskView = [UIView new];
    [self addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.8;
    
    self.goodsStatusLabel = [UILabel new];
    self.goodsStatusLabel.textColor = [UIColor whiteColor];
    self.goodsStatusLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.goodsStatusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.goodsStatusLabel];
    
    [self.goodsStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
    }];
    self.goodsStatusLabel.text = @"已下架";
    
    
}

@end
