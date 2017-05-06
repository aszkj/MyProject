//
//  CycleScrollPageShowView.m
//  YilidiBuyer
//
//  Created by mm on 17/2/16.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "CycleScrollPageShowView.h"
#import <Masonry.h>

@interface CycleScrollPageShowView()

@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)UILabel *pageLabel;

@end

@implementation CycleScrollPageShowView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _setUp];
    }
    return self;
}

- (void)_setUp {
    self.bgView = [UIView new];
    [self addSubview:self.bgView];
    
    self.pageLabel = [UILabel new];
    [self addSubview:self.pageLabel];
    
    self.currentPage = 1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.6;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = self.bgViewCornerRadius;
    
    
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
    self.pageLabel.font = [UIFont systemFontOfSize:15];
    self.pageLabel.textColor = [UIColor whiteColor];
    self.pageLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setTotolPage:(NSInteger)totolPage {
    _totolPage = totolPage;
    self.hidden = totolPage <= 1;
    if (totolPage > 1) {
        [self _setPageLabel];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    [self _setPageLabel];
}

- (void)_setPageLabel {
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentPage,self.totolPage];
}

@end
