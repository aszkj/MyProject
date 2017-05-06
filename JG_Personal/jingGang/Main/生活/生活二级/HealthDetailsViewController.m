//
//  HealthDetailsViewController.m
//  jingGang
//
//  Created by thinker on 15/6/18.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HealthDetailsViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "UIButton+Block.h"
#import "Util.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface HealthDetailsViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    
    NJKWebViewProgress *_progressProxy;
    NJKWebViewProgressView *_progressView;
    
    NSString               *_urlStrUnincludedID;
}

@end


@implementation HealthDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:self.url];
    [_webView loadRequest:req];
    RELEASE(req);
    
    NSString *urlStr = [self.url absoluteString];
    
    NSRange rage = [urlStr rangeOfString:@"="];
    
    _urlStrUnincludedID = [urlStr substringToIndex:rage.location];
    

    [self addBackButton];
    [Util setNavTitleWithTitle:@"资讯" ofVC:self];
    
}

#pragma mark - 建立js环境
-(void)makeJsEnvirement{
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"requestDetails"] = ^() {
        
//        NSLog(@"requestDetails Click");
        NSArray *args = [JSContext currentArguments];
        long ID = [[args[0] toNumber] longValue];
        [self _loadRequestWithID:ID];
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        
    };
    
}


-(void)_loadRequestWithID:(long)ID{

    NSString *urlStr = [NSString stringWithFormat:@"%@=%ld",_urlStrUnincludedID,ID];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:req];
}



#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *path=[[request URL] absoluteString];
    NSLog(@"path ---- %@",path);
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self makeJsEnvirement];
    
}




-(void)addBackButton{
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
        [weak_self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
    RELEASE(navLeftButton);
    RELEASE(item);
}



-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:NO];
    //[Util setNavTitleWithTitle:[_webView stringByEvaluatingJavaScriptFromString:@"document.title"] ofVC:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
