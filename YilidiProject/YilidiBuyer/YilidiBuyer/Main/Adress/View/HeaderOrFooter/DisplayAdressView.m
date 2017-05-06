//
//  DisplayAdressView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DisplayAdressView.h"
#import "AdressModel.h"
@interface DisplayAdressView()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end

@implementation DisplayAdressView

- (IBAction)clickAdressAction:(id)sender {
    emptyBlock(self.clickAdressBlock);
}

- (void)_configureUIByModel {
    
    self.userNameLabel.text = self.adressModel.consigneePersonName;
    self.phoneNumberLabel.text = self.adressModel.consigneePersonPhoneNumber;
    self.adressLabel.text = self.adressModel.consigneePersonalDetailAdress;
}

- (void)setAdressModel:(AdressModel *)adressModel {
    _adressModel = adressModel;
    [self _configureUIByModel];
}

@end
