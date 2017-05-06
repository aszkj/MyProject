//
//  InputInviteCodeController.m
//  jingGang
//
//  Created by HanZhongchou on 15/12/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "InputInviteCodeController.h"
//#import "VApiManager.h"
@interface InputInviteCodeController ()
/**
 *  邀请码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *textFieldInviteCode;

/**
 *  验证按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *buttonInviteCode;
/**
 *  标题label
 */
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end

@implementation InputInviteCodeController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    [self loadUI];
    //请求用户的是否被邀请状态
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestUsersInviteStatus];
    // Do any additional setup after loading the view from its nib.
}

- (void)requestUsersInviteStatus
{
    WEAK_SELF
    VApiManager *vapiManager = [[VApiManager alloc]init];
    
    UsersInvitationCodeCheckExistsRequest *request = [[UsersInvitationCodeCheckExistsRequest alloc]init:GetToken];
    [vapiManager usersInvitationCodeCheckExists:request success:^(AFHTTPRequestOperation *operation, UsersInvitationCodeCheckExistsResponse *response) {
        
        //0 没有被邀请过    1被邀请过
        if ([response.isExist integerValue] == 0) {
            weak_self.labelTitle.text = @"输入TA的邀请码，获取额外奖励";
        }else{

            weak_self.textFieldInviteCode.enabled = NO;
            weak_self.textFieldInviteCode.text = response.invitationCode;
            weak_self.buttonInviteCode.alpha = 0.5f;
            weak_self.buttonInviteCode.userInteractionEnabled = NO;
            weak_self.labelTitle.text = @"您已成为TA的好友，无需再验证。";
        }
        
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];
    
}


- (void)loadUI
{
    self.navigationItem.title = @"填写邀请码";
    //设置textField的边框
    self.textFieldInviteCode.layer.borderWidth = 1.0f;
    self.textFieldInviteCode.layer.cornerRadius = 5;
    self.textFieldInviteCode.layer.borderColor = kGetColor(89, 196, 239).CGColor;
    self.textFieldInviteCode.textAlignment = NSTextAlignmentCenter;
    
    //验证按钮设置圆角
    self.buttonInviteCode.layer.cornerRadius = m_button_cornerRadius;
    
    
    
    
    

    
    
}

- (IBAction)buttonTestCodeClick:(id)sender {
    
    
    [self.view endEditing:YES];
    if ([Util varifyValidOfStr:self.textFieldInviteCode.text]) {
        if (self.textFieldInviteCode.text.length < 6 || self.textFieldInviteCode.text.length > 6) {
            [self hideHubWithOnlyText:@"邀请码应该是6位数字"];
            return;
        }
        //如果格式没有错误就提交验证码请求
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self commitInviteCode];
        
    }else{
        [self hideHubWithOnlyText:@"邀请码不能为空"];
    }
    
}


- (void)commitInviteCode
{
    UsersInvitationCodeBindRequest *request = [[UsersInvitationCodeBindRequest alloc]init:GetToken];
    request.api_invitationCode = self.textFieldInviteCode.text;
    
    VApiManager *vapiManager = [[VApiManager alloc]init];
    WEAK_SELF
    [vapiManager usersInvitationCodeBind:request success:^(AFHTTPRequestOperation *operation, UsersInvitationCodeBindResponse *response) {
        
        //服务器返回1是成功，0不成功
        JGLog(@"%@",response.verfiySuccess);
        if ([response.verfiySuccess integerValue] == 1) {
            [weak_self hideHubWithOnlyText:@"验证成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weak_self.navigationController popViewControllerAnimated:YES];
                
            });
        }else{
            [weak_self hideHubWithOnlyText:response.subMsg];
        }
        [weak_self.view endEditing:YES];
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        [self hideHubWithOnlyText:@"网络错误，请检查网络"];
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
