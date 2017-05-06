//
//  PushNofiticationController.m
//  jingGang
//
//  Created by HanZhongchou on 16/1/18.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "PushNofiticationController.h"
#import "GlobeObject.h"
@interface PushNofiticationController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@property (weak, nonatomic) IBOutlet UILabel *tittleLabel;
/**
 *  标题背景view
 */
@property (weak, nonatomic) IBOutlet UIView *titleLabelBgView;
/**
 *  标题lebal距离顶部的高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTittleTopHeight;
/**
 *  标题label距离底部的高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableTittleBottomHeight;

@end

@implementation PushNofiticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    self.navigationItem.title = @"云e生";
    self.webView.delegate = self;
    if (self.strControllerTitle) {
        self.tittleLabel.text = self.strControllerTitle;
    }else{
        self.labelTittleTopHeight.constant = 0.0;
        self.lableTittleBottomHeight.constant = 0.0;
    }
    
    
    NSString *strUrl;
    if (self.urlType == RichTextlControllerType) {//富文本链接
        strUrl = [NSString stringWithFormat:@"%@/messgae_get_content.htm?id=%@",Shop_url,self.strUrlID];
    }else if (self.urlType == InterLinkageControllerType){//链接
        strUrl = self.strPushUrl;
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    
    
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view from its nib.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
    [self hideHubWithOnlyText:@"网络错误，请检查网络"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
