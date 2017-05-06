//
//  NotDataView.m
//  WeimiSP
//
//  Created by thinker on 16/3/8.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "NotDataView.h"


@interface NotDataView ()

@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIButton *requestButton;

@end

@implementation NotDataView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}


#pragma mark - 实例化UI
- (void)initUI
{
    [self addSubview:self.centerImageView];
    [_centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@(-50));
    }];
    [self addSubview:self.requestButton];
    [_requestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerImageView.mas_bottom).with.offset(5);
        make.centerX.equalTo(@0);
    }];
//    self.backgroundColor = [UIColor redColor];
}


#pragma mark - getter

-(UIImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noMessage"]];
    }
    return _centerImageView;
}
-(UIButton *)requestButton
{
    if (!_requestButton) {
        _requestButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_requestButton setTitle:@"您还没有收到任何系统消息" forState:UIControlStateNormal];
        [_requestButton setTitleColor:UIColorFromRGB(0X999999) forState:UIControlStateNormal];
        [_requestButton addTarget:self action:@selector(requestAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _requestButton;
}

#pragma mark - private methord
- (void)requestAction
{
    if (_requestDataBlock) {
        _requestDataBlock();
    }
}


@end
