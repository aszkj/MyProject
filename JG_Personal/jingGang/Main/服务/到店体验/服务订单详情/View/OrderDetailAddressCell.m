//
//  OrderDetailAddressCell.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderDetailAddressCell.h"
#import "urlManagerHeader.h"

@interface OrderDetailAddressCell()

@property (strong, nonatomic) UIButton *phoneBtn;

@end

@implementation OrderDetailAddressCell

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
        _shopName = [UILabel new];
        _shopName.font = kFontSize14;
        _shopName.textColor = KColorText666666;
        [self.contentView addSubview:_shopName];
        [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(KMarginTop);
            make.left.equalTo(self.mas_left).with.offset(KMarginLeft);
            make.size.mas_equalTo(CGSizeMake(200, 14));
        }];
        
        
        [self.contentView addSubview:self.phoneBtn];
        [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_right).with.offset(-30);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        UIView *rightView = [UIView new];
        rightView.backgroundColor = VCBackgroundColor;
        [self.contentView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(_phoneBtn.mas_centerX).with.offset(-30);
            make.size.mas_equalTo(CGSizeMake(1, 38));
        }];

        _address = [UILabel new];
        _address.font = kFontSize12;
        _address.textColor = KColorText999999;
        [self.contentView addSubview:_address];
        [_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).with.offset(KMarginLeft);
//            make.size.mas_equalTo(CGSizeMake(220, 12));
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(rightView.mas_left).with.offset(-5);
        }];

        
        UIImageView *addressImg = [UIImageView new];
        addressImg.image = IMAGE(@"ZUOBIAO");
        [self.contentView addSubview:addressImg];
        [addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-KMarginTop);
            make.left.equalTo(self.mas_left).with.offset(KMarginLeft);
            make.size.mas_equalTo(CGSizeMake(10, 12));
        }];
        
        _distance = [UILabel new];
        _distance.font = kFontSize11;
        _distance.textColor = KColorText999999;
        _distance.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_distance];
        [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(addressImg.mas_centerY);
            make.left.equalTo(addressImg.mas_right).with.offset(kMarginHorizontal);
            make.size.mas_equalTo(CGSizeMake(200, 11));
        }];
        
    }
    return self;
}

- (UIButton *)phoneBtn {
    if (_phoneBtn == nil) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setImage:IMAGE(@"ask_call") forState:UIControlStateNormal];
        [_phoneBtn addTarget:self action:@selector(phoneCall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

- (void)phoneCall {
    if (_phoneCallBlk) {
        _phoneCallBlk();
    }
}

@end
