//
//  DLInvitationCell.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLShareModel.h"
@interface DLInvitationCell : UITableViewCell

@property (nonatomic,strong)DLShareModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *nounLabel;

@end
