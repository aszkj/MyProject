//
//  HelpController.m
//  jingGang
//
//  Created by dengxf on 15/10/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "HelpController.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "ZkgLoadingHub.h"
#import "GlobeObject.h"

@interface HelpController (){
    
    VApiManager     *_vapManager;
    ZkgLoadingHub   *_loadingHub;
    
}

/**
 *  web视图-
 */
@property (strong,nonatomic) UIWebView *webView;

@end

@implementation HelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vapManager = [[VApiManager alloc] init];
    // 初始化界面
    [self setupContent];
}

/**
 *   初始化界面
 */
- (void)setupContent {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [backButton setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barItem;
    
    UILabel *helpLab = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 40, __StatusScreen_Height, 80, 40)];;
    helpLab.text = @"帮助";
    helpLab.textAlignment = NSTextAlignmentCenter;
    helpLab.font = [UIFont systemFontOfSize:18];
    helpLab.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = helpLab;
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 64)];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]]];
    [self.view addSubview:webView];
    self.webView = webView;
    
    [self _requestHelpData];
}

-(void)_requestHelpData {
    
    _loadingHub = [[ZkgLoadingHub alloc] initHubInView:self.view withLoadingType:LoadingSystemtype];
    UsersSysHelpRequest *request = [[UsersSysHelpRequest alloc] init:GetToken];
    request.api_code = @"papphelp";
    
    [_vapManager usersSysHelp:request success:^(AFHTTPRequestOperation *operation, UsersSysHelpResponse *response) {
        [_loadingHub endLoading];
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *str = dict[@"documet"][@"content"];
        [_webView loadHTMLString:str baseURL:nil];
        NSLog(@"帮助%@",response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_loadingHub endLoading];
        
    }];
}


/**
 *  监听返回事件
 */
- (void)backButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
