//
//  AboutInfoViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "AboutInfoViewController.h"

@interface AboutInfoViewController ()

{
    UIWebView *_web;
}
@end

@implementation AboutInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VCBackgroundColor;
    
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 40, __StatusScreen_Height, 80, 40)];;
    l.text = @"关于云e生";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    
    
    VApiManager *netManager = [[VApiManager alloc]init];
    UsersSysHelpRequest *request = [[UsersSysHelpRequest alloc]init:GetToken];
    request.api_code = @"oappabout";
    
    [netManager usersSysHelp:request success:^(AFHTTPRequestOperation *operation, UsersSysHelpResponse *response) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response.documet keyValues]];
        _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44)];
        NSString *strUrl = [NSString stringWithFormat:@"%@",dic[@"content"]];
        [_web loadHTMLString:strUrl baseURL:nil];
        [self.view addSubview:_web];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
//    
//
//    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strUrl]]];
//    [_web loadHTMLString:<#(nonnull NSString *)#> baseURL:nil];
    
    
    
    
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
