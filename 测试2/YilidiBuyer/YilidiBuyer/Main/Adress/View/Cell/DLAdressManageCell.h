//
//  DLAdressManageCell.h
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressBaseModel.h"
#import "ProjectRelativeConst.h"
#define kManageAdressCellHeight 100

@interface DLAdressManageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (nonatomic,copy)SelecteDefaultAdressBlock selectDefaultAdressBlock;
@property (nonatomic,copy)EditAdressBlcok editAdressBlock;
@property (nonatomic,copy)DeleteAdressBlock deleteAdressBlock;

@end

@interface DLAdressManageCell (setManageAdressCellData)

- (void)setManageAdressCellData:(AdressBaseModel *)addressListModel;

@end