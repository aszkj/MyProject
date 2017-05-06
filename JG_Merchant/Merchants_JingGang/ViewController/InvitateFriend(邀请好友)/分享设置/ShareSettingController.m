//
//  ShareSettingController.m
//  jingGang
//
//  Created by 张康健 on 15/12/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "ShareSettingController.h"
#import "Global.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Util.h"
#import "VApiManager.h"
#import "MBProgressHUD.h"

@interface ShareSettingController ()
@property (weak, nonatomic) IBOutlet UITextView *shareContentEditTextView;

@end

@implementation ShareSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
}

- (void)_init {
    
    self.shareContentEditTextView.delegate = self;
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.shareContentEditTextView.text = self.shareContent;
    [Util setNavTitleWithTitle:@"分享设置" ofVC:self];
}

#pragma mark ----------------------- Action Method -----------------------

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)submitAction:(id)sender {
    
    [self _shareContentSaveLogic];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


-(void)_shareContentSaveLogic {

    [self.shareContentEditTextView resignFirstResponder];
    if (IsEmpty(self.shareContentEditTextView.text)) {
        [Util ShowAlertWithOnlyMessage:@"分享内容不能为空"];
        return;
    }
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    VApiManager *vapManager = [[VApiManager alloc] init];
    
    UsersShareInfoSaveRequest *request = [[UsersShareInfoSaveRequest alloc] init:GetToken];
    request.api_shareInfo = self.shareContentEditTextView.text;
    
    hub.labelText = @"正在提交。。";
    [vapManager usersShareInfoSave:request success:^(AFHTTPRequestOperation *operation, UsersShareInfoSaveResponse *response) {
        if (!response.errorCode) {
            hub.labelText = @"保存成功";
            [hub hide:YES afterDelay:0.5];
            [self performSelector:@selector(_editSucesss) withObject:nil afterDelay:0.7];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [hub hide:YES];
    }];
    

}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//
//    return TRUE;
//}
//


-(BOOL) textView :(UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *) text {
    
    if ([text isEqualToString:@"\n"]) {
        [self _shareContentSaveLogic];
    }

    
    if (range.length > 0 && [text isEqualToString:@""]) {
        return YES;
    }

    if (range.location > 36 || textView.text.length > 36){
        
        return FALSE;
    }


    return YES;
}


-(void)_editSucesss {
    if (self.shareContentEditSuccessBlcok) {
        self.shareContentEditSuccessBlcok(self.shareContentEditTextView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
