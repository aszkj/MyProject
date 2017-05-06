//
//  DLAdressListCell.h
//  YilidiBuyer
//
//  Created by yld on 16/4/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLAdressListModel.h"
#import "ProjectRelativeConst.h"
#define kAdressListCellHeight 68
@interface DLAdressListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (nonatomic,copy)SelecteDefaultAdressBlock selectDefaultAdressBlock;


@end

@interface DLAdressListCell (setCellData)

- (void)setAdressCellData:(DLAdressListModel *)addressListModel;

@end





