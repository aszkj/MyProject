//
//  XKWithDrawCashView.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKWithDrawCashView.h"

@implementation XKWithDrawCashView


- (IBAction)updateDrawCashPasswdAction:(id)sender {
    
    if (self.drawCashUpdatePasswdSureBlock) {
        self.drawCashUpdatePasswdSureBlock(self.phoneNumTextField.text,self.veryCodeTextField.text,self.newpasswdTextField.text,self.againPasswdTextField.text);
    }
}


- (IBAction)sendVeryCodeAction:(id)sender {
    
    if (self.drawCashSendVeryCodeBlock) {
        self.drawCashSendVeryCodeBlock(self.phoneNumTextField.text);
    }
}



@end
