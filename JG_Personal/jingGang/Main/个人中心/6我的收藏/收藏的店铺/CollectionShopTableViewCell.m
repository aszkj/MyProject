//
//  CollectionShopTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CollectionShopTableViewCell.h"
#import "Masonry.h"

@interface CollectionShopTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation CollectionShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

- (void)setAppearence
{
    self.accessBtn.layer.cornerRadius = 5.0;
    self.cancelBtn.layer.cornerRadius = 5.0;
    self.cancelBtn.layer.borderWidth = 1.0;
    self.cancelBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    [self.accessBtn setTitle:@" 进入店铺 " forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@" 取消收藏 " forState:UIControlStateNormal];
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).with.insets(padding);
    }];
    
    superView = self.backView;
    [self.shopLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.5, 67.5));
        make.centerY.equalTo(superView);
        make.left.equalTo(superView).with.offset(10.5);
        make.top.greaterThanOrEqualTo(superView).with.offset(14);
    }];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopLogo);
        make.left.equalTo(self.shopLogo.mas_right).with.offset(4);
    }];
    [self.shopType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(92.5,16.5));
        make.top.equalTo(self.shopName.mas_bottom).with.offset(2);
        make.left.equalTo(self.shopName);
    }];
    [self.accessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopLogo);
        make.right.equalTo(superView).with.offset(-20);
        make.left.greaterThanOrEqualTo(self.shopName.mas_right).with.offset(4);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shopLogo);
        make.left.equalTo(self.accessBtn);
        make.right.equalTo(self.accessBtn);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)accessAction:(id)sender {
    if (self.accessShop) {
        self.accessShop(self.indexPath);
    }
}

- (IBAction)cancelAction:(id)sender {
    if (self.cancelShop) {
        self.cancelShop(self.indexPath);
    }

}

@end
