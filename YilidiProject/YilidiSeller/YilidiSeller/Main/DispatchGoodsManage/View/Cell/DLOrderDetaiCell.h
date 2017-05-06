//
//  DLOrderDetaiCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJCAjustNumButton.h"
@class DLInvitationOrdetailsModel;
@interface DLOrderDetaiCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *count;

@property (nonatomic,strong)DLInvitationOrdetailsModel *model;

@property (weak, nonatomic) IBOutlet HJCAjustNumButton *addSubtractButton;

@end
