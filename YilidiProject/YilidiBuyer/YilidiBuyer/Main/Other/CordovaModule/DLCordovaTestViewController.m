//
//  DLCordovaTestViewController.m
//  YilidiBuyer
//
//  Created by mm on 16/12/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCordovaTestViewController.h"
#import "ProductCart.h"
#import "GlobleConst.h"
#import "DLRequestUrl.h"
#import "HaleyPlugin.h"
#import "Share.h"
#import "NSString+Teshuzifu.h"
#import "UIViewController+showHiddenBottomBarHandle.h"

@interface DLCordovaTestViewController ()

@end

@implementation DLCordovaTestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _registerNotification];
    
    [self performSelector:@selector(testAA) withObject:nil afterDelay:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showHiddenBottomBarHandle];
}

- (void)_registerNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(observeCordovaWebViewBeginLoad:)
                   name:CDVPluginResetNotification  // 开始加载
                 object:nil];
    [center addObserver:self
               selector:@selector(observeCordovaWebViewFinishedLoad:)
                   name:CDVPageDidLoadNotification  // 加载完成
                 object:nil];
}


- (void)testAA  {

    self.wwwFolderName = @"http://";
    NSString *urlStr = jFormat(@"%@%@",ServerDomain,kUrl_CordovaTestHtml);
    urlStr = @"http://mtest.yldbkd.com/cordovatest.html";
    urlStr = [urlStr resolutionCordovaUrlStr];
    self.startPage = urlStr;
    NSURL *url = [self performSelector:@selector(appUrl)];
    if (url)
    {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webViewEngine loadRequest:request];
    }

    ProductCart *plugin = (ProductCart *)[self getCommandInstance:@"ProductCart"];
    plugin.jsTransValueBlock = ^{
        NSLog(@"hehe");
    };
}

- (void)observeCordovaWebViewFinishedLoad:(NSNotification *)info  {
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corAppLoadFlag('%@')",@"webPageHasFinishLoaded"] completionHandler:^(id o, NSError *error) {
        
    }];
}


@end
