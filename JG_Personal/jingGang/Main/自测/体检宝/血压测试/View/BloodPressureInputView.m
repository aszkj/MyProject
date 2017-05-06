//
//  BloodPressureInputView.m
//  jingGang
//
//  Created by 张康健 on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BloodPressureInputView.h"
#import "GlobeObject.h"
#import "Util.h"

#import "WSJBloodPressureViewController.h"//结果界面

@implementation BloodPressureInputView

-(void)awakeFromNib{
    
    //键盘抬起通知
    [kNotification addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //键盘降下通知
    [kNotification addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


- (IBAction)ensureInput:(id)sender {
    
    [self endEditing:YES];
    
    //验证输入合法性
    if ([self _validateInput]) {
        NSInteger lowPressure = [self.lowPressureTextField.text integerValue];
        NSInteger highPressure = [self.hightPressureTextFiled.text integerValue];
        if (self.bloodPressureInputResultBlock) {
            self.bloodPressureInputResultBlock(lowPressure,highPressure);
        }
    

    }
}

-(BOOL)_validateInput{
    
    if (![Util validateInputStr:self.hightPressureTextFiled.text rangeFromBeginValue:50 endValue:250 withAlertName:@"高压"]) {
        return NO;
    }
    if (![Util validateInputStr:self.lowPressureTextField.text rangeFromBeginValue:30 endValue:220 withAlertName:@"低压"]) {
        return NO;
    }

    return YES;
}

#pragma mark keyboard event
//键盘出现
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //键盘弹起，，肯定是其中一个成为了响应者，，为了防止这个方法多次调用
    if ([self.hightPressureTextFiled isFirstResponder] || [self.lowPressureTextField isFirstResponder]) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.topViewToTopConstraint.constant = -50;
            self.topView.hidden = YES;
            [self layoutIfNeeded];
        }];
    }
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    [UIView animateWithDuration:0.0 animations:^{
        self.topViewToTopConstraint.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.topView.hidden = NO;
    }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    
}

- (void)dealloc
{
    [kNotification removeObserver:self];
}

@end
