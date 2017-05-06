//
//  DLAdressManageCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAdressManageCell.h"
#import "SUIMacro.h"

@implementation DLAdressManageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectedDefaultAdressAction:(id)sender {
    UIButton *selectedButton = (UIButton *)sender;
    if (self.selectDefaultAdressBlock) {
        self.selectDefaultAdressBlock(selectedButton);
    }
}

- (IBAction)editDefaultAdressAction:(id)sender {
    if (self.editAdressBlock) {
        self.editAdressBlock();
    }
}

- (IBAction)deleteAdressAction:(id)sender {
    if (self.deleteAdressBlock) {
        self.deleteAdressBlock();
    }
}

@end

@implementation DLAdressManageCell (setManageAdressCellData)

- (void)setManageAdressCellData:(DLAdressListModel *)addressListModel {

    self.userNameLabel.text = gFormat(@"姓名:%@",addressListModel.consigneePersonName);
    self.phoneNumberLabel.text = gFormat(@"电话:%@",addressListModel.consigneePersonPhoneNumber);
    self.addressLabel.text = addressListModel.consigneePersonAdress;
    self.selectedButton.selected = addressListModel.isDefaultConsigneeAdress.integerValue;

}

@end
