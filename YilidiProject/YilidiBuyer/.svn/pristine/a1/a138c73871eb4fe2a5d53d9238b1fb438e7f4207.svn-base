//
//  DLCordovaH5VC.m
//  YilidiBuyer
//
//  Created by mm on 16/12/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCordovaH5VC.h"
#import "Share.h"
#import "Operation.h"
#import "ProductCart.h"
#import "UIViewController+showHiddenBottomBarHandle.h"
#import "DLCordovaH5VC+productCartModule.h"
#import "DLCordovaH5VC+shareModule.h"
#import "CDVViewController+cordovaExtend.h"
#import "NSString+Teshuzifu.h"


@interface DLCordovaH5VC ()

@end

@implementation DLCordovaH5VC

- (void)viewDidLoad {
    self.wwwFolderName = @"www";
    self.startPage = self.h5Url;
    [super viewDidLoad];
    
    [self _registerNotification];
    
    [self _initPageModule];
    
    [self _initPlugin];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self showHiddenBottomBarHandle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



#pragma mark ---------------------Private Method------------------------------
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

- (void)_loadUlrStr:(NSString *)urlStr {
    self.wwwFolderName = @"www";
    urlStr = [urlStr resolutionCordovaUrlStr];
    self.startPage = urlStr;
    NSURL *url = [self performSelector:@selector(appUrl)];
    if (url)
    {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webViewEngine loadRequest:request];
    }
}


#pragma mark ---------------------Init Method------------------------------
- (void)_initPageModule {
    [self initShareModule];
}


#pragma mark ---------------------InitPlugin Method------------------------------
- (void)_initPlugin {
    
    [self initSharePlugin];
    
    [self initProductCartPlugin];
    
    [self _initOperationPlugin];
    
}

- (void)_initOperationPlugin {
    WEAK_SELF
    Operation *operation = (Operation *)[self getCommandInstance:@"Operation"];
    operation.htmlBackBlock = ^{
        [weak_self _back];
    };
    operation.htmlRedirectBlock = ^(NSString *urlStr){
        [weak_self _loadUlrStr:urlStr];
    };
}



#pragma mark ------------------------Notification-------------------------
- (void)observeCordovaWebViewBeginLoad:(NSNotification *)info  {
    
}

- (void)observeCordovaWebViewFinishedLoad:(NSNotification *)info  {
    
    [self callJsMethodConfigure];
}

#pragma mark ---------------------ViewEvent Method------------------------------
- (void)_back{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
