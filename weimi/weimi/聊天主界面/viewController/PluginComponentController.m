//
//  PluginComponentController.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/11/4.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "PluginComponentController.h"
#import "PaymentHelper.h"
#import "WXApi.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "PaymentHelper.h"
#import "DatabaseCache.h"
#import "UIView+Design.h"

@interface PluginComponentController ()<CWAlipayDelegate,WXApiDelegate>

@property (nonatomic, strong) NSString *webViewUrl;
@property (nonatomic, assign) float webViewWidth;
@property (nonatomic, assign) float webViewHeight;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *rule;

@end

@implementation PluginComponentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (UIWebView *)webView {
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, _webViewWidth, _webViewHeight)];
        _webView.delegate = self;
        _webView.scrollView.delaysContentTouches = NO;
        _webView.scrollView.scrollsToTop = NO;
        _webView.scrollView.scrollEnabled = NO;

    }
    
    return _webView;
}

/**
 *  重新调整高度
 *
 *  @param frame           新的frame
 *  @param path            加载url
 *  @param rule            参数：rule,拥有回调js时使用
 *  @param finishLoadBlock callBack
 */
- (void)reinitWithFrame:(CGRect)frame path:(NSString *)path rule:(NSString *)rule finishLoadBlock:(FinishLoadBlock)finishLoadBlock componentDescDidChangedBlock:(ComponentDescDidChangedBlock)componentDescDidChangedBlock componentStateDidChangedBlock:(ComponentDescDidChangedBlock)componentStateDidChangedBlock {
    
    frame.size.height = 1;
    self.view.frame = frame;

    _path = path;
    _webViewHeight = frame.size.height;
    _webViewWidth = frame.size.width;
    _finishLoadBlock = finishLoadBlock;
    _componentStateDidChangedBlock = componentStateDidChangedBlock;
    _componentDescDidChangedBlock = componentDescDidChangedBlock;
    _rule = rule;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = frame;
    self.webView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    [self initWebViewDataWithPath:path];    
}

- (void)initWebViewDataWithPath:(NSString *)path
{
    
//    NSString *htmlString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aindex" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",GetToken];
    [req addValue:token forHTTPHeaderField:@"Authorization"];
    
    [self.webView loadRequest:req];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    
}

#pragma mark - private methord

- (void)loadDocument:(NSString*)docName {
    
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path = [mainBundleDirectory  stringByAppendingPathComponent:docName];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - 建立js环境
-(void)makeJsEnvirement {
    
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"updateUrl"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *commentStr = [args[0] toString];
        NSLog(@"commentStr:%@",commentStr);
    };
    
    context[@"aliPay"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *commentStr = [args[0] toString];
        [[PaymentHelper sharedInstance] startAlipayWith:nil paySignature:commentStr delegate:self];

    };
    
    // 显示文字
    WEAK_SELF
    context[@"updateComponentDesc"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *commentStr = [args[0] toString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (weak_self.componentDescDidChangedBlock) {
                weak_self.componentDescDidChangedBlock(commentStr);
            }            
        });
    };
    
    // 刷新状态
    context[@"updateComponentStatus"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *commentStr = [args[0] toString];
        
        if ([commentStr isEqualToString:@"1"]) {
            
            if (weak_self.componentStateDidChangedBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weak_self.componentStateDidChangedBlock(commentStr);
                });
            }
            
        }
    };
}

#pragma mark –
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if([request isKindOfClass:[NSMutableURLRequest class]]) {
        

    }

    return true;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title11=%@",title);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //js获取body宽度
    NSString *bodyWidth= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth"];
    CGFloat widthOfBody = [bodyWidth floatValue];

    /*float height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue] + kEdgeInsetTop;
    if (height<100) {
        height = 100;
    }
    
//    height += 100;
    float width = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"] floatValue];
    if (width < 200) {
        width = 200;
    }
    
//    CGSize fittingSize = CGSizeMake(width, height);
    
    if (width > kScreenWidth - kComponentLeftMargin - kEdgeInsetRight) {
        
        width = kScreenWidth - kComponentLeftMargin - kEdgeInsetRight;
    }
    
    webView.frame = CGRectMake(0, 0, width, height);
    self.view.height = height;
    self.view.width = width;*/
    
    if (webView.frame.size.width != widthOfBody) {
        NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
        [webView stringByEvaluatingJavaScriptFromString:meta];
    }
    
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    if (_finishLoadBlock) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

            _finishLoadBlock(fittingSize);
        });
    }
    
    [self makeJsEnvirement];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error.description);
}

#pragma mark- CWAlipayDelegate

- (void)alipayCompleteCallback:(NSDictionary *)resultDic {
    
    //支付成功
}

#pragma mark- WXApiDelegate

- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
            
                
            break;
                
            default:
            
            break;
        }
    }
    
}

@end
