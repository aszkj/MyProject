//
//  JGFaceManViewController.m
//  jingGang
//
//  Created by Ai song on 16/1/28.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGFaceManViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ZhengZhuangListVC.h"
#import "GlobeObject.h"
@interface JGFaceManViewController ()<UIWebViewDelegate>
@property (assign, nonatomic) long type;
@property (strong,nonatomic) UIWebView *web;
@end

@implementation JGFaceManViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    NSString *adUrl = [NSString stringWithFormat:@"%@%@",StaticBase_Url,@"/static/app/face.jsp"];
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
        zhengZhuangListVC.faceClickType = FACE_CLICK_MAN;
        [self.navigationController pushViewController:zhengZhuangListVC animated:YES];
        JGLog(@"man");
    };
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
