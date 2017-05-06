//
//  AboutYunEs.m
//  jingGang
//
//  Created by wangying on 15/6/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "AboutYunEs.h"
//#import "PublicInfo.h"

@interface AboutYunEs ()
{
    UIWebView *_web;
}
@end

@implementation AboutYunEs

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
    request.api_code = @"mappabout";
    
    [netManager usersSysHelp:request success:^(AFHTTPRequestOperation *operation, UsersSysHelpResponse *response) {
        
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response.documet keyValues]];
        _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        NSString *strUrl = [NSString stringWithFormat:@"%@",dic[@"content"]];
        [_web loadHTMLString:strUrl baseURL:nil];
        [self.view addSubview:_web];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
