//
//  JGSacnQRCodeNextController.m
//  jingGang
//
//  Created by HanZhongchou on 16/1/13.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGSacnQRCodeNextController.h"

@interface JGSacnQRCodeNextController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JGSacnQRCodeNextController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    self.navigationItem.title = @"付钱";
    self.webView.delegate = self;
    

    

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.strScanQRCodeUrl]];
    
    
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
