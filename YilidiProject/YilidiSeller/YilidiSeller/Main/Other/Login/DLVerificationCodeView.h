//
//  DLVerificationCodeView.h
//  YilidiSeller
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VerificationCodeBlock)(void);
@interface DLVerificationCodeView : UIView

@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic,strong)VerificationCodeBlock verificationCodeBlock;

@end
