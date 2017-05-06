//
//  DLChangePasswordVC.m
//  YilidiBuyer
//
//  Created by yld on 16/6/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLChangePasswordVC.h"
#import "GlobleConst.h"
@interface DLChangePasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassWord;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UITextField *confirmPassWord;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation DLChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
   
}



#pragma mark ------------------------Init---------------------------------
- (void)_init {

    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lable.font = [UIFont systemFontOfSize:18.0];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = UIColorFromRGB(0x333333);
    lable.text = self.titleLabel;
    self.navigationItem.titleView = lable;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"nav_Back" target:self action:@selector(_backPage)];
    
    if (kScreenWidth == iPhone5_width) {
        _label.font = [UIFont systemFontOfSize:10];
    }
    
    
    [_oldPassWord addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passWord addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_confirmPassWord addTarget:self action:@selector(_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)_backPage {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark ------------------------Private-------------------------


- (void)_textFieldDidChange:(UITextField *)textField
{
    if (textField == self.oldPassWord||textField == self.passWord||textField == self.confirmPassWord) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
}


#pragma mark ------------------------Api----------------------------------
- (void)requestData {
    
    [self showLoadingHub];;
    NSDictionary *parameters = @{@"oldPassword":self.oldPassWord.text,@"password":self.passWord.text};
    JLog(@"parameters :%@",parameters);
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_Changepassword block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code!=1) {
            
            [self hideLoadingHub];
        }else{
            
            [self hideHubForText:@"修改成功"];
            [self performSelector:@selector(_back) withObject:nil afterDelay:1.0f];
        }
        
    }];
    
   
    
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_back {

       [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)changePassWordClick:(id)sender {
    if (_oldPassWord.text.length==0) {
        [self showSimplyAlertWithTitle:@"提示" message:@"请输入旧密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    if (_passWord.text.length==0) {
    
        [self showSimplyAlertWithTitle:@"提示" message:@"请输入新密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    if (_confirmPassWord.text.length==0) {
        
        [self showSimplyAlertWithTitle:@"提示" message:@"请再次输入新密码" sureAction:^(UIAlertAction *action) {
            
        }];
        return;
    }
    
    if (![_passWord.text isEqualToString:_confirmPassWord.text]){
        [self showSimplyAlertWithTitle:@"提示" message:@"两次密码输入不一致" sureAction:^(UIAlertAction *action) {
            
        }];
        
        return;
    }
    
    if (![Util isNull:_passWord.text]) {
        
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含空格"];
        return;
    }
    
    if (![Util validateNickname:_passWord.text]) {
        [Util ShowAlertWithOnlyMessage:@"输入的密码不能包含特殊字符"];
        return;
    }
    
    if (![Util checkPassWord:_passWord.text]) {
        [Util ShowAlertWithOnlyMessage:@"密码由6-16位字母、数字组成"];
        return;
    }


    [self requestData];

    
}


#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end
