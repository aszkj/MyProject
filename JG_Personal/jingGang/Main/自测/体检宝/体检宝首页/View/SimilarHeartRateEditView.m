//
//  SimilarHeartRateEditView.m
//  jingGang
//
//  Created by 张康健 on 15/8/1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SimilarHeartRateEditView.h"
#import "Util.h"
#import "GlobeObject.h"

@interface SimilarHeartRateEditView(){

    CGFloat _inputViewToTopEdge;//输入视图距离上面的距离
    
    CGFloat _keyBoardMoveDeta;//键盘弹起，输入视图往上移动的距离
    
    NSString *_alertTitle;
    CGFloat   _minValue;
    CGFloat   _maxValue;

}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeLabelWidthConstraint;

@end

@implementation SimilarHeartRateEditView

-(void)awakeFromNib{

    [self insertSubview:self.bgView atIndex:0];
    
    _inputViewToTopEdge =( 209.0 / iPhone6_Height ) *kScreenHeight;
    self.inputViewToTopEdgeConstraint.constant = -_inputViewToTopEdge;
    _keyBoardMoveDeta = _inputViewToTopEdge - 70;
    //键盘抬起通知
    [kNotification addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //键盘降下通知
    [kNotification addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}


- (IBAction)ensureInputAction:(id)sender {

    [self endEditing:YES];
    if ([self _validateInput]) {
        //回调
        if (self.editEndBlock) {
            self.editEndBlock(self.editTextField.text);
        }
        [self performSelector:@selector(endAnimation) withObject:nil afterDelay:0.3];
    }
}

-(BOOL)_validateInput{

    if (![Util validateInputStr:self.editTextField.text rangeFromBeginValue:_minValue endValue:_maxValue withAlertName:_alertTitle]) {
        
        self.editTextField.text = nil;
        return NO;
    }

    return YES;
}

-(void)setTestEditType:(TestEditType)testEditType{

    
        switch (testEditType) {
        case EyeSightEditType://视力
            self.editTypeLabel.text = @"视力值:";
//            self.editTextField.placeholder = @"3.0-5.2以内的数字";
            _minValue = 3.0;
            _maxValue = 5.2;
            _alertTitle = @"视力";
            self.editTextField.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case HeatRateEditType://心率
            self.editTypeLabel.text = @"心率值:";
            _alertTitle = @"心率";
            _minValue = 30;
            _maxValue = 220;
//            self.editTextField.placeholder = @"30-220以内的数字";
            break;
        case BloodOxenEditType://血氧
            self.editTypeLabel.text = @"血氧值:";
//            self.editTextField.placeholder = @"60-100以内的数字";
            _minValue = 60;
            _maxValue = 100;
            _alertTitle = @"血氧";
            //显示百分号
            [self viewWithTag:1].hidden = NO;
            break;
        case LungCapacityEditType://肺活量
            self.editTypeLabel.text = @"肺活量值:";
//            self.editTextField.placeholder = @"500-20000以内的数字";
            _minValue = 500;
            _maxValue = 20000;
            _alertTitle = @"肺活量";
            break;
            
        default:
            break;
    }
    self.editTextField.placeholder = [NSString stringWithFormat:@"%d到%d以内的数字",(int)_minValue,(int)_maxValue];
    if (testEditType == EyeSightEditType) {
        self.editTextField.placeholder = @"3.0到5.2以内的数字";
    }
    if (testEditType == LungCapacityEditType) {
        self.editTextField.placeholder = @"500到20000";
        self.typeLabelWidthConstraint.constant = 75;
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

    if ([self.editTextField isFirstResponder]) {
        
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
        self.hidden = YES;
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];

    }];
    
}


//键盘出现
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //键盘弹起，，肯定是其中一个成为了响应者，，为了防止这个方法多次调用
    if ([self.editTextField isFirstResponder]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.inputViewToTopEdgeConstraint.constant = _keyBoardMoveDeta;
            [self layoutIfNeeded];
        }];
        
    }
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
//点击Controller的返回键调用的方法
- (void)backButtonClickRemoveEditView
{
    self.hidden = YES;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}


- (void)dealloc
{
    [kNotification removeObserver:self];

}





@end
