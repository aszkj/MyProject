//
//  CollectionGoodsCellTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CollectionGoodsCellTableViewCell.h"
#import "GlobeObject.h"
#import "Masonry.h"

@interface CollectionGoodsCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *optionBtn;

@end

@implementation CollectionGoodsCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

- (void)setAppearence
{
    self.goodsDescription.textColor = UIColorFromRGB(0x666666);
    self.goodsPrice.textColor = UIColorFromRGB(0x59C4F0);
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    UIEdgeInsets padding = UIEdgeInsetsMake(11, 0, 0, 0);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).with.insets(padding);
    }];
    
    superView = self.backView;
    [self.goodsLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(77, 77));
        make.centerY.equalTo(superView);
        make.top.greaterThanOrEqualTo(superView).with.offset(8);
        make.left.equalTo(superView).with.offset(10.5);
    }];
    [self.goodsDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsLogo.mas_right).with.offset(4);
        make.top.equalTo(self.goodsLogo);
        make.right.lessThanOrEqualTo(self.optionBtn.mas_left);
    }];
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodsLogo).with.offset(-4);
        make.right.equalTo(self.phoneVIP.mas_left).with.offset(-4);
        make.left.equalTo(self.goodsDescription);
    }];
    [self.phoneVIP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16.5);
        make.width.equalTo(@60);
        make.centerY.equalTo(self.goodsPrice);
        make.right.equalTo(self.optionBtn.mas_left).with.offset(-8);
    }];
    [self.optionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.bottom.equalTo(self.goodsPrice);
        make.right.equalTo(superView).with.offset(-8);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)optionAction:(id)sender {
    if (self.optionBlock) {
        self.optionBlock(self.indexPath);
    }
}

@end
