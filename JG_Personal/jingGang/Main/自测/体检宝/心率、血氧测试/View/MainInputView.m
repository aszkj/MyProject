//
//  MainInputView.m
//  jingGang
//
//  Created by 张康健 on 15/7/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "MainInputView.h"
#import "GlobeObject.h"
#import "Util.h"

@implementation MainInputView

-(void)awakeFromNib{
    
//    self.inputBgView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.inputBgView.layer.borderWidth = 2.0f;
    //键盘抬起通知
    [kNotification addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //键盘降下通知
    [kNotification addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)setIsOxen:(BOOL)isOxen{
    
    if (isOxen) {
        UILabel *perCentLabel = (UILabel *)[self viewWithTag:1];
        perCentLabel.hidden = NO;
        _toplabel.text = @"请输入您的血氧值";
        _typeLabel.text = @"血氧值:";
        _middleEdgeConstraint.constant = 5;
        _textField.placeholder = @"60-100的数字";
    }
    _isOxen = isOxen;
}


- (IBAction)ensureInput:(id)sender {
    
    [self endEditing:YES];
    NSString *alertTitle = self.isOxen ? @"血氧":@"心率";
    NSInteger minValue = 30;
    NSInteger maxValue = 220;
    if (self.isOxen) {
        minValue = 60;
        maxValue = 100;
    }
    
    //验证输入的合法性
    if ([Util validateInputStr:self.textField.text rangeFromBeginValue:minValue endValue:maxValue withAlertName:alertTitle]) {//合理输入才进行其他操作
        if (self.inputResultBlock) {
            self.inputResultBlock([self.textField.text integerValue]);
        }
    }
}

#pragma mark keyboard event
//键盘出现
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //键盘弹起，，肯定是其中一个成为了响应者，，为了防止这个方法多次调用
    if ([self.textField isFirstResponder]) {
        
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
