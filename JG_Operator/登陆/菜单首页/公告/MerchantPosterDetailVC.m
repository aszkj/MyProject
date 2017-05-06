//
//  MerchantPosterDetailVC.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/11/9.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantPosterDetailVC.h"

@interface MerchantPosterDetailVC (){
    
    VApiManager *_vapManager;

    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *posterWeb;

@end

@implementation MerchantPosterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _requestPostDetail];
    
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
        [_posterWeb loadHTMLString:model.content baseURL:nil];
        _titleLabel.text = model.title;
        _timeLabel.text = [NSString stringWithFormat:@"%@",model.addTime];
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
