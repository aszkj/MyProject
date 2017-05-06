//
//  SetttingCell.m
//  Operator_JingGang
//
//  Created by 鹏 朱 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "SetttingCell.h"

@implementation SetttingCell

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
        
//        UILabel *title = [self createLabelWithFont:kFontSize12 fontColor:KColorText333333 text:@"邀请码"];
//        self.title = title;
//        [self.contentView addSubview:self.title];
        
        UILabel *title = [self createLabelWithFont:self.textLabel.font fontColor:self.textLabel.textColor text:@""];
        self.title = title;
        [self.contentView addSubview:self.title];

        
//        UILabel *content = [self createLabelWithFont:kFontSize12 fontColor:KColorText666666 text:nil];
//        content.textAlignment = NSTextAlignmentRight;
//        self.content = content;
//        [self.contentView addSubview:self.content];
        
        UILabel *content = [self createLabelWithFont:self.detailTextLabel.font fontColor:self.detailTextLabel.textColor text:nil];
        content.textAlignment = NSTextAlignmentRight;
        self.content = content;
        [self.contentView addSubview:self.content];
        
        UIImageView *shareImageView = [self createUIImageViewWithImage:IMAGE(@"Haircut")];
        self.sharImg = shareImageView;
        [self.contentView addSubview:self.sharImg];
    }
    
    return self;
}


- (void)resetDataAndFrame:(NSString *)invitaeCode {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        if (iPhone6p) {
            make.left.equalTo(self.mas_left).offset(20);
        } else {
            make.left.equalTo(self.mas_left).offset(15);
        }
        make.size.mas_equalTo(CGSizeMake(80, 14));
    }];
    
    self.content.text = invitaeCode;
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 14));
    }];

    [self.sharImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];

}

- (CGFloat)getHeightOfCell {
    CGFloat cellHeight = 0;
    
    cellHeight = 48;
    
    return cellHeight;
}

@end
