//
//  XKJHPackageManagerController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHPackageManagerController.h"
#import "XKJHSlideSwitchView.h"
#import "XKJHAddShelfController.h"
#import "XKJHOffShelfController.h"
#import "XKJHViolateShelfController.H"
#import "XKJHServiceDetailController.h"
@class AddShelfController;
@class OffShelfController;
@class ViolationShelfController;
@interface XKJHPackageManagerController ()<SUNSlideSwitchViewDelegate>

@end

@implementation XKJHPackageManagerController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.requestType == TicketManagerPackageType) {
        self.title = @"套餐券管理";
    } else if (self.requestType == TicketManagerCashType) {
        self.title = @"现金券管理";
    }
    
    self.slideSwitchView = [[XKJHSlideSwitchView alloc] initWithFrame:self.view.bounds];
    _slideSwitchView.displayTip = YES;
    _slideSwitchView.slideSwitchViewDelegate = self;
    [self.view addSubview:_slideSwitchView];
        
    self.addShelfController = [[XKJHAddShelfController alloc] init];
    self.addShelfController.title =  @"已上架";
    self.addShelfController.mainNavController = self.navigationController;
    self.addShelfController.requestType = self.requestType;
    
    self.offShelfController = [[XKJHOffShelfController alloc] init];
    self.offShelfController.title = @"已下架";
    self.offShelfController.mainNavController = self.navigationController;
    self.offShelfController.requestType = self.requestType;

    self.violateShelfController = [[XKJHViolateShelfController alloc] init];
    self.violateShelfController.title = @"违规下架";
    self.violateShelfController.mainNavController = self.navigationController;
    self.violateShelfController.requestType = self.requestType;

    [self.slideSwitchView buildUI];
    [self.slideSwitchView setDefauletViewFromIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SUNSlideSwitchViewDelegate(滑动tab视图代理方法)
- (NSUInteger)numberOfTab:(XKJHSlideSwitchView *)view
{
    return 3;
}

- (UIViewController *)slideSwitchView:(XKJHSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.addShelfController;
    } else if (number == 1) {
        return self.offShelfController;
    } else if (number == 2) {
        return self.violateShelfController;
    } else {
        return nil;
    }
}

- (void)slideSwitchViewStartScroll
{
    
}

- (void)slideSwitchView:(XKJHSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    if (number == 0) {
        self.addShelfController.tableView.scrollsToTop = YES;
        self.offShelfController.tableView.scrollsToTop = NO;
        self.violateShelfController.tableView.scrollsToTop = NO;
    }
    else if (number == 1) {
        self.addShelfController.tableView.scrollsToTop = NO;
        self.offShelfController.tableView.scrollsToTop = YES;
        self.violateShelfController.tableView.scrollsToTop = NO;
    }
    else if (number == 2) {
        self.addShelfController.tableView.scrollsToTop = NO;
        self.offShelfController.tableView.scrollsToTop = NO;
        self.violateShelfController.tableView.scrollsToTop = YES;
    }
}

@end
