//
//  XKJHCommentManageMentController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHCommentManageMentController.h"
#import "HMSegmentedControl.h"
#import "HMSegmentedControl+setAttribute.h"
#import "XKJHCommentManageMentVCHelper.h"

@interface XKJHCommentManageMentController () {

    HMSegmentedControl *_topBarHMSegmentedControl;
    XKJHCommentManageMentVCHelper *_commentManageMentVCHelper;
}


@end

@implementation XKJHCommentManageMentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTopBar];
    
    [self _initContentviewHelper];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //每次页面即将出现的时候，刷新当前选中的表，因为可能有更新
    [_commentManageMentVCHelper clickTopbarAtIndex:_topBarHMSegmentedControl.selectedSegmentIndex];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    //每次页面即将消失的时候，冲洗置位当前选中的表的自动刷新，因为页面重新出现后可能有更新
    [_commentManageMentVCHelper resetTableFinishedAutoFreshAtIndex:_topBarHMSegmentedControl.selectedSegmentIndex];
}


#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    [self setDefaultAttribute];
    [self setVCTtitle:@"评价管理"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)_initTopBar {
    _topBarHMSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部",@"未回复",@"已回复"]];
    _topBarHMSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _topBarHMSegmentedControl.frame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
    [_topBarHMSegmentedControl setDefaultAtrribute];
    [_topBarHMSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_topBarHMSegmentedControl];
}

-(void)_initContentviewHelper {
    
    _commentManageMentVCHelper = [[XKJHCommentManageMentVCHelper alloc] initWithTableCount:_topBarHMSegmentedControl.sectionTitles.count vcRootView:self.view];
//    [_commentManageMentVCHelper clickTopbarAtIndex:0];
}


#pragma mark ----------------------- Action Method ------------------------
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_commentManageMentVCHelper clickTopbarAtIndex:segmentedControl.selectedSegmentIndex];
    
}//点击上面的tabbar选项


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}






@end
