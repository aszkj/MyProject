//
//  UpdateUserInfoTableViewCell.m
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "UpdateUserInfoTableViewCell.h"

@interface UpdateUserInfoTableViewCell ()


@end

@implementation UpdateUserInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - 实例化UI
- (void)initUI
{
    [self.contentView addSubview:self.titleImageView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(2*KLeftMargin));
        make.bottom.equalTo(@(-KLeftMargin));
    }];
    [self.contentView addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@100);
        make.width.equalTo(@170);
        make.height.equalTo(@40);
        make.centerY.equalTo(_titleImageView);
    }];
    [self.contentView addSubview:self.identifyingBtn];
    [_identifyingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleImageView);
        make.right.equalTo(@(-2 * KLeftMargin));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xe5e5e5);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(2*KLeftMargin));
        make.bottom.equalTo(@0);
        make.right.equalTo(@(-2*KLeftMargin));
        make.height.equalTo(@0.5);
    }];
    
}

#pragma mark - getter

-(UIImageView *)titleImageView
{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
    }
    return _titleImageView;
}

-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypeASCIICapable;
        _textField.secureTextEntry = YES;
    }
    return _textField;
}

-(UIButton *)identifyingBtn
{
    if (!_identifyingBtn) {
        _identifyingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _identifyingBtn.hidden = YES;
        [_identifyingBtn setBackgroundImage:[UIImage imageNamed:@"UpdateTel_fasong"] forState:UIControlStateNormal];
        [_identifyingBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_identifyingBtn setTitleColor:UIColorFromRGB(0xc2c2c7) forState:UIControlStateNormal];
        _identifyingBtn.titleLabel.font = [UIFont CustomFontOfSize:40 / 3];
        [_identifyingBtn addTarget:self action:@selector(beginVeryCodeTimer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _identifyingBtn;
}


#pragma mark - private methord

#pragma mark - 发送验证码
-(void)beginVeryCodeTimer {
    if (_sendIdentifyingBlcok) {
        _sendIdentifyingBlcok();
    }
}




@end
