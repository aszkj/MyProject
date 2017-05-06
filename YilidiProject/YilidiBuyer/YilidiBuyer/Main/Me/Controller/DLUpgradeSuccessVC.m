//
//  DLUpgradeSuccessVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLUpgradeSuccessVC.h"
#import "DLMainTabBarController.h"
@interface DLUpgradeSuccessVC ()

@property (weak, nonatomic) IBOutlet UILabel *vipExperidateLabel;

@end

@implementation DLUpgradeSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"升级成功";
    [self _requestUserInfo];
}

- (void)_requestUserInfo {
    
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetUserInfo block:^(NSDictionary *resultDic, NSError *error) {
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        NSString *vipExpireDate;
        if (isEmpty(resultDic[EntityKey][@"vipExpireDate"])) {
            vipExpireDate = @"--";
        }else{
            vipExpireDate = resultDic[EntityKey][@"vipExpireDate"];
        }
        self.vipExperidateLabel.text = jFormat(@"有效期 %@",vipExpireDate);
    }];
    
}

- (void)goBack {
    [self _enterHomePage];
   
}

- (void)_enterHomePage {
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

@end
