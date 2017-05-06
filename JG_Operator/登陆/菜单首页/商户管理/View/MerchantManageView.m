//
//  MerchantManageView.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MerchantManageView.h"


@implementation MerchantManageView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initTopBar];
        [self _initContentView];
//        [_merchantManagerHelper clickTopbarAtIndex:self.topBarHMSegmentedControl.selectedSegmentIndex];
    }
    return self;
}

-(void)setMerchantType:(MerchantType)merchantType {
    _merchantType = merchantType;
    _merchantManagerHelper.merchantType = merchantType;
    [_merchantManagerHelper clickTopbarAtIndex:self.topBarHMSegmentedControl.selectedSegmentIndex];
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
#pragma mark - 不能放在这个方法里面，会走两次
//    [_merchantManagerHelper clickTopbarAtIndex:self.topBarHMSegmentedControl.selectedSegmentIndex];
}


#pragma mark ----------------------- private Method -----------------------
-(void)_initTopBar {

    _topBarHMSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"总统计",@"周统计",@"月统计",@"季统计",@"年统计"]];
    _topBarHMSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _topBarHMSegmentedControl.frame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
    [_topBarHMSegmentedControl setDefaultAtrribute];
    [_topBarHMSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_topBarHMSegmentedControl];
}

-(void)_initContentView {

    _merchantManagerHelper = [[MerchantManagerHelper alloc] initWithTableCount:_topBarHMSegmentedControl.sectionTitles.count vcRootView:self];
}


#pragma mark ----------------------- Action Method -----------------------
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [_merchantManagerHelper clickTopbarAtIndex:segmentedControl.selectedSegmentIndex];
    
}//点击上面的tabbar选项



@end
