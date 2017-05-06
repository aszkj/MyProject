//
//  HealthMaintainceVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "HealthMaintainceVC.h"
#import "GlobeObject.h"
#import "Util.h"
#import "UIButton+Block.h"
#import "AppDelegate.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MainTainceResultVC.h"
#import "JGHealthTaskManager.h"
#import "GlobeObject.h"
#import <stdio.h>

//#define mainTaicePath @"http://static.jgyes.com/static/app/task/";

@interface HealthMaintainceVC ()<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    NSURLRequest *request;
    
}


@property (retain, nonatomic) IBOutlet UIWebView *mainTainceWebView;

@end

@implementation HealthMaintainceVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self _init];
    
    [self _loadNavLeft];
    
    [self _loadTitleView];
    
    [self _loadRequest];


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
    
    
    [self.mainTainceWebView loadHTMLString:nil baseURL:nil];
    
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
    
    RELEASE(navLeftButton);
    RELEASE(item);
}




-(void)_init{
    
    self.mainTainceWebView.delegate = self;
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    
    
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.mainTainceWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    
}


-(void)_loadTitleView{
    
//    [Util setTitleViewWithTitle:@"面部模型" andNav:self.navigationController];
    self.title = self.mainTainceTitle;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
}


-(void)_loadRequest{
    
    NSString *webUrlStr = [NSString stringWithFormat:@"%@%@%@",StaticBase_Url,@"/static/app/task/",self.mainTainceRelativePath] ;
    request =[NSURLRequest requestWithURL:[NSURL URLWithString:webUrlStr]] ;
    [self.mainTainceWebView loadRequest:request];
    
    
    JSContext *context = [self.mainTainceWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"onExercisesEnd"] = ^() {
        
      //完成任务，设置完成的
        [[JGHealthTaskManager shareInstances] setTaskCompletedBybigTaskNum:self.bigTaskNum andSmallTaskNum:self.smallTaskNum];
        
        NSLog(@"Begin Log");
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        MainTainceResultVC *mainTainceVC = [[MainTainceResultVC alloc] init];
        NSMutableArray *newVcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [newVcs removeLastObject];
        [newVcs addObject:mainTainceVC];
        [self.navigationController setViewControllers:newVcs animated:YES];
        mainTainceVC.smallTaskNum = self.smallTaskNum;
        
        RELEASE(mainTainceVC);
        
        JSValue *this = [JSContext currentThis];
        NSLog(@"-------End Log-------");
        
    };
}



#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *path=[[request URL] absoluteString];
    
    NSLog(@"PATH : %@",path);
    
    return YES;
}



#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    //    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)dealloc {

    _mainTainceWebView = nil;

}
@end
