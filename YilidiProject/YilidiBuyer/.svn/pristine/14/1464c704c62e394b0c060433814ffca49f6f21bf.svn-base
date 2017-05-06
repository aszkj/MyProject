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
#import "GlobleConst.h"
#import "DLOrderCommentVC.h"
#import "ProjectStandardUIDefineConst.h"
#import "DLRefundOrderVC.h"
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
    [self.orderListTopHelper clickTopbarAtIndex:self.topBarView.selectedSegmentIndex];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [kNotification removeObserver:self];
}



#pragma mark -------------------Private Method----------------------
-(void)_init {
    NSArray *topBarTitles = nil;
    topBarTitles = @[@"全部订单",@"待付款",@"待收货",@"待评价"];
    self.pageTitle = @"我的订单";
    self.topBarView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topBarView.selectionIndicatorHeight = 2.0f;
    self.topBarView.selectionIndicatorColor = KCOLOR_PROJECT_RED;
    self.topBarView.font = kSystemFontSize(14);
    self.topBarView.sectionTitles = topBarTitles;
    self.topBarView.selectedSegmentIndex = self.defaultSelectOrderStatusNumber;
    self.topBarView.textColor = KTextColor;
    self.topBarView.selectedTextColor = KCOLOR_PROJECT_RED;
    [self _initRightAllOrderItem];
}

-(void)_initRightAllOrderItem {
    
    UIBarButtonItem *rightItem = [UIBarButtonItem initWithTitle:@"退款" titleColor:[UIColor whiteColor] target:self action:@selector(enterRefoundOrderPage)];
    UIButton *rightItemButton = (UIButton *)rightItem.customView;
    [rightItemButton setTitleColor:KTextColor forState:UIControlStateNormal];
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

- (void)enterRefoundOrderPage{
    
    DLRefundOrderVC *allOrderVC = [[DLRefundOrderVC alloc] init];
    [self navigatePushViewController:allOrderVC animate:YES];
}

@end
