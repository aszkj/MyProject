//
//  XKJHPackageManagerCell.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHPackageManagerCell.h"

@implementation XKJHPackageManagerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style type:(NSInteger)typeNum reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        _thumbnail = [UIImageView new];
        [self.contentView addSubview:_thumbnail];
        [_thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(10);
            make.left.equalTo(self.mas_left).with.offset(KLeftMargin);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];

        _title = [UILabel new];
        _title.font = kFontSize14;
        _title.numberOfLines = 2;
        _title.text = @"护理套餐，女性专享";
        _title.textColor = KColorText333333;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(10);
            make.left.equalTo(self.mas_left).with.offset(80);
            make.width.equalTo(@(kScreenWidth - 140));
        }];

        if (typeNum == 1) {
            _offShelfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_offShelfBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
            _offShelfBtn.titleLabel.font = kFontSizeBold14;
            _offShelfBtn.backgroundColor = [UIColor redColor];
            [_offShelfBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_offShelfBtn setTitle:@"下架" forState:UIControlStateNormal];
            _offShelfBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            _offShelfBtn.layer.cornerRadius = 7;
            _offShelfBtn.layer.masksToBounds = YES;
            [self.contentView addSubview:_offShelfBtn];
            [_offShelfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).with.offset(9);
                make.right.equalTo(self.mas_right).with.offset(-10);
                make.width.equalTo(@44);
                make.height.equalTo(@16);
            }];
        } else if (typeNum == 0) {
            _offShelfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_offShelfBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
            _offShelfBtn.titleLabel.font = kFontSizeBold14;
            _offShelfBtn.backgroundColor = status_color;
            [_offShelfBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_offShelfBtn setTitle:@"上架" forState:UIControlStateNormal];
            _offShelfBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            _offShelfBtn.layer.cornerRadius = 7;
            _offShelfBtn.layer.masksToBounds = YES;
            [self.contentView addSubview:_offShelfBtn];
            [_offShelfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).with.offset(9);
                make.right.equalTo(self.mas_right).with.offset(-10);
                make.width.equalTo(@44);
                make.height.equalTo(@16);
            }];
            
//            _addShelfState = [UILabel new];
//            _addShelfState.font = kFontSize11;
//            _addShelfState.text = @"上架审核中";
//            _addShelfState.backgroundColor = KColorText999999;
//            _addShelfState.textAlignment =NSTextAlignmentCenter;
//            _addShelfState.textColor = [UIColor whiteColor];
//            [self.contentView addSubview:_addShelfState];
//            [_addShelfState mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_title.mas_bottom).with.offset(3);
//                make.left.equalTo(self.mas_left).with.offset(80);
//                make.width.equalTo(@60);
//                make.height.equalTo(@20);
//            }];
        }
        
        UILabel *goodsPrice = [UILabel new];
        goodsPrice.font = kFontSize16;
        goodsPrice.textColor = KColorText5AC4F1;
        [self.contentView addSubview:goodsPrice];
        [goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(80);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
            make.width.equalTo(@105);
        }];
        self.price = goodsPrice;
        
        UILabel *saledNumber = [UILabel new];
        saledNumber.font = kFontSize11;
        saledNumber.textColor = KColorText666666;
        saledNumber.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:saledNumber];
        [saledNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.width.equalTo(@105);
        }];
        self.saledNumber = saledNumber;
        
        UIView *dividLine = [[UIView alloc] initWithFrame:CGRectMake(0, 79, kScreenWidth, 1)];
        dividLine.backgroundColor = background_Color;
        [self.contentView addSubview:dividLine];
        
    }
    return self;
}

- (void)selectBtn:(UIButton *)button
{
    if (self.pressBlock) {
        self.pressBlock();
    }
}

@end
