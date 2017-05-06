//
//  MerchantPosterViewController.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/11/7.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantPosterViewController.h"
#import "MerchantPosterVCHelper.h"



@interface MerchantPosterViewController(){

    MerchantPosterVCHelper *_merchantPosterVCHelper;
}


@end

@implementation MerchantPosterViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];

}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    [_merchantPosterVCHelper clickTopbarAtIndex:self.topBarHMSegmentedControl.selectedSegmentIndex];

}

#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    self.topVCtitle = @"云e生公告";
    self.sectionTitles = @[@"运营商公告",@"云e生公告"];
    _merchantPosterVCHelper = [[MerchantPosterVCHelper alloc] initWithTableCount:2 vcRootView:self.view];
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {

    [_merchantPosterVCHelper clickTopbarAtIndex:segmentedControl.selectedSegmentIndex];
}



@end
