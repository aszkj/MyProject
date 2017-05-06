//
//  OrderDetailDynamicCell.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderDetailDynamicCell.h"
#import "urlManagerHeader.h"

@implementation OrderDetailDynamicCell

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
        UIView *middleLine =[[UIView alloc] initWithFrame:CGRectMake(0, 100, __MainScreen_Width, 1)];
        middleLine.backgroundColor = VCBackgroundColor;
        [self.contentView addSubview:middleLine];
        
        UIView *downLine =[[UIView alloc] initWithFrame:CGRectMake(0, 145, __MainScreen_Width, 10)];
//        downLine.backgroundColor = VCBackgroundColor;
        [self.contentView addSubview:downLine];

        _shopImg = [UIImageView new];
        _shopImg.image = IMAGE(@"zhipay");
        _shopImg.contentMode =  UIViewContentModeScaleAspectFill;
        _shopImg.clipsToBounds  = YES;
        [self.contentView addSubview:_shopImg];
        [_shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(KMarginTop);
            make.left.equalTo(self.mas_left).with.offset(KMarginLeft);
            make.size.mas_equalTo(CGSizeMake(111, 80));
        }];
        
        _shopName = [UILabel new];
        _shopName.font = kFontSize16;
        _shopName.textColor = KColorText666666;
        _shopName.text = @"";
        [self.contentView addSubview:_shopName];
        [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_shopImg.mas_top);
            make.left.equalTo(_shopImg.mas_right).with.offset(kMarginHorizontal);
            make.size.mas_equalTo(CGSizeMake(150, 16));
        }];
        
        UIImageView *rightDirection = [UIImageView new];
        rightDirection.image = IMAGE(@"right");
        [self.contentView addSubview:rightDirection];
        [rightDirection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_shopName.mas_top);
            make.right.equalTo(self.mas_right).with.offset(-KMarginLeft);
            make.size.mas_equalTo(CGSizeMake(12, 16));
        }];
        
        [self.contentView addSubview:self.refundBtn];
        [_refundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(middleLine.mas_top).with.offset(-KMarginTop);
            make.right.equalTo(self.mas_right).with.offset(-KMarginLeft);
            make.size.mas_equalTo(CGSizeMake(80, 36));
        }];
        
        UILabel *RMBSymbol = [UILabel new];
        RMBSymbol.font = kFontSize13;
        RMBSymbol.text = @"￥";
        RMBSymbol.textColor = KColorText59C4F0;
        [self.contentView addSubview:RMBSymbol];
        [RMBSymbol mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.refundBtn);
            make.left.equalTo(_shopImg.mas_right).with.offset(kMarginHorizontal);
            make.size.mas_equalTo(CGSizeMake(13, 13));
        }];
        
        _price = [UILabel new];
        _price.font = [UIFont boldSystemFontOfSize:24];
        _price.textColor = KColorText59C4F0;
        _price.textAlignment = NSTextAlignmentLeft;
        _price.text = @"";
        [self.contentView addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.refundBtn);
            make.left.equalTo(RMBSymbol.mas_right).with.offset(kMarginHorizontal);
            make.size.mas_equalTo(CGSizeMake(100, 36));
        }];
        
        _consumeCode = [UILabel new];
        _consumeCode.font = kFontSize14;
        _consumeCode.textColor = KColorText666666;
        _consumeCode.text = @"消费码: ";
        [self.contentView addSubview:_consumeCode];
        [_consumeCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(middleLine.mas_bottom).with.offset(22);
            make.left.equalTo(self.mas_left).with.offset(kMarginHorizontal);
            make.size.mas_equalTo(CGSizeMake(200, 14));
        }];
        
        _consumeState = [UILabel new];
        _consumeState.font = kFontSize14;
        _consumeState.textColor = KColorText999999;
        _consumeState.text = @"未消费";
        _consumeState.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_consumeState];
        [_consumeState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(middleLine.mas_bottom).with.offset(22);
            make.right.equalTo(self.mas_right).with.offset(-KMarginLeft);
            make.size.mas_equalTo(CGSizeMake(80, 14));
        }];
        
        
        
    }
    return self;
}

- (UIButton *)refundBtn {
    if (_refundBtn == nil) {
        _refundBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _refundBtn.backgroundColor = [UIColor whiteColor];
        [_refundBtn setTitle:@"退款" forState:UIControlStateNormal];
        _refundBtn.layer.borderWidth = 1;
        _refundBtn.layer.borderColor = KColorText5AC4F1.CGColor;
        [_refundBtn setTitleColor:KColorText5AC4F1 forState:UIControlStateNormal];
        _refundBtn.titleLabel.font = kFontSize15;
        _refundBtn.layer.cornerRadius = kRadius;
        _refundBtn.layer.masksToBounds = YES;
        [_refundBtn addTarget:self action:@selector(refund) forControlEvents:UIControlEventTouchUpInside];
    }

    return _refundBtn;
}

- (void)refund {

    if (_refundBlk) {
        _refundBlk();
    }
}

//- (void)evaluation {
//    if (_evaluationBlk) {
//        _evaluationBlk();
//    }
//}

@end
