//
//  DLPayWayVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/6/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLPayWayVC.h"

@interface DLPayWayVC ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DLPayWayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    
    [self _loadWebView];
}

-(void)_init {
    
    
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
}


- (void)_loadWebView {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,_strUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
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
