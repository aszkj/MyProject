//
//  DLAdressListCell.h
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressModel.h"
#import "ProjectRelativeConst.h"
#define kAdressListCellHeight 81
@interface DLAdressListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (nonatomic,copy)SelecteDefaultAdressBlock selectDefaultAdressBlock;
@property (nonatomic,copy)EditAdressBlcok editAdressBlock;
@property (weak, nonatomic) IBOutlet UIButton *intheShipRangeButton;


@end

@interface DLAdressListCell (setCellData)

- (void)setAdressCellData:(AdressModel *)addressListModel;

- (void)configureUIByTheShipRangeStatus:(BOOL)inTheShipRange;

@end





