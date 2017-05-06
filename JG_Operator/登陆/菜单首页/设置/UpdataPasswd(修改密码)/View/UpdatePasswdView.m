//
//  UpdatePasswdView.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "UpdatePasswdView.h"

@implementation UpdatePasswdView


- (IBAction)makeSureAction:(id)sender {
    
    if (self.updatePasswdSureBlock) {
        self.updatePasswdSureBlock(self.oldPasswdTextField.text,self.newpasswdTextFiled.text,self.againNewPasswdTextField.text);
    }
}


@end
