//
//  DLResetPassView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ResetPassViewBlcok)(void);
@interface DLResetPassView : UIView

@property (weak, nonatomic) IBOutlet UITextField *setPassWord;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPassWord;
@property (nonatomic,strong)ResetPassViewBlcok resetPassViewBlcok;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
