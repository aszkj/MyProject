//
//  AcceptOrdeHeaderView.m
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "AcceptOrdeHeaderView.h"
#import "AcceptOrdeHeaderEntity.h"

#define KUpAndDownSpacing               10
#define KDefaultWidth                   (kScreenWidth-75)/3

@interface AcceptOrdeHeaderView()

@property (nonatomic) UIImageView *incomeImg;
@property (nonatomic) UIImageView *completeOrderNumImg;
@property (nonatomic) UIImageView *completeOrderPercentageImg;

@end

@implementation AcceptOrdeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    [self creatUI];

    return self;
}

#pragma mark - set UI init

- (void)creatUI
{
//    [self addSubview:self.time];
//    [self addSubview:self.acceptOrderNum];
    [self addSubview:self.incomeImg];
    [self addSubview:self.income];
    [self addSubview:self.completeOrderNum];
    [self addSubview:self.completeOrderNumImg];
    [self addSubview:self.completeOrderPercentage];
    [self addSubview:self.completeOrderPercentageImg];

    UIView *superview = self;
//    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(superview).with.offset(KLeftMargin);
//        make.top.equalTo(superview).with.offset(KUpAndDownSpacing);
//        make.width.equalTo(@120);
//        make.height.equalTo(@16);
//    }];
//    
//    [_acceptOrderNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_time.mas_right).with.offset(KLeftMargin*2);
//        make.top.equalTo(superview).with.offset(KUpAndDownSpacing);
//        make.width.equalTo(@120);
//        make.height.equalTo(@16);
//    }];
    
    [_incomeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview).with.offset(KLeftMargin*2);
        make.bottom.equalTo(superview).with.offset(-KUpAndDownSpacing);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [_income mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_incomeImg.mas_right).with.offset(5);
        make.bottom.equalTo(superview).with.offset(-KUpAndDownSpacing);
        make.size.mas_equalTo(CGSizeMake(KDefaultWidth, 14));
    }];
    
    [_completeOrderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superview).with.offset(-KUpAndDownSpacing);
        make.centerX.mas_equalTo(superview).with.offset(KLeftMargin*2);
        make.size.mas_equalTo(CGSizeMake(KDefaultWidth, 14));
    }];
    
    [_completeOrderNumImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superview).with.offset(-KUpAndDownSpacing);
        make.right.equalTo(_completeOrderNum.mas_left).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [_completeOrderPercentage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superview).with.offset(-KLeftMargin);
        make.bottom.equalTo(superview).with.offset(-KUpAndDownSpacing);
        make.size.mas_equalTo(CGSizeMake(KDefaultWidth, 14));
    }];
    
    [_completeOrderPercentageImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_completeOrderPercentage.mas_left).with.offset(-5);
        make.bottom.equalTo(superview).with.offset(-KUpAndDownSpacing);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
}

- (UILabel *)time {
    if (_time == nil) {
        _time = [UILabel new];
        _time.textAlignment = NSTextAlignmentLeft;
        _time.textColor = [UIColor blackColor];
        _time.font = kFontSizeBold16;
    }
    return _time;
}

- (UILabel *)acceptOrderNum {
    if (_acceptOrderNum == nil) {
        _acceptOrderNum = [UILabel new];
        _acceptOrderNum.textAlignment = NSTextAlignmentLeft;
        _acceptOrderNum.textColor = [UIColor blackColor];
        _acceptOrderNum.font = kFontSizeBold16;
    }
    return _acceptOrderNum;
}

- (UIImageView *)incomeImg {
    if (_incomeImg == nil) {
        
        _incomeImg = [XKO_CreateUIViewHelper createUIImageViewWithImage:IMAGE(@"order_income")];
        
    }
    return _incomeImg;
}

- (UIImageView *)completeOrderNumImg {
    if (_completeOrderNumImg == nil) {
        
        _completeOrderNumImg = [XKO_CreateUIViewHelper createUIImageViewWithImage:IMAGE(@"order_num")];
        
    }
    return _completeOrderNumImg;
}

- (UIImageView *)completeOrderPercentageImg {
    if (_completeOrderPercentageImg == nil) {
        
        _completeOrderPercentageImg = [XKO_CreateUIViewHelper createUIImageViewWithImage:IMAGE(@"order_percentage")];
        
    }
    return _completeOrderPercentageImg;
}

- (UILabel *)income {
    if (_income == nil) {
        _income = [UILabel new];
        _income.textAlignment = NSTextAlignmentLeft;
        _income.textColor = UIColorFromRGB(0x85d8ff);
        _income.font = kFontSize12;
    }
    return _income;
}

- (UILabel *)completeOrderNum {
    if (_completeOrderNum == nil) {
        _completeOrderNum = [UILabel new];
        _completeOrderNum.textAlignment = NSTextAlignmentLeft;
        _completeOrderNum.textColor = UIColorFromRGB(0x85d8ff);
        _completeOrderNum.font = kFontSize12;
    }
    return _completeOrderNum;
}

- (UILabel *)completeOrderPercentage {
    if (_completeOrderPercentage == nil) {
        _completeOrderPercentage = [UILabel new];
        _completeOrderPercentage.textAlignment = NSTextAlignmentLeft;
        _completeOrderPercentage.textColor = UIColorFromRGB(0x85d8ff);
        _completeOrderPercentage.font = kFontSize12;
    }
    return _completeOrderPercentage;
}

//设置内容
- (void)setEntity:(AcceptOrdeHeaderEntity *)entity {
    
    _time.text = entity.time;
    _acceptOrderNum.text = entity.acceptOrderNum;
    _income.text = entity.income;
    _completeOrderNum.text = entity.completeOrderNum;
    _completeOrderPercentage.text = entity.completeOrderPercentage;
    
}

@end
