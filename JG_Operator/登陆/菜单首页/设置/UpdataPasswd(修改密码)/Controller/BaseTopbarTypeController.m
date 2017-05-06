//
//  BaseTopbarTypeController.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "BaseTopbarTypeController.h"

@interface BaseTopbarTypeController ()

@end

@implementation BaseTopbarTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initVCAttribute];
    
    [self _initTopBar];
    
}

#pragma mark ----------------------- private Method -----------------------

- (void)_initVCAttribute {
    
    [self setDefaultAttribute];
}


- (void)_initTopBar {
    _topBarHMSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:nil];
    _topBarHMSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _topBarHMSegmentedControl.frame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
    [_topBarHMSegmentedControl setDefaultAtrribute];
    [_topBarHMSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_topBarHMSegmentedControl];
}

-(void)_displayOrHiddenContentViewWithSelectIndex:(NSInteger)selectedIndex {

    UIView *lastDisplayView = [Util getDisplayedViewAtViewArrs:_contentViewsArr];
    lastDisplayView.hidden = YES;
    
    UIView *willShowView = (UIView *)[_contentViewsArr objectAtIndex:selectedIndex];
    willShowView.hidden = NO;

}


#pragma mark ----------------------- Action Method ------------------------
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    [self _displayOrHiddenContentViewWithSelectIndex:segmentedControl.selectedSegmentIndex];
    
}//点击上面的tabbar选项


#pragma mark ----------------------- Setter Method -----------------------
-(void)setTopVCtitle:(NSString *)topVCtitle {

    [self setVCTtitle:topVCtitle];
}



-(void)setSectionTitles:(NSArray *)sectionTitles {

    _topBarHMSegmentedControl.sectionTitles = sectionTitles;
}


#pragma mark ----------------------- 子类调用-----------------------
-(UIView *)loadContentViewWithName:(NSString *)viewName {

    UIView *contentView = BoundNibView(viewName, UIView);
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(kTopBarHeight);
    }];
    
    return contentView;
}



@end
