//
//  DLOrderListVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderListVC.h"
#import "HMSegmentedControl.h"
#import "DLOrderlistVCTopHelper.h"
#import "UIViewController+showShopCartPage.h"
#import "DLAllOrderVC.h"
#import "GlobleConst.h"
@interface DLOrderListVC ()

@property (weak, nonatomic) IBOutlet HMSegmentedControl *topBarView;

@property (nonatomic, strong)DLOrderlistVCTopHelper *orderListTopHelper;
@end

@implementation DLOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTopViewHelper];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self registerShowShowCartPageNotification];
    [self.orderListTopHelper clickTopbarAtIndex:self.topBarView.selectedSegmentIndex];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [kNotification removeObserver:self];
}



#pragma mark -------------------Private Method----------------------
-(void)_init {
    NSArray *topBarTitles = nil;
    topBarTitles = @[@"待付款",@"待收货",@"已完成",@"退款"];
    self.pageTitle = @"我的订单";
    self.topBarView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topBarView.selectionIndicatorHeight = 2.0f;
    self.topBarView.selectionIndicatorColor = KSelectedBgColor;
    self.topBarView.font = kSystemFontSize(14);
    self.topBarView.sectionTitles = topBarTitles;
    self.topBarView.textColor = [UIColor darkGrayColor];
    self.topBarView.selectedTextColor = KSelectedBgColor;
    [self _initRightAllOrderItem];
}

-(void)_initRightAllOrderItem {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"全部订单" titleColor:[UIColor whiteColor] target:self action:@selector(allOrder)];
    UIButton *rightItemButton = (UIButton *)rightItem.customView;
    [rightItemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem barButtonItemSpace:-12],rightItem];
    
}



- (void)_initTopViewHelper {
    
    self.orderListTopHelper = [[DLOrderlistVCTopHelper alloc] initWithTableCount:self.topBarView.sectionTitles.count vcRootView:self.view];
    self.orderListTopHelper.orderListVC = self;
}

- (IBAction)topBarSelectAction:(id)sender {
    HMSegmentedControl *segeMentControl = (HMSegmentedControl *)sender;
    [self.orderListTopHelper clickTopbarAtIndex:segeMentControl.selectedSegmentIndex];
}

- (void)allOrder{
    DLAllOrderVC *allOrderVC = [[DLAllOrderVC alloc] init];
    [self navigatePushViewController:allOrderVC animate:YES];
}

@end
