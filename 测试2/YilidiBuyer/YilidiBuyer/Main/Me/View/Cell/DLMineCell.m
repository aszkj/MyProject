//
//  DLMineCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMineCell.h"

@implementation DLMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (IBAction)shippingAddressClick:(id)sender {
    emptyBlock(self.adressBlock);
}

- (IBAction)changePassword:(id)sender {
    emptyBlock(self.changePasswordBlock);
}
- (IBAction)mallClick:(id)sender {
    emptyBlock(self.mallBlock);
    
}
- (IBAction)fanZoneClick:(id)sender {
    emptyBlock(self.fanZoneBlock);
    
}
- (IBAction)shareClick:(id)sender {
    emptyBlock(self.shareBlock);
}
- (IBAction)commonProblemsClick:(id)sender {
    emptyBlock(self.commonProblemsBlock);
}
- (IBAction)aboutUsClick:(id)sender {
    emptyBlock(self.aboutUsBlock);
    
}

- (IBAction)feedBackClick:(id)sender {
    emptyBlock(self.feedBackBlock);
}



@end





