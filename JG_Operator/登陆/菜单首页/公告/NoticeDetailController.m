//
//  NoticeDetailController.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/11/7.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "NoticeDetailController.h"

@interface NoticeDetailController (){
    
    VApiManager *_vapManager;
    
    UIWebView   *_postWebView;
}

@end

@implementation NoticeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _requestPostDetail];

}

- (void)_init {
    
    _postWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_postWebView];
    
}



#pragma mark - request data
- (void)_requestPostDetail {
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _vapManager = [[VApiManager alloc] init];
    UsersSysNoticesDetailsRequest *request = [[UsersSysNoticesDetailsRequest alloc] init:GetToken];
    request.api_id = self.posterID;
    [_vapManager usersSysNoticesDetails:request success:^(AFHTTPRequestOperation *operation, UsersSysNoticesDetailsResponse *response) {
        [hub hide:YES];
        ArticleBO *model = [ArticleBO objectWithKeyValues:response.articleBO];
        [_postWebView loadHTMLString:model.content baseURL:nil];
        DDLogVerbose(@"运营商公告详情 %@",response);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hub hide:YES];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
