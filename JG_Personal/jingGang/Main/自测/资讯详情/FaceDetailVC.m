//
//  FaceDetailVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/16.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "FaceDetailVC.h"
#import "GlobeObject.h"
#import "Util.h"
#import "UIButton+Block.h"
#import "AppDelegate.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "H5page_URL.h"
#import "ComplainsController.h"

#define Face_Dateil_relative_path @"/information/face_information_detail"

@interface FaceDetailVC ()<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    
}


@property (retain, nonatomic) IBOutlet UIWebView *faceDetailWebView;

@end

@implementation FaceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    //建立js环境
    [self makeJsEnvirement];
    
    [self _loadNavLeft];
    
    [self _loadTitleView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    [self _loadRequest:self.faceDetailID];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
    
}


#pragma mark - private Method
-(void)_loadNavLeft{
    
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
        [weak_self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
    RELEASE(item);
    
}



-(void)_init{
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.faceDetailWebView.delegate = self;
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.faceDetailWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 0.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
}



-(void)_loadTitleView{
    
    [Util setNavTitleWithTitle:@"资讯" ofVC:self];
    
}


-(void)_loadRequest:(long)faceDetailID{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?informationId=%ld",Base_URL,Face_Dateil_relative_path,faceDetailID];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.faceDetailWebView loadRequest:request];
    self.faceDetailWebView.delegate = self;
}


#pragma mark - 建立js环境
-(void)makeJsEnvirement{

    JSContext *context = [self.faceDetailWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"requestDetails"] = ^() {
        
        NSLog(@"face detail sns Click");
        NSArray *args = [JSContext currentArguments];
        long clickID = [[args[0] toNumber] longValue];
        self.faceDetailID = clickID;

        [self _loadRequest:clickID];
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
    };
    
    context[@"tipsInformation"] = ^() {
        
        NSLog(@"face detail recommend Click");
        NSArray *args = [JSContext currentArguments];
        long clickID = [[args[0] toNumber] longValue];
        ComplainsController *complainVC = [[ComplainsController alloc] init];
        complainVC.complainType = InformationType;
        complainVC.targetId = [NSString stringWithFormat:@"%ld",clickID];
        [self.navigationController pushViewController:complainVC animated:YES];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
    };
}



#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *path=[[request URL] absoluteString];
    
    NSRange range = [path rangeOfString:@"="];
    
    NSString *findStr = [path substringFromIndex:range.location+1];

    self.faceDetailID = [findStr longLongValue];
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [self makeJsEnvirement];

}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    //    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}



@end
