//
//  UpdateNicknameViewController.m
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "UpdateNicknameViewController.h"
#import <WEMEUsercontrollerApi.h>
#import <MBProgressHUD.h>
#import <WEMEStorecustomerservicecontrollerApi.h>
#import "AppDelegate.h"

@interface UpdateNicknameViewController ()<UITextFieldDelegate>
{
    BOOL isNicknameEdit;
    WEMEUsercontrollerApi *_userControllerApi;
}


@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation UpdateNicknameViewController

-(void)dealloc
{
    [kNotification removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [_userControllerApi.apiClient.operationQueue cancelAllOperations];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = VCBackgroundColor;
    [self setNavigationItem];
    isNicknameEdit = YES;
    [self.view addSubview:self.userNicknameTextField];
    [_userNicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(254/3));
        make.left.equalTo(@(KLeftMargin * 2));
        make.right.equalTo(@(-2 * KLeftMargin));
        make.height.equalTo(@40);
    }];
    [self.view addSubview:self.lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNicknameTextField.mas_bottom).with.offset(KLeftMargin);
        make.left.equalTo(@(KLeftMargin * 2));
        make.right.equalTo(@(-2 * KLeftMargin));
        make.height.equalTo(@(5/3));
    }];
    [self.view addSubview:self.promptLabel];
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).with.offset(KLeftMargin);
        make.left.equalTo(@(KLeftMargin * 3));
        make.right.equalTo(@(-3 * KLeftMargin));
    }];
}

- (void)setNavigationItem {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserNickname)];
    rightButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.title = @"修改昵称";
}


#pragma mark - getter

-(UITextField *)userNicknameTextField
{
    if (!_userNicknameTextField) {
        _userNicknameTextField = [[UITextField alloc] init];
        _userNicknameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNicknameTextField.textColor = UIColorFromRGB(0X333333);
        _userNicknameTextField.font = [UIFont CustomFontOfSize:54/3];
        [_userNicknameTextField becomeFirstResponder];
        _userNicknameTextField.delegate = self;
//        [kNotification addObserver:self selector:@selector(didChangeString) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return _userNicknameTextField;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromRGB(0Xd3d5d8);
    }
    return _lineView;
}
-(UILabel *)promptLabel
{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc]init];
        _promptLabel.text = @"昵称不能超过10个汉字或20个英文字符,支持中英文,数字,下划线";
        _promptLabel.numberOfLines = 0;
        _promptLabel.textColor = UIColorFromRGB(0xb6b6b6);
        _promptLabel.font = [UIFont CustomFontOfSize:12];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _promptLabel;
}


#pragma mark - private methord

-(void)saveUserNickname
{
    if (_userNicknameTextField.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"昵称不能为空！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在修改昵称...";
    [hud show:YES];
    [_userNicknameTextField resignFirstResponder];
    WEAK_SELF
    __weak AppDelegate *weak_app = kAppDelegate;
    [[WEMEStorecustomerservicecontrollerApi sharedAPI] updateNickNameUsingPOSTWithCompletionBlock:_userNicknameTextField.text completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        if (IsEmpty(error) && output.success.integerValue == YES)
        {
            weak_app.userInfo.name = weak_self.userNicknameTextField.text;
            if (weak_self.updateNickeNameBlock)
            {
                weak_self.updateNickeNameBlock(weak_self.userNicknameTextField.text);
                [weak_self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [NSError checkErrorFromServer:error response:output];
        }
        [MBProgressHUD hideHUDForView:weak_self.view  animated:YES];
    }];
   
}
- (void)didChangeString
{
    self.userNicknameTextField.text = [Util getToString:self.userNicknameTextField.text byteLessWith:20];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1 && string.length == 0)//删除操作
    {
        return YES;
    }
    if ([Util getToInt:textField.text] >= 20)//大于20字节
    {
        return NO;
    }
    NSUInteger yuanLength = [Util getToInt:textField.text];
    NSUInteger newLength  = [Util getToInt:string];
    if (yuanLength + newLength > 20)
    {
        textField.text = [Util getToString:[NSString stringWithFormat:@"%@%@",textField.text,string] byteLessWith:20];//[[NSString stringWithFormat:@"%@%@",textField.text,string] substringToIndex:10];
        return NO;
    }
    else
    {
        return YES;
    }
}



@end
