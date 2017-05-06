//
//  JGIntegarlCloudController.m
//  jingGang
//
//  Created by HanZhongchou on 15/12/30.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGIntegarlCloudController.h"
#import "ZkgLoadingHub.h"

@interface JGIntegarlCloudController ()
{
    UIWebView       *_web;
    ZkgLoadingHub   *_loadingHub;
}
@property (nonatomic,strong) VApiManager *vapManager;



@end

@implementation JGIntegarlCloudController

- (void)viewDidLoad {
    [super viewDidLoad];
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 64)];
    [self.view addSubview:_web];
    self.navigationController.navigationBar.hidden = NO;
    if (self.RuleValueType == IntegralRuleType) {
        self.navigationItem.title = @"积分规则";
        [self requestIntegralCloudUrlWithType:@"doc_spec_integral_help"];
    }else{
        self.navigationItem.title = @"云币规则";
        [self requestIntegralCloudUrlWithType:@"doc_spec_yunMoney_help"];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestIntegralCloudUrlWithType:(NSString *)typeStr {
    
    _loadingHub = [[ZkgLoadingHub alloc] initHubInView:self.view withLoadingType:LoadingSystemtype];

    self.vapManager = [[VApiManager alloc]init];
    
    UsersIntegralDocRequest *request = [[UsersIntegralDocRequest alloc]init:GetToken];
    request.api_docMark = typeStr;

    
    [_vapManager usersIntegralDoc:request success:^(AFHTTPRequestOperation *operation, UsersIntegralDocResponse *response) {
        [_loadingHub endLoading];
//        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSString *str = dict[@"documet"][@"content"];
        
        [_web loadHTMLString:response.specContent baseURL:nil];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_loadingHub endLoading];
    }];
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
