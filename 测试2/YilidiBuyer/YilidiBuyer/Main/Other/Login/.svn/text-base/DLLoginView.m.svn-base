//
//  DLLoginView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLLoginView.h"
#import "ProjectRelativEmerator.h"
#import "GlobleConst.h"
@interface DLLoginView()<UITextFieldDelegate>
{

    BOOL endBtn;
}
@property (nonatomic, assign)TextEditorStatus  editorStatus;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation DLLoginView

- (void)awakeFromNib{

    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindAction:) name:@"loginValue" object:nil];
    self.phoneNumber.delegate = self;
    self.passWordField.delegate = self;
    [_phoneNumber addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passWordField addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

#pragma mark -------------------Private---------------------
- (void)_textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneNumber) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.passWordField) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}

- (IBAction)secureTextClick:(UIButton *)sender {
    if ((sender.selected =! sender.selected)) {
        self.passWordField.secureTextEntry = NO;
    }else{
        self.passWordField.secureTextEntry = YES;
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    NSString *text = nil;
    if (textField==_phoneNumber) {
        _editorStatus=TextEditorPhoneFieldTag;
        //实时监听点击清除按钮时候文本内容是否为空，为空按钮颜色置灰
        [_phoneNumber addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
        if (strLength >11){
            return NO;
        }
        //如果string为空，表示删除
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
        }else{
            text = [textField.text substringToIndex:range.location];
        }
    }else if (textField==_passWordField){
        _editorStatus=TextEditorPassWordFieldTag;
        [_passWordField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
        
        if (strLength >16){
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
                if (_passWordField.text.length>5) {
                    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_loginButton setBackgroundColor:KSelectedBgColor];
                    _loginButton.enabled = YES;
                    
                }
                return YES;
            }
        }else if (text.length < 11){
            [_loginButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _loginButton.enabled = NO;
            return NO;
        }
    }else if (_editorStatus==TextEditorPassWordFieldTag){
        if (text.length>5&&_phoneNumber.text.length == 11) {
            [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:KSelectedBgColor];
            _loginButton.enabled = YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_loginButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _loginButton.enabled = NO;
            return NO;
        }
        
    }
    return NO;
    
}


#pragma mark ------------------------Notification-------------------------
//监听每个输入框的文本为空
- (void)FindAction:(NSNotification *)notification {
    
    UITextField *field = notification.object;
    if (field.text.length==0) {
        endBtn = NO;
        if (_phoneNumber.text.length==0||_passWordField.text.length==0) {
            
            [_loginButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _loginButton.enabled = NO;
            
        }else {
            
            [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginButton setBackgroundColor:KSelectedBgColor];
            _loginButton.enabled = YES;
        }
    }
}

-(void)valueChanged:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginValue" object:textField];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (IBAction)codeLoginClick:(id)sender {
     emptyBlock(self.codeLoginBlock);
    
}

- (IBAction)forgotPassword:(id)sender {
     emptyBlock(self.forgotPasswordBlock);
}

- (IBAction)loginButtonClick:(id)sender {
     emptyBlock(self.loginBlock);
}

@end
