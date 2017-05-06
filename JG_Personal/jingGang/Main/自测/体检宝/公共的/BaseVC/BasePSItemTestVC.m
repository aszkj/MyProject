//
//  BasePSItemTestVC.m
//  jingGang
//
//  Created by 张康健 on 15/7/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BasePSItemTestVC.h"
#import "HMSegmentedControl.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Util.h"
#import "UIViewExt.h"

@interface BasePSItemTestVC ()

@property (nonatomic, strong)HMSegmentedControl *topBarHMSegmentedControl;

@end

@implementation BasePSItemTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
#warning 子类调用警告
    //子类调用super viewDidLoad之前先初始化自己的一些属性，，因为这些属性在父类也即是本类的一些初始化中需要用到
    [self _initNavView];
    
    [self _initTopTabar];
    
    [self _initContentView];
    

}

#pragma mark ------------- private Method -------------
-(void)_initNavView{

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(navBack) target:self];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:18.0];
    titleLable.text = _navTitle;
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;

}

- (void)_initTopTabar {
    
    _topBarHMSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:_tabbarTitles];
    _topBarHMSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    _topBarHMSegmentedControl.frame = CGRectMake(0, 64, kScreenWidth, kTopBarHeight);
    
    _topBarHMSegmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _topBarHMSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _topBarHMSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _topBarHMSegmentedControl.selectionIndicatorColor = kGetColor(94, 180, 231);
    _topBarHMSegmentedControl.selectedTextColor = kGetColor(94, 180, 231);
    _topBarHMSegmentedControl.font = [UIFont systemFontOfSize:16];
    _topBarHMSegmentedControl.selectionIndicatorHeight = 4.0f;
    [_topBarHMSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_topBarHMSegmentedControl];
}

-(void)_initContentView{
    
    _contentViewArrs = [NSMutableArray arrayWithCapacity:_topBarHMSegmentedControl.sectionTitles.count];
    for (int i=0; i<_topBarHMSegmentedControl.sectionTitles.count; i++) {
        UIView *contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:contentView];
        contentView.top = 64 + kTopBarHeight;
        if (i){//不是第一个，将其隐藏,默认选中的是第一个
            contentView.hidden = YES;
        }
        [_contentViewArrs addObject:contentView];
    }
    
    //如果是只有两个contentView的话
    if (_contentViewArrs.count == 2) {
        _firstContentView = (UIView *)_contentViewArrs[0];
        _secondContentView = (UIView *)_contentViewArrs[1];
    }
    
}



#pragma mark ------------- action Method 供子类重写-------------
-(void)navBack{

    [self.navigationController popViewControllerAnimated:YES];

}//导航返回,如果需要传值之类可重写

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {

    //找到之前显示的view，将其隐藏
    UIView *lastDisplayedView = [Util getDisplayedViewAtViewArrs:_contentViewArrs];
    lastDisplayedView.hidden = YES;
    
    //显示选中的index对应的contentView
    UIView *willDisplayedView = [_contentViewArrs objectAtIndex:segmentedControl.selectedSegmentIndex];
    willDisplayedView.hidden = NO;
    
}//点击上面的tabbar选项


@end
