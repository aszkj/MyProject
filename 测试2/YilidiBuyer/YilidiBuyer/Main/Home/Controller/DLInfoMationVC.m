//
//  DLInfoMationVC.m
//  YilidiBuyer
//
//  Created by yld on 16/9/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInfoMationVC.h"
#import <WebKit/WebKit.h>
#import "ProjectRelativeKey.h"

@interface DLInfoMationVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DLInfoMationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTitle];
    
    [self _loadActivityH5UrlStr];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

#pragma mark -------------------Init Method----------------------
-(void)_initTitle {

}


-(void)_init {
    
    if (isEmpty(self.infoDic)) {
        self.infoMationUrl = self.infoDic[kLinkDataKeyInfomation];
    }
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) configuration:nil];
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    [self.view addSubview:self.webView];
    
}

#pragma mark -------------------Private Method----------------------
- (void)_loadActivityH5UrlStr {
    NSURL *url = [NSURL URLWithString:self.infoMationUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


#pragma mark -------------------PageNavigate Method----------------------
#pragma mark -------------------Delegate Method----------------------
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
    [self showHubWithDefaultStatus];
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self dissmiss];
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    [self dissmiss];
}





@end
