//
//  DLShipAdressCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShipAdressCell.h"

@implementation DLShipAdressCell

- (void)awakeFromNib {
    if (kScreenWidth == iPhone5_width) {
        self.adressLabel.font = kSystemFontSize(10);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
@implementation DLShipAdressCell (setCellModel)

- (void)setCellModel:(AdressModel *)model {
    
    self.userNameLabel.text = model.consigneePersonName;
    self.phoneNumberLabel.text = model.consigneePersonPhoneNumber;
    self.adressLabel.text = model.consigneePersonAdress;

}

@end