//
//  HelpViewController.m
//  weimi
//
//  Created by ray on 16/3/2.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@property (nonatomic) UIWebView *webView;
@property (nonatomic) NSString *urlString;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];

}

- (void)loadUrl:(NSString *)urlString {
    self.urlString = urlString;
    if (_webView == nil) return;
    [self.webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
}

@end
