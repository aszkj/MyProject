//
//  DLAdressListCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLAdressListCell.h"
#import "UIButton+Design.h"

@implementation DLAdressListCell

- (void)awakeFromNib {
    // Initialization code
    [self.editButton setEnlargeEdge:10];
    if (kScreenWidth == iPhone5_width) {
        self.adressLabel.font = kSystemFontSize(12.0);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editAdressAction:(id)sender {
    emptyBlock(self.editAdressBlock);
}

- (IBAction)setSelectedAction:(id)sender {
    UIButton *selectedButton = (UIButton *)sender;
    if (self.selectDefaultAdressBlock) {
        self.selectDefaultAdressBlock(selectedButton);
    }
}

@end

@implementation DLAdressListCell (setCellData)

- (void)setAdressCellData:(AdressModel *)addressListModel {
    self.nameLabel.text = [NSString stringWithFormat:@"%@",addressListModel.consigneePersonName];
    self.phoneNumberLabel.text = [NSString stringWithFormat:@"%@",addressListModel.consigneePersonPhoneNumber];
//    self.adressLabel.text = addressListModel.consigneePersonalDetailAdress;
    self.adressLabel.text = addressListModel.displayAdress;

}

- (void)configureUIByTheShipRangeStatus:(BOOL)inTheShipRange{
    
    if (inTheShipRange==NO) {

        self.nameLabel.textColor = self.phoneNumberLabel.textColor =  self.adressLabel.textColor = KWeakTextColor;
    }
    
    self.intheShipRangeButton.hidden = inTheShipRange;
}


@end
