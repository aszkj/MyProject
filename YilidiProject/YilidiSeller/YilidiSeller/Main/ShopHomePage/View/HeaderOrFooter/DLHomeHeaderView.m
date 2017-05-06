//
//  DLHomeHeaderView.m
//  YilidiSeller
//
//  Created by yld on 16/6/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeHeaderView.h"

@implementation DLHomeHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)orderClick:(id)sender {
    emptyBlock(self.orderBlock);
}
- (IBAction)todayInvitationClick:(id)sender {
    emptyBlock(self.invitationBlock);
}

@end
