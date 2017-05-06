//
//  DLAboutUsVC.m
//  YilidiSeller
//
//  Created by User on 16/4/1.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLAboutUsVC.h"
#import "ProjectRelativeMaco.h"
#import "DLRequestUrl.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "GlobleConst.h"
#import "SUIMacro.h"
@interface DLAboutUsVC ()<WKNavigationDelegate>
@property (strong, nonatomic) IBOutlet UILabel *versionsLabel;

//@property (weak, nonatomic) IBOutlet UIWebView *aboutUsWebView;
@property (nonatomic,strong)WKWebView *aboutUsWebView;
@end

@implementation DLAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    
    [self _loadAboutUs];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
     
}



-(void)_init {
    
   
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lable.font = [UIFont systemFontOfSize:18.0];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = UIColorFromRGB(0x333333);
    lable.text = self.titleLabel;
    self.navigationItem.titleView = lable;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"nav_Back" target:self action:@selector(_backPage)];
    

    
    self.aboutUsWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
     [self.view addSubview:self.aboutUsWebView];
    self.aboutUsWebView.navigationDelegate = self;

    self.aboutUsWebView.scrollView.backgroundColor = [UIColor whiteColor];
}

- (void)_backPage {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)_loadAboutUs {
    
    NSDictionary *parameters = @{@"typeCode":self.typeCode};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_GetTypeUrl block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code!=1) {
            [self hideLoadingHub];
            return;
        }else{
            [self hideLoadingHub];
            NSString *urlStr = [NSString stringWithFormat:@"%@",resultDic[EntityKey][@"value"]];
            NSURL *url = [NSURL URLWithString:urlStr];
            [self.aboutUsWebView loadRequest:[NSURLRequest requestWithURL:url]];
            self.versionsLabel.text = [NSString stringWithFormat:@"当前版本号：%@",kVersion];
            
            
           

            
        }
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if ([self.typeCode isEqualToString:H5PAGETYPE_ABOUT_US]) {
        
        self.versionsLabel.hidden = NO;
        
    }else{
        
        self.versionsLabel.hidden = YES;
    }
     [self.view addSubview:self.versionsLabel];
}
 



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
