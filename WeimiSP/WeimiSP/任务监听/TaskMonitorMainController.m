//
//  TaskMonitorMainController.m
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "TaskMonitorMainController.h"
#import "XKJHSlideSwitchView.h"
#import "MyTaskMonitorController.h"
#import "AcceptOrdeController.h"

#import "PersonalCenterViewController.h"

@interface TaskMonitorMainController ()<SUNSlideSwitchViewDelegate>

@end

@implementation TaskMonitorMainController

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:TRUE];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.slideSwitchView = [[XKJHSlideSwitchView alloc] initWithFrame:self.view.bounds];
    _slideSwitchView.displayTip = YES;
    _slideSwitchView.slideSwitchViewDelegate = self;
    [self.view addSubview:_slideSwitchView];

    self.myTaskMonitorController = [[PersonalCenterViewController alloc] init];
    self.myTaskMonitorController.title =  @"我";
    self.myTaskMonitorController.mainNavController = self.navigationController;

    self.acceptOrdeController = [[AcceptOrdeController alloc] init];
    self.acceptOrdeController.title =  @"接单";
    self.acceptOrdeController.mainNavController = self.navigationController;

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
    return 2;
}

- (UIViewController *)slideSwitchView:(XKJHSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.myTaskMonitorController;
    } else if (number == 1) {
        return self.acceptOrdeController;
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
        
        self.myTaskMonitorController.tableView.scrollsToTop = YES;
        self.acceptOrdeController.tableView.scrollsToTop = NO;

    } else if (number == 1) {
        self.myTaskMonitorController.tableView.scrollsToTop = NO;
        self.acceptOrdeController.tableView.scrollsToTop = YES;
    }
    
}

@end
