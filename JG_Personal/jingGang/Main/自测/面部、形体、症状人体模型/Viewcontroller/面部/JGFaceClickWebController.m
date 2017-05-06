//
//  JGFaceClickWebController.m
//  jingGang
//
//  Created by dengxf on 16/1/27.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGFaceClickWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ZhengZhuangListVC.h"
#import "GlobeObject.h"
@interface JGFaceClickWebController ()<UIWebViewDelegate>

@property (assign, nonatomic) long type;
@property (strong,nonatomic) UIWebView *web;


@end

@implementation JGFaceClickWebController

- (instancetype)initWithType:(long)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBarTitleViewWithText:@"面部"];
    [self setupNavBarPopButton];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIWebView *web = [[UIWebView alloc] init];
    web.delegate = self;
    web.x = 0;
    web.y = 0;
    web.width = ScreenWidth;
    web.height = ScreenHeight - NavBarHeight;
    NSString *adUrl = [NSString stringWithFormat:@"%@%@",StaticBase_Url,@"/static/app/faceLady.jsp"];
    NSURL *url = [NSURL URLWithString:adUrl];
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    [web loadRequest:reqest];
    web.backgroundColor = JGColor(165, 11, 34, 1);
    [self.view addSubview:web];
    self.web = web;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self makeJsEnvirement];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)makeJsEnvirement {
    JSContext *context = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"requestCategory"] = ^() {
        NSArray *args = [JSContext currentArguments];
        JSValue *value = args[0];
        long longValue = value.toNumber.longLongValue;
        ZhengZhuangListVC *zhengZhuangListVC = [[ZhengZhuangListVC alloc] init];
        zhengZhuangListVC.fen_lie_ID = longValue ;
//        zhengZhuangListVC.isJingGang = YES;
//        zhengZhuangListVC.isOKCLick = 1;
        zhengZhuangListVC.comminType  = FACE_CLICK_COMIN;
//        ZhengZhuangListVC.faceClickType = FACE_CLICK_WOMEN;
        zhengZhuangListVC.faceClickType = FACE_CLICK_WOMEN;
        [self.navigationController pushViewController:zhengZhuangListVC animated:YES];
        JGLog(@"woman");
    };
}
@end
