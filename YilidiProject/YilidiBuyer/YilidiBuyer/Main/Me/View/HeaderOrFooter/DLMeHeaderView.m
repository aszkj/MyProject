//
//  DLMeHeaderView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMeHeaderView.h"


@implementation DLMeHeaderView
- (void)awakeFromNib {
    [super awakeFromNib];
    

}

- (id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }

    return self;
}
- (IBAction)myOrderClick:(id)sender {
    emptyBlock(self.myorderBlock);
}

- (IBAction)paymentClick:(id)sender {
    emptyBlock(self.paymentBlock);
}

- (IBAction)shouhuoClick:(id)sender {
    emptyBlock(self.shouhuoBlock);
}

- (IBAction)completeClick:(id)sender {
    emptyBlock(self.completeBlock);
}
- (IBAction)ArefundClick:(id)sender {
    emptyBlock(self.arefundBlock);
}

- (IBAction)walletClick:(id)sender {
     emptyBlock(self.myWalletBlock);
}


- (IBAction)balanceClick:(id)sender {
    emptyBlock(self.balanceBlock);
}
    
- (IBAction)limiClick:(id)sender {
    emptyBlock(self.limiBlock);
}
- (IBAction)couponsClick:(id)sender {
    emptyBlock(self.couponsBlock);
}

- (IBAction)vouchersClick:(id)sender {
    emptyBlock(self.vouchersBlock);
}


@end
