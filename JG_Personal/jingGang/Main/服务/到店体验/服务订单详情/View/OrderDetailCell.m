//
//  OrderDetailCell.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderDetailCell.h"
#import "urlManagerHeader.h"

@implementation OrderDetailCell

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
        UIView *downLine =[[UIView alloc] initWithFrame:CGRectMake(0, 44, __MainScreen_Width, 1)];
        downLine.backgroundColor = VCBackgroundColor;
        [self.contentView addSubview:downLine];

        _title = [UILabel new];
        _title.font = kFontSize14;
        _title.textColor = KColorText333333;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).with.offset(KMarginLeft);
            make.size.mas_equalTo(CGSizeMake(80, 14));
        }];
        
        _content = [UILabel new];
        _content.font = kFontSize14;
        _content.text = @"总价:68元";
        _content.textColor = KColorText666666;
        [self.contentView addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(_title.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(200, 14));
        }];
    }
    return self;
}

@end
