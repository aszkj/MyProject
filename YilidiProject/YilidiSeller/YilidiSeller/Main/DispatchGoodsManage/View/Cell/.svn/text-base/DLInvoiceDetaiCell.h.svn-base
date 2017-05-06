//
//  DLInvoiceDetaiCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLInvitationOrdetailsModel.h"
#import "AddAndSubtractButton.h"
typedef void (^InvitationBlock) (DLInvitationOrdetailsModel *model);



@interface DLInvoiceDetaiCell : UITableViewCell

@property (nonatomic,assign)BOOL  ishidden;

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *count;

@property (nonatomic,strong)DLInvitationOrdetailsModel *model;

@property (weak, nonatomic) IBOutlet AddAndSubtractButton *addSubtractButton;
@property (nonatomic,strong)InvitationBlock invitationBlock;
@property (strong, nonatomic) IBOutlet UILabel *closedCount;
@property (strong, nonatomic) IBOutlet UILabel *receivingCount;

@end
