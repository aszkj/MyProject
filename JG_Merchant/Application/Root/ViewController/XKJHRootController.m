//
//  XWJHRootController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHRootController.h"
#import "XKJHHomePageController.h"
//#import "XKJHOrderManagementController.h"
#import "XKJHOrderCouponListViewController.h"
#import "XKJHMemberLIitViewController.h"
#import "XKJHWalletController.h"
#import "XKJHNavRootController.h"
#import "XKJHBaseNavigationBar.h"
#import "ServiceManagerViewController.h"
#import "APService.h"

@interface XKJHRootController ()
{
    NSInteger _lastSelectIndex;
}

@property(nonatomic,strong)UINavigationController *navHomePage;
@property(nonatomic,strong)UINavigationController *navOrderManager;
@property(nonatomic,strong)UINavigationController *navMemberManager;
@property(nonatomic,strong)UINavigationController *navServiceManager;
@property(nonatomic,strong)UINavigationController *navWallet;
@property(nonatomic,assign)BOOL isLogin;

@end

@implementation XKJHRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)init
{
    if (self = [super init]) {
        self.isLogin = NO;
        [self.tabBar setSelectedImageTintColor:UIColorFromRGB(0x4ab6ec)];
        XKJHHomePageController *homePageControl = [[XKJHHomePageController alloc] initWithNibName:@"XKJHHomePageController" bundle:nil];
        
        UINavigationController *navHomePage = [[XKJHNavRootController alloc] initWithNavigationBarClass:[XKJHBaseNavigationBar class] toolbarClass:nil];
        navHomePage.viewControllers = @[homePageControl];
        navHomePage.tabBarItem.image = [UIImage imageNamed:@"Home1"];
        [self setNavHomePage:navHomePage];
        navHomePage.title = @"首页";
        
        XKJHOrderCouponListViewController *orderManagementControl = [[XKJHOrderCouponListViewController alloc] initWithNibName:@"XKJHOrderCouponListViewController" bundle:nil];
        UINavigationController *navOrderManagement = [[XKJHNavRootController alloc] initWithNavigationBarClass:[XKJHBaseNavigationBar class] toolbarClass:nil];
        navOrderManagement.viewControllers = @[orderManagementControl];
        navOrderManagement.tabBarItem.image = [UIImage imageNamed:@"Order Management"];
        [self setNavOrderManager:navOrderManagement];
        navOrderManagement.title = @"订单管理";
        
        XKJHMemberLIitViewController *memberManagementControl = [[XKJHMemberLIitViewController alloc] initWithNibName:@"XKJHMemberLIitViewController" bundle:nil];
        UINavigationController *navMemberManagement = [[XKJHNavRootController alloc] initWithNavigationBarClass:[XKJHBaseNavigationBar class] toolbarClass:nil];
        navMemberManagement.viewControllers = @[memberManagementControl];
        navMemberManagement.tabBarItem.image = [UIImage imageNamed:@"Member Management"];
        [self setNavMemberManager:navMemberManagement];
        navMemberManagement.title = @"会员管理";
        
        ServiceManagerViewController *serviceControl = [[ServiceManagerViewController alloc] init];
        UINavigationController *navService = [[XKJHNavRootController alloc] initWithNavigationBarClass:[XKJHBaseNavigationBar class] toolbarClass:nil];
        navService.viewControllers = @[serviceControl];
        navService.tabBarItem.image = [UIImage imageNamed:@"service_icon"];
        [self setNavServiceManager:navService];
        navService.title = @"服务管理";
        
        XKJHWalletController *walletControl = [[XKJHWalletController alloc] init];
        UINavigationController *navWallet = [[XKJHNavRootController alloc] initWithNavigationBarClass:[XKJHBaseNavigationBar class] toolbarClass:nil];
        navWallet.viewControllers = @[walletControl];
        navWallet.tabBarItem.image = [UIImage imageNamed:@"Wallet"];
        [self setNavWallet:navWallet];
        navWallet.title = @"钱包";
        
        NSArray *barViewControllers = [NSArray arrayWithObjects:navHomePage,navOrderManagement,navMemberManagement,navService,navWallet,nil];
        
        [self setViewControllers:barViewControllers];
        
        [self setSelectedIndex:0];
        
        self.navigationItem.title = @"首页";
        
        self.view.backgroundColor = background_Color;

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        self.view.backgroundColor = background_Color;
        

    }
    return self;
}





@end
