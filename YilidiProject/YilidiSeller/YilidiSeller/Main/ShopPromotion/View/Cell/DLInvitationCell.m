//
//  DLInvitationCell.m
//  YilidiSeller
//
//  Created by yld on 16/6/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvitationCell.h"
#import "DLInvitationModel.H"
@implementation DLInvitationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(DLInvitationModel *)model {

    //字符串的替换
    self.phoneLabel.text = [NSString stringWithFormat:@"%@",model.userMaskMobile];
    self.nameLabel.text  = [NSString stringWithFormat:@"%@",model.username];
    switch ([model.vipFlag integerValue]) {
        case 0:
            self.vipLabel.hidden=YES;
            break;
        case 1:
            self.vipLabel.text=@"铂金会员";
            break;
        case 2:
            self.vipLabel.text=@"体验会员";
            break;
            
        default:
            break;
    }
    
    
}
@end
