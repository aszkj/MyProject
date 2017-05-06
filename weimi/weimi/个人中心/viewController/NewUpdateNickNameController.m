//
//  NewUpdateNickNameController.m
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "NewUpdateNickNameController.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "WEMEUsercontrollerApi.h"

@interface NewUpdateNickNameController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@end

@implementation NewUpdateNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
}

- (void)_init {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.nickNameTextField.text = self.nickName;
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont customFontOfSize:16];
    [saveButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
//    [Util setNavTitleWithTitle:@"修改昵称" ofVC:self];
    self.title = @"修改昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
}

- (void)save {
    
    if (IsEmpty(self.nickNameTextField.text)) {
        [Util ShowAlertWithOnlyMessage:@"昵称不能为空"];
    }else{
        [self _updateNickNameRequest];
    }
}

- (void)_updateNickNameRequest {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在修改昵称...";
    [hud show:YES];
    [self.nickNameTextField resignFirstResponder];
    WEAK_SELF
    [[WEMEUsercontrollerApi sharedAPI] updateNickNameUsingPOST1WithCompletionBlock:self.nickNameTextField.text completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        
        if (IsEmpty(error) && output.success.integerValue == YES)
        {
            if (_updateNickeNameBlock)
            {
                _updateNickeNameBlock(self.nickNameTextField.text);
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

- (IBAction)clearNickNameAction:(id)sender {
    
    self.nickNameTextField.text = nil;
    
}



@end
