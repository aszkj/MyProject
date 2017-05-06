//
//  JGCustomTestFaceWithWomanController.m
//  jingGang
//
//  Created by dengxf on 16/1/28.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGCustomTestFaceWithWomanController.h"
#import "GlobeObject.h"
#import "H5page_URL.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "testchildViewController.h"
#import "ZongHeZhengVC.h"
#import "ZhengZhuangListVC.h"
#import "JGFaceClickWebController.h"

@interface JGCustomTestFaceWithWomanController ()<UIWebViewDelegate>
@property (strong,nonatomic) UIWebView *web;

@end

@implementation JGCustomTestFaceWithWomanController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBarPopButton];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIWebView *web = [[UIWebView alloc] init];
    web.delegate = self;
    web.x = 0;
    web.y = 0;
    web.width = ScreenWidth;
    web.height = ScreenHeight - NavBarHeight;
    
    NSString *adUrl = [NSString stringWithFormat:@"%@",Figure_Women_H5];
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
    context[@"figureCalculater"] = ^() {
        testchildViewController * testChildVc = [[testchildViewController alloc]init];
        [self.navigationController pushViewController:testChildVc animated:YES];
    };
    
    context[@"requestSkin"] = ^(){
        ZongHeZhengVC *zongheZhenVC =  [[ZongHeZhengVC alloc] init];
        //皮肤
        zongheZhenVC.selfTestTiID = @4000;
        zongheZhenVC.comminType = Commin_From_Skin;
        [self.navigationController pushViewController:zongheZhenVC animated:YES];
    };
    
    context[@"requestCategory"] = ^(){
        NSArray *args = [JSContext currentArguments];
        JSValue *value = args[0];
        long longValue = value.toNumber.longLongValue;
        ZhengZhuangListVC *zhengZhuangListVC = [[ZhengZhuangListVC alloc] init];
        zhengZhuangListVC.fen_lie_ID = longValue;
        zhengZhuangListVC.comminType  = FIGURE_CLICK_COMIN;
        
        [self.navigationController pushViewController:zhengZhuangListVC animated:YES];
    };
    
    context[@"requestFace"] = ^(){
        
        JGFaceClickWebController *womanFaceController =[[JGFaceClickWebController alloc] init];
        [self.navigationController pushViewController:womanFaceController animated:YES];
    };
    
}

@end
