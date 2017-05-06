//
//  XKJHOffLinePayDetailCell.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOffLinePayDetailCell.h"

@implementation XKJHOffLinePayDetailCell

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
        UILabel *name = [UILabel new];
        name.font = kFontSize14;
        name.textColor = KColorText333333;
        [self.contentView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(15);
            make.left.equalTo(self.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@100);
        }];
        self.customerNameLabel = name;
        
        UILabel *phoneNumber = [UILabel new];
        phoneNumber.font = kFontSize14;
        phoneNumber.text = @"18718866602";
        phoneNumber.textColor = KColorText333333;
        [self.contentView addSubview:phoneNumber];
        [phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(15);
            make.left.equalTo(self.customerNameLabel.mas_right).with.offset(KLeftMargin);
            make.width.equalTo(@100);
        }];
        self.phoneNumberLabel = phoneNumber;
        
        UILabel *money = [UILabel new];
        money.font = kFontSize14;
        money.text = @"收入金额：￥500";
        money.textColor = KColorText333333;
        money.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:money];
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(15);
            make.right.equalTo(self.mas_right).with.offset(-KLeftMargin);
            make.width.equalTo(@120);
        }];
        self.totalPriceLabel = money;
        
        UIImageView *middleBgView = [UIImageView new];
        middleBgView.image = IMAGE(@"line_card_details");
        [self.contentView addSubview:middleBgView];
        [middleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(44);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.width.equalTo(@(kScreenWidth));
            make.height.equalTo(@60);
        }];
        self.middleBgView = middleBgView;

        UIImageView *heartImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        heartImg.image = IMAGE(@"Line order");
        [middleBgView addSubview:heartImg];
//        [heartImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(middleBgView.mas_top).with.offset(15);
//            make.left.equalTo(middleBgView.mas_left).with.offset(70);
//            make.width.equalTo(@30);
//            make.height.equalTo(@30);
//        }];
        self.heartImg = heartImg;
        
        UILabel *packageName = [[UILabel alloc] initWithFrame:CGRectZero];
        packageName.font = kFontSize16;
        packageName.text = @"福永店养生理疗套餐";
        packageName.textColor = [UIColor whiteColor];
        packageName.textAlignment = NSTextAlignmentCenter;
        [middleBgView addSubview:packageName];
//        [packageName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(middleBgView.mas_top).with.offset(22);
//            make.left.equalTo(middleBgView.mas_left).with.offset(110);
//            make.width.equalTo(@(kScreenWidth - 140));
//        }];
        self.groupService = packageName;
        
        UILabel *consumeCode = [UILabel new];
        consumeCode.font = kFontSize14;
        consumeCode.text = @"消费码：";
        consumeCode.textColor = KColorText333333;
        [self.contentView addSubview:consumeCode];
        [consumeCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(119);
            make.left.equalTo(self.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@200);
        }];
        self.consumeStatusLabel = consumeCode;
        
        UILabel *orderTime = [UILabel new];
        orderTime.font = kFontSize14;
        orderTime.text = @"下单时间：";
        orderTime.textColor = KColorText333333;
        orderTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:orderTime];
        self.addTimeLabel = orderTime;
        
        UIImageView *downBgView = [UIImageView new];
        downBgView.backgroundColor = background_Color;
        [self.contentView addSubview:downBgView];
        [downBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(148);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.width.equalTo(@(kScreenWidth));
            make.height.equalTo(@5);
        }];
    }
    return self;
}

- (void)setCellData:(OrderDetailsModel *)groupOrderModel {
    
    if (groupOrderModel.userNickname != nil) {
//        self.customerNameLabel.text = groupOrderModel.nickname;
        self.customerNameLabel.text = groupOrderModel.userNickname;
    } else {
        self.customerNameLabel.text = @"非会员";
    }
    
    self.phoneNumberLabel.text = groupOrderModel.mobile;
    
//    self.addTimeLabel.text = [NSString stringWithFormat:@"下单时间: %@",[self.dateFormatter stringFromDate:groupOrderModel.addTime]];
    self.addTimeLabel.text = groupOrderModel.dateStr;

    self.totalPriceLabel.text = [NSString stringWithFormat:@"收入金额: %@",[groupOrderModel.profitPrice stringValue]];
    
    NSString *consumeStatus = [NSString stringWithFormat:@"消费码: %@",groupOrderModel.groupSn];
    if (groupOrderModel.groupSn != nil) {
        self.consumeStatusLabel.text = consumeStatus;
        self.addTimeLabel.textAlignment = NSTextAlignmentRight;

        [self.addTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(119);
            make.right.equalTo(self.mas_right).with.offset(-KLeftMargin);
            make.width.equalTo(@180);
        }];
    } else {
        self.consumeStatusLabel.text = @"";
        self.addTimeLabel.textAlignment = NSTextAlignmentLeft;

        [self.addTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(119);
            make.left.equalTo(self.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@180);
        }];
    }
    
//    NSString *serviceName = [NSString stringWithFormat:@"%@",groupOrderModel.groupService.goodsName];
    NSString *serviceName = [NSString stringWithFormat:@"%@",groupOrderModel.localGroupName];
    if (groupOrderModel.localGroupName != nil) {
        self.groupService.text = serviceName;
    } else {
        self.groupService.text = @"";
    }
    
    [self.groupService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.middleBgView.mas_centerY);
        make.centerX.equalTo(self.middleBgView.mas_centerX).with.offset(12.5);
        make.width.equalTo(@(kStringSize(groupOrderModel.localGroupName, 16, kScreenWidth, 16).width + 30));
    }];
    
    
    [self.heartImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.middleBgView.mas_centerY);
//        make.centerX.equalTo(self.middleBgView.mas_centerX).with.offset(-(kStringSize(groupOrderModel.groupService.goodsName, 16, kScreenWidth, 16).width/2 + 12.5));
        make.right.equalTo(self.groupService.mas_left);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    }
    
    return _dateFormatter;
}

@end
