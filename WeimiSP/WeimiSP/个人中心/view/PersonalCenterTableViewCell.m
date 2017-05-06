//
//  PersonalCenterTableViewCell.m
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "PersonalCenterTableViewCell.h"



@implementation PersonalCenterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@(KLeftMargin));
    }];
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(_titleImageView.mas_right).with.offset(KLeftMargin);
    }];
    [self.contentView addSubview:self.rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-KLeftMargin));
    }];
    
    [self.contentView addSubview:self.rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_rightImageView.mas_left).with.offset(-10);
    }];
    [self.contentView addSubview:self.rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_rightImageView.mas_left).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

#pragma mark - getter

-(UIImageView *)titleImageView
{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _titleImageView;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        _titleLabel.font = KNormalFont;
    }
    return _titleLabel;
}

-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_right"]];
    }
    return _rightImageView;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.textColor = UIColorFromRGB(0x333333);
        _rightLabel.font = KSmallFont;
        _rightLabel.hidden = YES;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = [NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    }
    return _rightLabel;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"default_head"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(updateHeadImageAction) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.hidden = YES;
        _rightButton.layer.cornerRadius = 25;
        _rightButton.clipsToBounds = YES;
    }
    return _rightButton;
}

#pragma mark - private methord

- (void)updateHeadImageAction
{
    if (_updateHeadImageBlock) {
        _updateHeadImageBlock();
    }
}


@end
