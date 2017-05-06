//
//  HelpController.m
//  jingGang
//
//  Created by dengxf on 15/10/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "HelpController.h"

@interface HelpController ()

/**
 *  web视图-
 */
@property (strong,nonatomic) UIWebView *webView;

@end

@implementation HelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self setupContent];
}

/**
 *   初始化界面
 */
- (void)setupContent {
    self.view.backgroundColor = VCBackgroundColor;
    UILabel *helpLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 40, __StatusScreen_Height, 80, 40)];;
    helpLab.text = @"帮助";
    helpLab.textAlignment = NSTextAlignmentCenter;
    helpLab.font = [UIFont systemFontOfSize:18];
    helpLab.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = helpLab;
    
    VApiManager *netManager = [[VApiManager alloc]init];
    UsersSysHelpRequest *request = [[UsersSysHelpRequest alloc]init:GetToken];
    request.api_code = @"mapphelp";
    
    [netManager usersSysHelp:request success:^(AFHTTPRequestOperation *operation, UsersSysHelpResponse *response) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response.documet keyValues]];
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        NSString *strUrl = [NSString stringWithFormat:@"%@",dic[@"content"]];
        [self.webView loadHTMLString:strUrl baseURL:nil];
        [self.view addSubview:self.webView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    

}

/**
 *  监听返回事件
 */
- (void)btnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
