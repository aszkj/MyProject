//
//  DLLoginView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginBlock)(void);
typedef void(^CodeLoginBlock)(void);
typedef void(^ForgotPasswordBlock)(void);
@interface DLLoginView : UIView

@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;

@property (strong, nonatomic) IBOutlet UITextField *passWordField;

@property (nonatomic,strong)LoginBlock loginBlock;
@property (nonatomic,strong)CodeLoginBlock codeLoginBlock;
@property (nonatomic,strong)ForgotPasswordBlock forgotPasswordBlock;
@end
