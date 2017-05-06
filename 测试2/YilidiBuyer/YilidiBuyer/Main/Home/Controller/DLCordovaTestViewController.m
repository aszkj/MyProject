//
//  DLCordovaTestViewController.m
//  YilidiBuyer
//
//  Created by mm on 16/12/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCordovaTestViewController.h"
#import "ProductCart.h"
#import "HaleyPlugin.h"

#define TestHtml @"http://buyertest.yldbkd.com/h5/cordovatest.html"

@interface DLCordovaTestViewController ()

@end

@implementation DLCordovaTestViewController

- (void)viewDidLoad {
    self.wwwFolderName = @"www";
//    self.startPage = @"index.html";
    self.startPage = TestHtml;
    [super viewDidLoad];
    
//    [self performSelector:@selector(testAA) withObject:nil afterDelay:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)testAA  {

    self.wwwFolderName = @"http://";
    self.startPage = TestHtml;
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
//- (void)testAA  {
//    
//    self.wwwFolderName = @"www";
//    self.startPage = @"index";
//    NSURL *url = [self performSelector:@selector(appUrl)];
//    if (url)
//    {
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//        [self.webViewEngine loadRequest:request];
//    }
//    
//    HaleyPlugin *plugin = (HaleyPlugin *)[self getCommandInstance:@"HaleyPlugin"];
////    ProductCart *plugin = (ProductCart *)[self getCommandInstance:@"ProductCart"];
//
//    plugin.jsTransValueBlock = ^{
//        NSLog(@"hehe");
//    };
// 
//    [plugin.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"callMe('%@')",@"我"] completionHandler:^(id o, NSError *error) {
//    }];
//    
//}


@end


