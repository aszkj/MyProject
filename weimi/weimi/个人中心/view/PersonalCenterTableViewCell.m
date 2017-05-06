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
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_right"]];
    [self.contentView addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-KLeftMargin));
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


@end
