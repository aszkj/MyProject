//
//  MerchantPosterDetailVC.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/11/9.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantPosterDetailVC.h"
#import "VApiManager.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "GlobeObject.h"
#import "NSObject+MJExtension.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

@interface MerchantPosterDetailVC (){
    
    VApiManager *_vapManager;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *posterWeb;
@property (weak, nonatomic) IBOutlet UILabel *posterAuthorLabel;

@end

@implementation MerchantPosterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [Util setNavTitleWithTitle:@"公告" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];

    [self _requestPostDetail];
    
}

#pragma mark - request data
- (void)_requestPostDetail {
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _vapManager = [[VApiManager alloc] init];
    UsersArticleMarkDetailsRequest *reuqest = [[UsersArticleMarkDetailsRequest alloc] init:GetToken];
    reuqest.api_id = self.posterID;
    [_vapManager usersArticleMarkDetails:reuqest success:^(AFHTTPRequestOperation *operation, UsersArticleMarkDetailsResponse *response) {
        [hub hide:YES];
        ArticleBO *model = [ArticleBO objectWithKeyValues:response.articMarkleDetails];
        [_posterWeb loadHTMLString:model.content baseURL:nil];
        _titleLabel.text = model.title;
        _timeLabel.text = [NSString stringWithFormat:@"%@",model.addTime];
        _posterAuthorLabel.text = @"云e生";

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hub hide:YES];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];

    }];
    
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
