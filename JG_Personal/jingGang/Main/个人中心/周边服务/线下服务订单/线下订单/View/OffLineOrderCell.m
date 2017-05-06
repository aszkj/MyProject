//
//  OffLineOrderCell.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OffLineOrderCell.h"
#import "urlManagerHeader.h"

@implementation OffLineOrderCell

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
        
        _title = [UILabel new];
        _title.font = kFontSize14;
        _title.textColor = KColorText333333;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY).with.offset(-KMarginVertical );
            make.left.equalTo(self.mas_left).with.offset(KMarginLeft);
            make.width.equalTo(@(200));
        }];
        
        _price = [UILabel new];
        _price.font = kFontSize12;
        _price.text = @"总价:68元";
        _price.textColor = KColorText666666;
        [self.contentView addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).with.offset(KMarginVertical );
            make.left.equalTo(self.mas_left).with.offset(KMarginLeft);
            make.width.equalTo(@(100));
        }];

        _consumeState = [UILabel new];
        _consumeState.font = kFontSize12;
        _consumeState.text = @"已退款";
        _consumeState.textColor = KColorText999999;
        _consumeState.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_consumeState];
        [_consumeState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).with.offset(KMarginVertical );
            make.right.equalTo(self.mas_right).with.offset(-KMarginLeft);
            make.width.equalTo(@(100));
        }];
    }
    return self;
}

@end
