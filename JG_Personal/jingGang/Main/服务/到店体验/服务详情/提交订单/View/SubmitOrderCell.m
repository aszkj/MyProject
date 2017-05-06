//
//  SubmitOrderCell.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SubmitOrderCell.h"
#import "urlManagerHeader.h"

@implementation SubmitOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _serviceImage = [UIImageView new];
        [_serviceImage setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:_serviceImage];
        [_serviceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(16);
            make.size.mas_equalTo(CGSizeMake(55, 40));
            make.centerY.equalTo(self);
        }];
        
        _title = [UILabel new];
        _title.font = kFontSize13;
        _title.textColor = KColorText333333;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.serviceImage);
            make.left.equalTo(_serviceImage.mas_right).with.offset(KMarginLeft);
            make.width.equalTo(@(3*(__MainScreen_Width/4)));
        }];
        
        _store = [UILabel new];
        _store.font = kFontSize13;
        _store.textColor = KColorText999999;
        [self.contentView addSubview:_store];
        [_store mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.top.equalTo(_title.mas_bottom).with.offset(6);
            make.right.equalTo(self.mas_right).with.offset(-KMarginLeft);
        }];
        
        _price = [UILabel new];
        _price.font = kFontSize15;
        _price.textAlignment = NSTextAlignmentRight;
        _price.textColor = KColorText333333;
        [self.contentView addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).with.offset(-KMarginLeft);
            make.width.equalTo(@(100));
        }];

        [self.contentView layoutIfNeeded];
    }
    return self;
}

@end
