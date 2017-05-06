//
//  XKJHOfflineOrderManageController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOfflineOrderManageController.h"
#import "UIViewController+SetProjectDefaultAttribute.h"
#import "HMSegmentedControl.h"
#import "HMSegmentedControl+setAttribute.h"
#import "XKJHOfflineOrderManageVCHelper.h"
@interface XKJHOfflineOrderManageController () {

    XKJHOfflineOrderManageVCHelper *_offLineVCHelper;

}

@property (nonatomic, strong)HMSegmentedControl *topBarHMSegmentedControl;

@end

@implementation XKJHOfflineOrderManageController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    
    [self _initTopBar];
    
    [self _initContentviewHelper];
}


#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setDefaultAttribute];
    [self setVCTtitle:@"线下订单管理"];
}

- (void)_initTopBar {
    _topBarHMSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部",@"已退款"]];
    _topBarHMSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _topBarHMSegmentedControl.frame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
    [_topBarHMSegmentedControl setDefaultAtrribute];
    [_topBarHMSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_topBarHMSegmentedControl];
}


-(void)_initContentviewHelper {
    
    _offLineVCHelper = [[XKJHOfflineOrderManageVCHelper alloc] initWithTableCount:_topBarHMSegmentedControl.sectionTitles.count vcRootView:self.view];
    [_offLineVCHelper clickTopbarAtIndex:0];
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_offLineVCHelper clickTopbarAtIndex:segmentedControl.selectedSegmentIndex];
    
}//点击上面的tabbar选项





@end
