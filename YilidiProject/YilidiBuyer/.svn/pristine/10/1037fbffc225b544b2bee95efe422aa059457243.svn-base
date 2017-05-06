//
//  CountDownView.m
//  YilidiBuyer
//
//  Created by yld on 16/8/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CountDownView.h"
#import <Masonry/Masonry.h>

const CGFloat perCountViewWidth = 17;
const CGFloat perCountViewHeight = 14;
const CGFloat perCountViewGap = 10;
const CGFloat countFontSize = 10;


@interface CountDownView()

@property (nonatomic, strong)UILabel *hourLabel;
@property (nonatomic, strong)UILabel *miniteLabel;
@property (nonatomic, strong)UILabel *secondsLabel;

@end

@implementation CountDownView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _setUpUi];
    }
    return self;
}

- (void)_setUpUi {
    
    //分
    UIView *miniteView = [self _createPerCountDownBgView];
    [self addSubview:miniteView];
    [miniteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(perCountViewWidth, perCountViewHeight));
    }];
    
    self.miniteLabel = [self _createPerCountDownLabel];
    [miniteView addSubview:self.miniteLabel];
    [self.miniteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(miniteView);
        make.size.mas_equalTo(CGSizeMake(perCountViewWidth, perCountViewHeight));
    }];
    
    //小时
    UIView *hourView = [self _createPerCountDownBgView];
    [self addSubview:hourView];
    [hourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(miniteView.mas_left).with.offset(-perCountViewGap);
        make.size.mas_equalTo(CGSizeMake(perCountViewWidth, perCountViewHeight));
        make.centerY.mas_equalTo(miniteView);
    }];
    
    self.hourLabel = [self _createPerCountDownLabel];
    [hourView addSubview:self.hourLabel];
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(hourView);
        make.size.mas_equalTo(CGSizeMake(perCountViewWidth, perCountViewHeight));
    }];
    
    //秒
    UIView *secondsView = [self _createPerCountDownBgView];
    [self addSubview:secondsView];
    [secondsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(miniteView.mas_right).with.offset(perCountViewGap);
        make.size.mas_equalTo(CGSizeMake(perCountViewWidth, perCountViewHeight));
        make.centerY.mas_equalTo(miniteView);
    }];
    
    self.secondsLabel = [self _createPerCountDownLabel];
    [secondsView addSubview:self.secondsLabel];
    [self.secondsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(secondsView);
        make.size.mas_equalTo(CGSizeMake(perCountViewWidth, perCountViewHeight));
    }];
    
    
    //两点
    UILabel *dotLabelleft = [UILabel new];
    dotLabelleft.text = @":";
    dotLabelleft.textColor = [UIColor blackColor];
    dotLabelleft.font = kSystemFontSize(countFontSize);
    [self addSubview:dotLabelleft];
    [dotLabelleft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(5);
        make.right.mas_equalTo(miniteView.mas_left).with.offset(-perCountViewGap/4);
    }];
    
    UILabel *dotLabelRight = [UILabel new];
    dotLabelRight.text = @":";
    dotLabelRight.textColor = [UIColor blackColor];
    dotLabelRight.font = kSystemFontSize(countFontSize);
    [self addSubview:dotLabelRight];
    [dotLabelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(5);
        make.left.mas_equalTo(miniteView.mas_right).with.offset(perCountViewGap/4);
    }];
}

- (void)_displayCountDownNumber{
    if (self.countDownNumber <= 0) {
        _countDownNumber = 0;
    }
    NSInteger hour = self.countDownNumber / SECONDS_PER_HOUR;
    NSInteger minute = (self.countDownNumber - hour * SECONDS_PER_HOUR) / SECONDS_PER_MINUTE;
    NSInteger seconds = self.countDownNumber - hour * SECONDS_PER_HOUR - minute * SECONDS_PER_MINUTE;
    if (hour >= 99) {
        hour = 99;
    }
    if (minute >= 59) {
        minute = 59;
    }
    if (seconds >= 59) {
        seconds = 59;
    }

    self.hourLabel.text = jFormat(@"%02ld",hour);
    self.miniteLabel.text = jFormat(@"%02ld",minute);
    self.secondsLabel.text = jFormat(@"%02ld",seconds);
}

- (void)setCountDownNumber:(NSInteger)countDownNumber {
    _countDownNumber = countDownNumber;
    [self _displayCountDownNumber];
}

- (UIView *)_createPerCountDownBgView {
    UIView *perCountDownBgView = [UIView new];
    perCountDownBgView.backgroundColor = [UIColor blackColor];
    perCountDownBgView.alpha = 0.9;
    perCountDownBgView.layer.masksToBounds = YES;
    perCountDownBgView.layer.cornerRadius = 2.0f;
    return perCountDownBgView;
}


- (UILabel *)_createPerCountDownLabel {
    UILabel *perCountDownLabel = [UILabel new];
    perCountDownLabel.font = kSystemFontSize(countFontSize);
    perCountDownLabel.textAlignment = NSTextAlignmentCenter;
    perCountDownLabel.textColor = [UIColor whiteColor];
    return perCountDownLabel;
}


@end
