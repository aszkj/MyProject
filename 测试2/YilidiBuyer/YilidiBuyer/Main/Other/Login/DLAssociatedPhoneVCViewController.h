//
//  DLAssociatedPhoneVCViewController.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/13.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"
#import "JKCountDownButton.h"
@interface DLAssociatedPhoneVCViewController : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *codeField;
@property (strong, nonatomic) IBOutlet JKCountDownButton *getCodeBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UITextField *passWordField;

@end
