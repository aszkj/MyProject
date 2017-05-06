//
//  PersonalInfoHeader.m
//  WeimiSP
//
//  Created by thinker on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "PersonalInfoHeader.h"
#import "BaiduLocationManage.h"

@interface PersonalInfoHeader ()

@property (nonatomic, strong) UIView *linkViewH;
@property (nonatomic, strong) UIView *linkViewV;
@property (nonatomic, strong) UIButton *userEditDataBtn;

@property (nonatomic, strong) UILabel *userLocationLabel;

@end

@implementation PersonalInfoHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@KLeftMargin);
        make.left.equalTo(@KLeftMargin);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self addSubview:self.linkViewH];
    [_linkViewH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(_userImageView.mas_bottom).with.offset(KLeftMargin);
        make.height.equalTo(@1);
    }];
    
    //添加编辑资料点击手势
    UIView *topView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    topView.backgroundColor = [UIColor clearColor];
    [self addSubview:topView];
    topView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editInfoAction)];
    [topView addGestureRecognizer:tap];
    
    [self addSubview:self.userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(2*KLeftMargin));
        make.left.equalTo(_userImageView.mas_right).with.offset(KLeftMargin);
        make.width.lessThanOrEqualTo(@(kScreenWidth - 175));
        make.height.equalTo(@20);
    }];
    UIImageView *locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_GPS"]];
    [self addSubview:locationImageView];
    [self addSubview:self.userLocationLabel];
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLabel.mas_right).with.offset(KLeftMargin);
        make.centerY.equalTo(_userNameLabel.mas_centerY);
    }];
    [_userLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userNameLabel.mas_centerY);
        make.left.equalTo(locationImageView.mas_right).with.offset(20/3);
    }];
    
    [self addSubview:self.userTelLabel];
    [_userTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameLabel.mas_bottom).with.offset(0);
        make.left.equalTo(_userImageView.mas_right).with.offset(KLeftMargin);
        make.width.lessThanOrEqualTo(@(kScreenWidth - 175));
        make.height.equalTo(@20);
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_right"]];
    [self addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userImageView.mas_centerY);
        make.right.equalTo(@(-KLeftMargin));
    }];
    
    //编辑资料
    [self addSubview:self.userEditDataBtn];
    [_userEditDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userImageView.mas_centerY);
        make.right.equalTo(rightImageView.mas_left).with.offset(-KLeftMargin);
    }];
    
    return;
    /*[self addSubview:self.linkViewV];
    [_linkViewV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@1);
        make.bottom.equalTo(@(-KLeftMargin));
        make.top.equalTo(_linkViewH.mas_bottom).with.offset(KLeftMargin);
    }];
    [self addSubview:self.orderNumberLabel];
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-kScreenWidth / 4));
        make.centerY.equalTo(self.mas_bottom).with.offset(-22);
    }];
    [self addSubview:self.profitLabel];
    [_profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(kScreenWidth / 4));
        make.centerY.equalTo(self.mas_bottom).with.offset(-22);
    }];
    
    UIImageView *orderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"danshu"]];
    UIImageView *profitImageView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"shouyi"]];
    [self addSubview:orderImageView];
    [self addSubview:profitImageView];
    [orderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_orderNumberLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(_orderNumberLabel.mas_centerY);
    }];
    [profitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_profitLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(_orderNumberLabel.mas_centerY);
    }];
    
    _orderNumberLabel.attributedText = [self setLabelAttributedWithString:_orderNumberLabel.text];
    _profitLabel.attributedText = [self setLabelAttributedWithString:_profitLabel.text];
    */
}


#pragma mark - getter


-(UIView *)linkViewH
{
    if (!_linkViewH ) {
        _linkViewH = [[UIView alloc] init];
        _linkViewH.backgroundColor = VCBackgroundColor;
    }
    return _linkViewH;
}
-(UIView *)linkViewV
{
    if (!_linkViewV) {
        _linkViewV = [[UIView alloc] init];
        _linkViewV.backgroundColor = VCBackgroundColor;
    }
    return _linkViewV;
}
-(UIButton *)userEditDataBtn
{
    if (!_userEditDataBtn) {
        _userEditDataBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_userEditDataBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
        [_userEditDataBtn setTitleColor:UIColorFromRGB(0Xababab) forState:UIControlStateNormal];
        _userEditDataBtn.titleLabel.font = [UIFont CustomFontOfSize:40/3];
        [_userEditDataBtn addTarget:self action:@selector(editInfoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userEditDataBtn;
}


-(UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head"]];
        _userImageView.layer.cornerRadius = 30;
        _userImageView.clipsToBounds = YES;
    }
    return _userImageView;
}
-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc ]init];
        _userNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _userNameLabel.textColor = UIColorFromRGB(0X000000);
        _userNameLabel.text = @" ";
    }
    return _userNameLabel;
}

-(UILabel *)userTelLabel
{
    if (!_userTelLabel) {
        _userTelLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _userTelLabel.font = [UIFont CustomFontOfSize:13];
        _userTelLabel.text = @" ";
        _userTelLabel.textColor = UIColorFromRGB(0x999999);
    }
    return _userTelLabel;
}

-(UILabel *)orderNumberLabel
{
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc ]init];
        _orderNumberLabel.font = [UIFont CustomFontOfSize:12];
        _orderNumberLabel.text = @"总单数 5";
        _orderNumberLabel.textColor = UIColorFromRGB(0X999999);
    }
    return _orderNumberLabel;
}
-(UILabel *)profitLabel
{
    if (!_profitLabel) {
        _profitLabel = [[UILabel alloc ]init];
        _profitLabel.font = [UIFont CustomFontOfSize:12];
        _profitLabel.text = @"总收益 0.00";
        _profitLabel.textColor = UIColorFromRGB(0X999999);
    }
    return _profitLabel;
}


-(UILabel *)userLocationLabel
{
    if (!_userLocationLabel) {
        _userLocationLabel = [[UILabel alloc] init];
        _userLocationLabel.textColor = UIColorFromRGB(0Xababab);
        _userLocationLabel.font = [UIFont CustomFontOfSize:10];
        _userLocationLabel.text = [[BaiduLocationManage shareManage] currentCity];
    }
    return _userLocationLabel;
}

#pragma mark - private methord

#pragma mark - 编辑个人资料
- (void)editInfoAction
{
    if (self.editInfoActionBlock) {
        _editInfoActionBlock();
    }
}

-(NSAttributedString *)setLabelAttributedWithString:(NSString *)string
{
    NSMutableAttributedString *mutableAttributed = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@" "];
    NSDictionary *dict = @{NSForegroundColorAttributeName:UIColorFromRGB(0Xfc5815),NSFontAttributeName:[UIFont CustomFontOfSize:14]};
    [mutableAttributed addAttributes:dict range:NSMakeRange(range.location, string.length - range.location)];
    return mutableAttributed;
}


@end
