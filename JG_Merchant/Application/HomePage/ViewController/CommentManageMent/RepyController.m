//
//  RepyController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "RepyController.h"
#import "UITextView+Placeholder.h"
#import "DownToUpAlertView.h"

@interface RepyController () {

    VApiManager *_vapManager;

}

@property (weak, nonatomic) IBOutlet UITextView *repyContentTextView;

@end

@implementation RepyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
}

#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    
    _vapManager = [[VApiManager alloc] init];
    [self setDefaultAttribute];
    [self setVCTtitle:@"回复评价"];
    self.repyContentTextView.placeholder = @"回复内容，500字以内。";
    UIColor *whiteColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"提交" titleColor:whiteColor target:self action:@selector(issue)];
}

-(void)_repyRequest {
    
    GroupEvaluateSaveRequest *request = [[GroupEvaluateSaveRequest alloc] init:GetToken];
    request.api_orderId = self.repyOrderID;
    request.api_context = self.repyContentTextView.text;
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.labelText = @"正在回复..";
    [_vapManager groupEvaluateSave:request success:^(AFHTTPRequestOperation *operation, GroupEvaluateSaveResponse *response) {
        if (response.errorCode) {//评论失败
            hub.labelText = response.subMsg;
        }else {
            hub.labelText = @"回复成功";
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
        }
        
        [hub hide:YES afterDelay:1.0];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        hub.labelText = @"回复失败";
        [hub hide:YES afterDelay:1.0];
        
    }];
    
}

#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)issue {

    NSLog(@"发布");
    [self.repyContentTextView resignFirstResponder];
    if (IsEmpty(self.repyContentTextView.text)) {
        [DownToUpAlertView showAlertTitle:@"请输入回复内容" inContentView:self.view];
    }else {
        [self _repyRequest];
    }
    
}





@end
