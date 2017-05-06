//
//  XKJHOnlineOrderIncomeDetailController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOnlineOrderIncomeDetailController.h"
#import "HMSegmentedControl.h"
#import "HMSegmentedControl+setAttribute.h"
#import "XKJHOnlineOrderIncomeVCHelper.h"


@interface XKJHOnlineOrderIncomeDetailController () {

    XKJHOnlineOrderIncomeVCHelper *_orderIncomeVCHelper;

}

@property (nonatomic, strong)HMSegmentedControl *topBarHMSegmentedControl;

@end

@implementation XKJHOnlineOrderIncomeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    //tobbar
    [self _initTopBar];
    
    //contentView
    [self _initContentviewHelper];
    
}

#pragma mark ----------------------- Private Method -----------------------
- (void)_init {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [Util setNavTitleWithTitle:@"线上服务订单管理" ofVC:self];
}


- (void)_initTopBar {
    _topBarHMSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部",@"未付款",@"未消费",@"已消费",@"已取消"]];
    _topBarHMSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _topBarHMSegmentedControl.frame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
    [_topBarHMSegmentedControl setDefaultAtrribute];
    [_topBarHMSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_topBarHMSegmentedControl];
}


-(void)_initContentviewHelper {
    
    _orderIncomeVCHelper = [[XKJHOnlineOrderIncomeVCHelper alloc] initWithTableCount:_topBarHMSegmentedControl.sectionTitles.count vcRootView:self.view];
    [_orderIncomeVCHelper clickTopbarAtIndex:0];
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_orderIncomeVCHelper clickTopbarAtIndex:segmentedControl.selectedSegmentIndex];
    
}//点击上面的tabbar选项



@end
