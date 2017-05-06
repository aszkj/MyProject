//
//  MerchantPosterDetailController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/11/8.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantPosterDetailController.h"

@interface MerchantPosterDetailController (){
    
    VApiManager *_vapManager;
    UIWebView   *_posterDetailWebView;

}

@end

@implementation MerchantPosterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _requestPosterDetail];

}

#pragma mark ----------------------- private Method -----------------------

- (void)_init {
    
    _posterDetailWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_posterDetailWebView];
    
}

- (void)_requestPosterDetail {
    
    _vapManager = [[VApiManager alloc] init];
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UsersNoticesDetailsRequest *request = [[UsersNoticesDetailsRequest alloc] init:GetToken];
    
    request.api_id = self.posterID;
    
    [_vapManager usersNoticesDetails:request success:^(AFHTTPRequestOperation *operation, UsersNoticesDetailsResponse *response) {

        NSLog(@"商户公告详情 %@",response);
        NSString *htmlContent = nil;
        if (self.postDetailType == PoserOperater_Send) {
            OpNotices *model = [OpNotices objectWithKeyValues:response.noticesBO];
            htmlContent = model.ntContent;
        }else if (self.postDetailType == PosterPlat_Send){
            ArticleBO *model = [ArticleBO objectWithKeyValues:response.articleBO];
            htmlContent = model.content;
        }
        if (htmlContent) {
            [_posterDetailWebView loadHTMLString:htmlContent baseURL:nil];
        }
        [hub hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hub hide:YES];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
