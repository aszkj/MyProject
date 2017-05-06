//
//  DefaultAddressTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "DefaultAddressTableViewCell.h"
#import "Masonry.h"
#import "ShopCenterListReformer.h"

@interface DefaultAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *zuobiaoMark;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *rightMark;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation DefaultAddressTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content

- (void)changeShopUserAddress:(ShopUserAddress *)address {
    [self setUsrName:address.trueName addressDetail:address.areaInfo phoneNumber:address.mobile];
}

- (void)changeAddress:(NSDictionary *)addressDic
{
    [self setUsrName:addressDic[addressKeyUsrName] addressDetail:addressDic[addressKeyAddressDetail] phoneNumber:addressDic[addressKeyUsrPhone]];
}

- (void)setUsrName:(NSString *)name addressDetail:(NSString *)addressDetail phoneNumber:(NSString *)phoneNumber {
    self.name.text = [NSString stringWithFormat:@"收货人: %@",name == nil? @"":name];
    self.phoneNumber.text = phoneNumber == nil? @"":phoneNumber;
    self.address.text = [NSString stringWithFormat:@"收货地址:%@",addressDetail == nil? @"":addressDetail];
}

#pragma mark - event response


#pragma mark - set UI init

- (void)setAppearence
{
    
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(-1);
        make.right.equalTo(superView).with.offset(1);
        make.bottom.equalTo(superView).with.offset(1);
        make.height.equalTo(@(10+2));
    }];
    
    superView = self.backView;
    [self.zuobiaoMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.size.mas_equalTo(self.zuobiaoMark.image.size);
        make.left.equalTo(superView).with.offset(12);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(12);
        make.left.equalTo(self.zuobiaoMark.mas_right).with.offset(8);
        make.right.equalTo(superView.mas_centerX).with.offset(25);
        make.height.mas_equalTo(21);
    }];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name);
        make.right.equalTo(self.rightMark.mas_left).with.offset(-6);
        make.height.mas_equalTo(21);
    }];
    [self.rightMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.right.equalTo(superView).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(7, 17));
    }];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView).with.offset(-12);
        make.left.equalTo(self.name);
        make.right.equalTo(self.phoneNumber);
        make.top.equalTo(self.name.mas_bottom).with.offset(8);

    }];
}

@end
