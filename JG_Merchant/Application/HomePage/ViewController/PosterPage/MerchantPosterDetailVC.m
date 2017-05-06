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
@property (weak, nonatomic) IBOutlet UILabel *posterAuthorLabel;

@end

@implementation MerchantPosterDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _vapManager = [[VApiManager alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.postDetailType == PoserOperater_Send) {
        
        [self _requestPosterDetail];
        
    }else if (self.postDetailType == PosterPlat_Send){

        [self _requestPlatPosterDetail];
    
    }

    
}

#pragma mark ----------------------- private Method -----------------------
- (void)_requestPosterDetail {
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UsersNoticesDetailsRequest *request = [[UsersNoticesDetailsRequest alloc] init:GetToken];
    request.api_id = self.posterID;
    
    [_vapManager usersNoticesDetails:request success:^(AFHTTPRequestOperation *operation, UsersNoticesDetailsResponse *response) {
        
        OpNotices *model = [OpNotices objectWithKeyValues:response.noticesBO];
        NSString *time = [NSString stringWithFormat:@"时间：%@",model.addTime];
        if (model.ntContent) {
            [_posterWeb loadHTMLString:model.ntContent baseURL:nil];
        }
        self.titleLabel.text = model.ntTitle;
        self.timeLabel.text = time;
        self.posterAuthorLabel.text = model.operatorName;
        [hub hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hub hide:YES];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
}

-(void)_requestPlatPosterDetail{
    
    UsersSysNoticesDetailsRequest *request = [[UsersSysNoticesDetailsRequest alloc] init:GetToken];
    request.api_id = self.posterID;
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_vapManager usersSysNoticesDetails:request success:^(AFHTTPRequestOperation *operation, UsersSysNoticesDetailsResponse *response) {
        
        NSLog(@"商户公告详情 %@",response);
        ArticleBO *model = [ArticleBO objectWithKeyValues:response.articleBO];
        NSString *time = [NSString stringWithFormat:@"时间：%@",model.addTime];
        if (model.content) {
            [_posterWeb loadHTMLString:model.content baseURL:nil];
        }
        self.titleLabel.text = model.title;
        self.timeLabel.text = time;
        self.posterAuthorLabel.text = @"云e生";
        [hub hide:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    


}




@end
