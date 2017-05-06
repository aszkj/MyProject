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

@interface DLAboutUsVC ()

@property (weak, nonatomic) IBOutlet UIWebView *aboutUsWebView;
@end

@implementation DLAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    
    [self _loadAboutUs];
}

-(void)_init {
    
    
    self.aboutUsWebView.scrollView.backgroundColor = [UIColor whiteColor];
}


- (void)_loadAboutUs {
    
    NSDictionary *parameters = @{@"type":self.type};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_Setting block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code!=1) {
            [self hideLoadingHub];
            return;
        }else{
            
            [self hideLoadingHub];
            NSString *urlStr = [NSString stringWithFormat:@"%@",resultDic[EntityKey][@"value"]];
            NSURL *url = [NSURL URLWithString:urlStr];
            [self.aboutUsWebView loadRequest:[NSURLRequest requestWithURL:url]];
            
        }
    }];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
