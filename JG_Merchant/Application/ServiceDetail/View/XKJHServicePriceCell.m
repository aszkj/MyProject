//
//  XKJHServicePriceCell.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHServicePriceCell.h"
#import "UIColor+UIImage.h"
#import "Util.h"

@interface XKJHServicePriceCell()

@property(nonatomic, strong) UIView *middleView;
@property(nonatomic, strong) UIView *downView;

@end

@implementation XKJHServicePriceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        upImageView.image = IMAGE(@"Background");

        [self.contentView addSubview:upImageView];
        self.upImageView = upImageView;
        
        UIView *middleView = [[UIView alloc] initWithFrame:CGRectZero];;
        middleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [self.contentView addSubview:middleView];
        self.middleView = middleView;
        
        UILabel *middleName = [UILabel new];
        middleName.text = @"爱康国宾体检中心";
        middleName.numberOfLines = 2;
        middleName.font = [UIFont systemFontOfSize:16];
        middleName.textColor = [UIColor whiteColor];
        [middleView addSubview:middleName];
        [middleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleView.mas_top).with.offset(3);
            make.left.equalTo(middleView.mas_left).with.offset(10);
            make.width.equalTo(@(kScreenWidth - 20));
            make.height.equalTo(@44);
        }];
        self.middleName = middleName;
        
        UIView *downView = [[UIView alloc] initWithFrame:CGRectZero];
        downView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:downView];
        self.downView = downView;
        
        UILabel *unit = [UILabel new];
        unit.text = @"￥";
        unit.font = [UIFont systemFontOfSize:13];
        unit.textColor = [UIColor colorFromHexRGB:@"59C4F0"];
        [downView addSubview:unit];
        [unit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(downView.mas_top).with.offset(33);
            make.left.equalTo(downView.mas_left).with.offset(10);
            make.width.equalTo(@(kScreenWidth - 20));
            make.height.equalTo(@12);
        }];
        
        UILabel *newMoney = [UILabel new];
        newMoney.font = [UIFont systemFontOfSize:13];
        newMoney.textColor = KColorText999999;
        self.nowMoney = newMoney;
        [downView addSubview:self.nowMoney];
        [self.nowMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(downView.mas_top).with.offset(15);
            make.left.equalTo(downView.mas_left).with.offset(31);
            make.width.equalTo(@(3*(kScreenWidth/4)));
            make.height.equalTo(@36);
        }];
        
        UILabel *saleNum = [UILabel new];
        saleNum.text = [NSString stringWithFormat:@"已售265"];
        saleNum.font = [UIFont systemFontOfSize:11];
        saleNum.textColor = [UIColor colorFromHexRGB:@"999999"];
        saleNum.textAlignment = NSTextAlignmentRight;
        [downView addSubview:saleNum];
        [saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(downView.mas_top).with.offset(33);
            make.right.equalTo(downView.mas_right).with.offset(-10);
            make.width.equalTo(@120);
            make.height.equalTo(@13);
        }];
        self.saleNum = saleNum;
    }
    
    return self;
}

- (void)resetCellFrame {
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.upImageView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@50);
    }];

    [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upImageView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@67);
    }];
}

@end
