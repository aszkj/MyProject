//
//  XKJHStatisticsCell.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHStatisticsCell.h"

@implementation XKJHStatisticsCell

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
        
        self.contentView.backgroundColor = UIColorFromRGB(0Xe6f6f5);
        UILabel *time = [UILabel new];
        time.font = kFontSize16;
        time.textColor = KColorText333333;
        time.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(8);
            make.left.equalTo(self.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@(kScreenWidth/2 - 2*KLeftMargin));
        }];
        self.time = time;
        
        UILabel *income = [UILabel new];
        income.font = kFontSize16;
        income.textColor = KColorText333333;
        income.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:income];
        [income mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(8);
            make.right.equalTo(self.mas_right).with.offset(-KLeftMargin);
            make.width.equalTo(@(kScreenWidth/2 - 2*KLeftMargin));
        }];
        self.income = income;

        UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 0.5, 0, 1, 32)];
        middleLine.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:middleLine];
        
        UIView *dividLine = [[UIView alloc] initWithFrame:CGRectMake(0, 33, kScreenWidth, 1)];
        dividLine.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:dividLine];
    }
    return self;
}


@end
