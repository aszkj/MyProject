//
//  DLAdressListCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAdressListCell.h"

@implementation DLAdressListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)setSelectedAction:(id)sender {
    UIButton *selectedButton = (UIButton *)sender;
    if (self.selectDefaultAdressBlock) {
        self.selectDefaultAdressBlock(selectedButton);
    }
}

@end

@implementation DLAdressListCell (setCellData)

- (void)setAdressCellData:(DLAdressListModel *)addressListModel {
    self.nameLabel.text = [NSString stringWithFormat:@"姓名:%@",addressListModel.consigneePersonName];
    self.phoneNumberLabel.text = [NSString stringWithFormat:@"电话:%@",addressListModel.consigneePersonPhoneNumber];
    self.adressLabel.text = addressListModel.consigneePersonAdress;
    self.selectButton.selected = addressListModel.isDefaultConsigneeAdress.integerValue;
}

@end
