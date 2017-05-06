//
//  DLBindingPhoneVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/21.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLBindingPhoneVC.h"
#import "GlobleConst.h"
@interface DLBindingPhoneVC ()

@end

@implementation DLBindingPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.pageTitle = @"手机号绑定";
}

- (void)_init{
    
    
    [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindAction:) name:@"CodeLoginValue" object:nil];
}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)getVerification {
    [self showLoadingHub];
    NSDictionary *requestParam = @{@"mobile":self.phoneField.text,
                                   @"type":KTypemodifyPhone
                                   };
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_VerificationCode block:^(NSDictionary *result, NSError *error) {
        if (error.code==1) {
            
            [_getCodeButton startWithSecond:[result[EntityKey][@"remainClock"]intValue]];
        }
        
        [weak_self hideLoadingHub];
        
    }];
}

#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)countDownCode:(JKCountDownButton *)sender {
    if (!endBtn) {
        [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    [sender setTitleColor:KWeakTextColor forState:UIControlStateNormal];
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    
    [self getVerification];
    
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"(%d)重新获取",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        [sender setTitleColor:KCOLOR_PROJECT_RED forState:UIControlStateNormal];
        return @"重新获取";
        
    }];
    
    
}


- (IBAction)bindingBtnClick:(id)sender {
    
    if (_phoneField.text.length==0) {
        
        [Util ShowAlertWithOnlyMessage:@"请输入手机号"];
        return;
    }
    if (_codeField.text.length==0){
        
        [Util ShowAlertWithOnlyMessage:@"请输入验证码"];
        return;
        
    }
    //    else{
    //        if (![Util   isValidateMobile:_phoneField.text]) {
    //            [self showSimplyAlertWithTitle:@"提示" message:@"手机号格式错误" sureAction:^(UIAlertAction *action) {
    //
    //            }];
    //        }else{
    
    
    //        }
    
    //    }
    
}



#pragma mark ------------------------Delegate-----------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    NSString *text = nil;
    if (textField==_phoneField) {
        _editorStatus=TextEditorPhoneFieldTag;
        //实时监听点击清除按钮时候文本内容是否为空，为空按钮颜色置灰
        [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
        if (strLength >11){
            return NO;
        }
        //如果string为空，表示删除
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
        }else{
            text = [textField.text substringToIndex:range.location];
        }
    }else if (textField==_codeField){
        _editorStatus=TextEditorCodeFieldTag;
        [_codeField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        if (strLength >6){
            return NO;
        }
        //如果string为空，表示删除
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
        }else{
            text = [textField.text substringToIndex:range.location];
        }
        
    }
    
    endBtn = [self isCheckContent:text];
    return YES;
    
}


-(BOOL)isCheckContent:(NSString *)text{
    
    if (_editorStatus==TextEditorPhoneFieldTag) {
        if (text.length == 11) {
            BOOL phone = [Util   isValidateMobile:text];
            if (phone) {
                
                _editorStatus=TextEditorDefaultStatus;
                [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
                if (_codeField.text.length==6) {
                    [_bindingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_bindingBtn setBackgroundColor:KSelectedBgColor];
                    _bindingBtn.enabled = YES;
                }
                return YES;
            }
        }else if (text.length < 11){
            
            [_bindingBtn setTitleColor:KWeakTextColor forState:UIControlStateNormal];
            [_bindingBtn setBackgroundColor:KLineColor];
            _bindingBtn.enabled = NO;
            return NO;
        }
    }else if (_editorStatus==TextEditorCodeFieldTag){
        if (_phoneField.text.length == 11&&text.length==6) {
            
            [_bindingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_bindingBtn setBackgroundColor:KSelectedBgColor];
            _bindingBtn.enabled = YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_bindingBtn setTitleColor:KWeakTextColor forState:UIControlStateNormal];
            [_bindingBtn setBackgroundColor:KLineColor];
            _bindingBtn.enabled = NO;
            return NO;
        }
        
        
    }
    return NO;
    
}


#pragma mark ------------------------Notification-------------------------
- (void)FindAction:(NSNotification *)notification {
    
    UITextField *field = notification.object;
    if (field.text.length==0) {
        endBtn = NO;
        if (_phoneField.text.length==0||_codeField.text.length==0) {
            [_bindingBtn setTitleColor:KWeakTextColor forState:UIControlStateNormal];
            [_bindingBtn setBackgroundColor:KLineColor];
            _bindingBtn.enabled = NO;
        }else {
            [_bindingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_bindingBtn setBackgroundColor:KSelectedBgColor];
            _bindingBtn.enabled = YES;
            
        }
    }
}
-(void)valueChanged:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CodeLoginValue" object:textField];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark ------------------------Getter / Setter----------------------




@end
