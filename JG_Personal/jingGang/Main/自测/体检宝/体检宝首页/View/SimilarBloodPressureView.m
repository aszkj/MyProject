//
//  SimilarBloodPressureView.m
//  jingGang
//
//  Created by 张康健 on 15/8/1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SimilarBloodPressureView.h"
#import "GlobeObject.h"
#import "Util.h"

@interface SimilarBloodPressureView(){


    CGFloat _inputViewToTopEdge;//输入视图距离上面的距离
    CGFloat _keyBoardMoveDeta;//键盘弹起，输入视图往上移动的距离
    
    NSString *_alertLowTitle;
    NSString *_alertHighTitle;
    NSInteger   _lowMinValue;
    NSInteger   _lowMaxValue;
    NSInteger   _highMinValue;
    NSInteger   _highMaxValue;
    
}


@end


@implementation SimilarBloodPressureView

-(void)awakeFromNib{

    _inputViewToTopEdge =( 241.0 / iPhone6_Height ) *kScreenHeight;
    self.inputViewToTopEdgeConstraint.constant = -_inputViewToTopEdge-100;
    _keyBoardMoveDeta = _inputViewToTopEdge - 100;
    //键盘抬起通知
    [kNotification addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //键盘降下通知
    [kNotification addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


}


//键盘出现
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //键盘弹起，，肯定是其中一个成为了响应者，，为了防止这个方法多次调用
    if ([self.lowTextField isFirstResponder] || [self.highTextField isFirstResponder] ) {
        [UIView animateWithDuration:0.3 animations:^{
            self.inputViewToTopEdgeConstraint.constant = _keyBoardMoveDeta;
            [self layoutIfNeeded];
        }];
        
    }
}


-(void)beginAnimation{
    
    //    self.inputViewToTopEdgeConstraint.constant = -186;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.inputViewToTopEdgeConstraint.constant = _inputViewToTopEdge;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([self.lowTextField isFirstResponder] || [self.highTextField isFirstResponder]) {
        [self endEditing:YES];
    }else{
        [self endAnimation];
    }
    
}

-(void)endAnimation{
    
    [UIView animateWithDuration:0.6 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.inputViewToTopEdgeConstraint.constant = kScreenHeight + 20;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
        
    }];
    
}





//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    [UIView animateWithDuration:0.0 animations:^{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.inputViewToTopEdgeConstraint.constant = _inputViewToTopEdge;
            [self layoutIfNeeded];
        }];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}


- (IBAction)ensureInputAction:(id)sender {
    
    [self endEditing:YES];

    if ([self _validateInput]) {
        //回调
        if (self.lowAndHighBlock) {
            self.lowAndHighBlock(self.lowTextField.text,self.highTextField.text);
        }
        [self performSelector:@selector(endAnimation) withObject:nil afterDelay:0.3];

    }

}

-(BOOL)_validateInput{
    
    if (![Util validateInputStr:self.highTextField.text rangeFromBeginValue:_highMinValue endValue:_highMaxValue withAlertName:_alertHighTitle]) {
        self.highTextField.text = nil;
        return NO;
    }
    if (![Util validateInputStr:self.lowTextField.text rangeFromBeginValue:_lowMinValue endValue:_lowMaxValue withAlertName:_alertLowTitle]) {
        
        self.lowTextField.text = nil;
        return NO;
    }
    
    return YES;
}

-(void)setTestEditType:(TestEditType)testEditType{
    
    if (testEditType == BloodPressureEditType) {//血压
        self.highLabel.text = @"高压:";
        self.lowLabel.text = @"低压:";
        _highMinValue = 50;
        _highMaxValue = 250;
        _lowMinValue = 30;
        _lowMaxValue = 220;
        _alertLowTitle = @"低压";
        _alertHighTitle = @"高压";
    }else{
        self.highLabel.text = @"低频:";
        self.lowLabel.text = @"高频:";
        _lowMinValue = _highMinValue = 0;
        _lowMaxValue = _highMaxValue = 20000;
        _alertLowTitle = @"低频";
        _alertHighTitle = @"低频";
    }
    
    
    self.highTextField.placeholder = [NSString stringWithFormat:@"%ld到%ld以内的数字",_highMinValue,_highMaxValue];
     self.lowTextField.placeholder = [NSString stringWithFormat:@"%ld到%ld以内的数字",_lowMinValue,_lowMaxValue];
}



- (void)dealloc
{
    [kNotification removeObserver:self];
    
}



@end
