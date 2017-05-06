//
//  DLFindPasswordVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLFindPasswordVC.h"
#import "DLResetPassView.h"
#import "JKCountDownButton.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "GlobleConst.h"
@interface DLFindPasswordVC ()<UITextFieldDelegate>
{

    BOOL endBtn;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (nonatomic,strong)DLResetPassView *resetPassView;
@property (weak, nonatomic) IBOutlet UIButton *validationButton;

@property (weak, nonatomic) IBOutlet JKCountDownButton *getCodeButton;

@end

@implementation DLFindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"忘记密码";
    [self _init];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------------------------Init---------------------------------
- (void)_init{

    [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(FindAction:) name:@"FindPasswordValue" object:nil];
}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_submitDataSource {
//    if (self.getCodeButton.enabled!=NO) {
//        [Util ShowAlertWithOnlyMessage:@"请先获取验证码"];
//        return;
//    }
    
    
    NSDictionary *dic = @{@"mobile":self.phoneField.text,@"code":self.codeField.text,@"type":KTypeForgotPassword};
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_VerfivationCheck block:^(NSDictionary *resultDic, NSError *error) {
        JLog(@"resultDic%@",resultDic[EntityKey]);
        if (error.code==1) {
         
            [self.view addSubview:self.resetPassView];
        }
        
    }];
    
    
    
}

- (void)_postData {
    
    
    if (_resetPassView.setPassWord.text.length==0) {
        
        [self showSimplyAlertWithTitle:@"提示" message:@"请输入新密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    if (_resetPassView.ConfirmPassWord.text.length==0) {
        
        [self showSimplyAlertWithTitle:@"提示" message:@"请再次输入新密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    if (![_resetPassView.setPassWord.text isEqualToString:_resetPassView.ConfirmPassWord.text]){
        [self showSimplyAlertWithTitle:@"提示" message:@"两次密码输入不一致" sureAction:^(UIAlertAction *action) {
            
        }];
        
        return;
    }
    
    if (![Util isNull:_resetPassView.setPassWord.text]) {
        
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含空格"];
        return;
    }
    
    if (![Util validateNickname:_resetPassView.setPassWord.text]) {
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含特殊字符"];
        return;
    }
    
    if (![Util checkPassWord:_resetPassView.setPassWord.text]) {
        [Util ShowAlertWithOnlyMessage:@"密码由6-16位字母、数字组成"];
        return;
    }

    
    NSDictionary *parameters = @{@"password":_resetPassView.ConfirmPassWord.text};
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_ForgotPassword block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code==1) {
            [self hideHubForText:@"修改成功"];
            
            [self performSelector:@selector(_goback) withObject:self afterDelay:1];
            
        }else{
            
            [self hideLoadingHub];
        }
        
    }];
    

}
-(void)_goback {
[self goBack];
}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

- (IBAction)countDownCode:(JKCountDownButton *)sender {
    
    if (_phoneField.text.length<11) {
      
        [Util ShowAlertWithOnlyMessage:@"手机号格式错误"];
        return;
    }
    [sender setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    
     [self getVerification];
    
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"(%d)重新获取",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        [countDownButton setTitleColor:KSelectedBgColor forState:UIControlStateNormal];
        
        return @"重新获取";
        
    }];

    
}

//获取验证码
- (void)getVerification {
    

    [self showLoadingHub];
    WEAK_SELF
    [AFNHttpRequestOPManager requestVaryCodeForPhoneNumber:self.phoneField.text varyCodeType:KTypeForgotPassword block:^(id result, NSError *error) {
        if (error.code==1) {
             [_getCodeButton startWithSecond:[result[EntityKey][@"remainClock"]intValue]];
        }
        
        [weak_self hideLoadingHub];
    }];

      
    
}

- (IBAction)verificationBtnClick:(id)sender {
     BOOL phone = [Util   isValidateMobile:_phoneField.text];
    if (!phone) {
       
        [Util ShowAlertWithOnlyMessage:@"手机号格式错误"];
        return;
    }
    if (_codeField.text.length<5){
        [Util ShowAlertWithOnlyMessage:@"验证码格式错误"];
        return;
        
    }else{
    
        [self _submitDataSource];
    
        
    }
}


- (IBAction)servicePhoneClick:(id)sender {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4001333866"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
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
        
    }else if (textField==_resetPassView.setPassWord || textField==_resetPassView.ConfirmPassWord){
        _editorStatus=TextEditorPassWordFieldTag;
        [_resetPassView.setPassWord addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        [_resetPassView.ConfirmPassWord addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
        
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
                [_phoneField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
                if (_codeField.text.length==6) {
                    [_validationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [_validationButton setBackgroundColor:KSelectedBgColor];
                    _validationButton.enabled=YES;
                }
                return YES;
            }
        }else if (text.length < 11){
            [_validationButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_validationButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _validationButton.enabled=NO;
            return NO;
        }
    }else if (_editorStatus==TextEditorCodeFieldTag){
        if (_phoneField.text.length == 11&&text.length==6) {
            [_validationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_validationButton setBackgroundColor:KSelectedBgColor];
            _validationButton.enabled=YES;
            _editorStatus=TextEditorDefaultStatus;
            return YES;
        }else{
            [_validationButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_validationButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _validationButton.enabled=NO;
            return NO;
        }
        
        
    }else if (_editorStatus==TextEditorPassWordFieldTag){
        if (_resetPassView.setPassWord.text.length>=5&&_resetPassView.ConfirmPassWord.text.length>=5) {
           
            [_resetPassView.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_resetPassView.submitButton setBackgroundColor:KSelectedBgColor];
            _editorStatus=TextEditorDefaultStatus;
            
            return YES;
        }else{
            
            [_resetPassView.submitButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_resetPassView.submitButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            
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
        if (_phoneField.text.length==0||_codeField.text.length==0) {
           
            [_validationButton setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
            [_validationButton setBackgroundColor:UIColorFromRGB(0xdcdcdc)];
            _validationButton.enabled=NO;
            
        }else {
            
            [_validationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_validationButton setBackgroundColor:KSelectedBgColor];
            _validationButton.enabled=YES;
            
        }
    }
}

-(void)valueChanged:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FindPasswordValue" object:textField];
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark ------------------------Getter / Setter----------------------
- (DLResetPassView *)resetPassView {
    
    endBtn=NO;
    
    if (!_resetPassView) {
        _resetPassView = BoundNibView(@"DLResetPassView", DLResetPassView);
        _resetPassView.frame = CGRectMake(0, 0, kScreenWidth, 300);
    }
    WEAK_SELF
    _resetPassView.resetPassViewBlcok = ^{
    
        [weak_self _postData];
    };
    _resetPassView.setPassWord.delegate = self;
    _resetPassView.ConfirmPassWord.delegate = self;
    
    return _resetPassView;
    
}

@end
