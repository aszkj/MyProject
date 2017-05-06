//
//  JGCashALiView.m
//  jingGang
//
//  Created by dengxf on 16/1/8.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGCashALiView.h"
#import "UITextField+Blocks.h"

@implementation JGCashALiView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.userNameTextField.shouldReturnBlock = ^(UITextField *textField){
            [self endEditing:YES];
            return YES;
        };
        self.aliAccountTextField.shouldReturnBlock = ^(UITextField *textField){
            [self endEditing:YES];
            return YES;
        };
    }
    return self;
}

@end
