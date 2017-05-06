//
//  ScanQRCodeController.m
//  Merchants_JingGang
//
//  Created by HanZhongchou on 16/1/12.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "ScanQRCodeController.h"

@interface ScanQRCodeController ()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ScanQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    self.navigationItem.title = @"收钱";
    self.webView.delegate = self;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSString *userId = [userDefaults objectForKey:kUserDefaultsUserIDKey];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/qr_main.htm?s=%@",Shop_url,userId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    
    
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end
