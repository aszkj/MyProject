//
//  AboutYunEs.m
//  jingGang
//
//  Created by wangying on 15/6/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "AboutYunEs.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "ZkgLoadingHub.h"


@interface AboutYunEs ()
{
    UIWebView       *_web;
    VApiManager     *_vapManager;
    ZkgLoadingHub   *_loadingHub;
}
@end

@implementation AboutYunEs

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vapManager = [[VApiManager alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
    self.navigationItem.leftBarButtonItem = bar;
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 40, __StatusScreen_Height, 80, 40)];
    l.text = @"关于云e生";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 64)];
    [self.view addSubview:_web];
    [self _requestAboutYunESheng];
    
//    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, kScreenHeight-30, 200, 30)];
//    versionLabel.textColor = [UIColor grayColor];
//    versionLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:versionLabel];
//    versionLabel.text = [NSString stringWithFormat:@"v%@",[Util appVersion]];
    
}


-(void)_requestAboutYunESheng {
    
    _loadingHub = [[ZkgLoadingHub alloc] initHubInView:self.view withLoadingType:LoadingSystemtype];
    UsersSysHelpRequest *request = [[UsersSysHelpRequest alloc] init:GetToken];
    request.api_code = @"pappabout";
    
    [_vapManager usersSysHelp:request success:^(AFHTTPRequestOperation *operation, UsersSysHelpResponse *response) {
        
        [_loadingHub endLoading];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *str = dict[@"documet"][@"content"];

        [_web loadHTMLString:str baseURL:nil];


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_loadingHub endLoading];
        
    }];
}

-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
