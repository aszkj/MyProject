//
//  DLClassificationVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLClassificationVC.h"
#import "HMSegmentedControl.h"
#import "GlobleConst.h"
#import "UIViewController+unLoginHandle.h"
#import "ProjectStandardUIDefineConst.h"
#import "DLGoodsClassView.h"
#import "DLBrandView.h"
#import <Masonry.h>
#import "UIViewController+showShopCartPage.h"
#import "DLGoodsSearchVC.h"
#import "AppLifeCycleLisner.h"
#import "BrandDataManager.h"

@interface DLClassificationVC ()

@property (weak, nonatomic) IBOutlet HMSegmentedControl *topBarView;

@property (nonatomic,strong) DLGoodsClassView *goodsClassView;

@property (nonatomic,strong) DLBrandView *brandView;

@property (nonatomic,strong) UIView *classRequestFailedView;

@end

@implementation DLClassificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initSegmented];
    
    self.goodsClassView.hidden = NO;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self _listenAppEnterForground];
    [self _configureBrandDataManager];
//    if (self.topBarView.selectedSegmentIndex == 0) {
        [self.goodsClassView requestClassDataConfigure];
//    }else {
        [self _requestHotBrandDataConfigure];
//    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _resetSelfView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
    [kNotification removeObserver:self];
}



-(void)_initSegmented {
    
    NSArray *topBarTitles = nil;
    topBarTitles = @[@"分类",@"品牌"];
    self.topBarView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topBarView.selectionIndicatorHeight = 2.0f;
    self.topBarView.font = kSystemFontSize(18);
    self.topBarView.sectionTitles = topBarTitles;
    self.topBarView.textColor = KTextColor;
    self.topBarView.selectedTextColor = KCOLOR_MAIN_TEXT;
    self.topBarView.selectionIndicatorColor = KCOLOR_PROJECT_RED;
    self.topBarView.selectedSegmentIndex=0;
    WEAK_SELF
    self.topBarView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.topBarView.indexChangeBlock = ^(NSInteger index){
        
        if (index ==0) {
            weak_self.goodsClassView.hidden = NO;
            weak_self.brandView.hidden = YES;
        }else{
            weak_self.goodsClassView.hidden = YES;
            weak_self.brandView.hidden = NO;
        }
    };
    
}

#pragma mark ---------------------Private Method------------------------------
- (void)_listenAppEnterForground {
    [[AppLifeCycleLisner sharedManager] listenAppEnterForeground:^{
        [self _resetSelfView];
    }];
}

- (void)_configureBrandDataManager {
    [[BrandDataManager sharedManager] startDownLoadBrandData];
}


- (void)_resetSelfView {
    /*这里为什么加上这个，是因为我们应用的tabbar是全部自己写的，而非系统的，隐藏tabbar和出现tabbar都是自己的方式在基类的viewWillAppear中实现，导致当时出现了一个问题，再从第一级push到第二级，再返回到第一级self.view向下扩展了tabbar的部分即扩展到了tabbar的底部，而我们需要的是在一级的时候self.view始终应该是在它的顶部的，所以此处做了这个特殊处理，让self.view始终在tabbar上面*/
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-49);
}

- (void)_requestHotBrandDataConfigure {
    if (_brandView) {
        [_brandView requestHotBrandDataConfigure];
    }
}

#pragma mark ---------------------PageNavigate Method------------------------------
- (void)_enterSearchPage {
    DLGoodsSearchVC *searchVC = [[DLGoodsSearchVC alloc] init];
    [self navigatePushViewController:searchVC animate:YES];
}



#pragma mark ---------------------ViewEvent Method------------------------------
- (IBAction)searchAction:(id)sender {
    
    [self _enterSearchPage];
    
}

#pragma mark ---------------------Setter/Getter Method------------------------------

-(DLGoodsClassView *)goodsClassView {

    if (!_goodsClassView) {
        _goodsClassView = BoundNibView(@"DLGoodsClassView", DLGoodsClassView);
        [self.view addSubview:_goodsClassView];
        [_goodsClassView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.top.mas_equalTo(100);
        }];
        WEAK_SELF
        WEAK_OBJ(_classRequestFailedView)
        _goodsClassView.classRequestFailedBlock = ^(BOOL classRequestFailed){
            if (!classRequestFailed) {//正常情况，请求成功
                if (weak__classRequestFailedView && !weak__classRequestFailedView.hidden) {
                    weak__classRequestFailedView.hidden = YES;
                }
            }else {
                weak_self.classRequestFailedView.hidden = NO;
            }
        };
    }
    return _goodsClassView;

}

-(DLBrandView *)brandView {
    
    if (!_brandView) {
        _brandView = BoundNibView(@"DLBrandView", DLBrandView);
        [_brandView setShowType:@"hotBrand"];
        
        [self.view addSubview:_brandView];
        [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.top.mas_equalTo(100);
        }];
    }
    return _brandView;
    
}

- (UIView *)classRequestFailedView {
    if (!_classRequestFailedView) {
        _classRequestFailedView = BoundNibView(@"ClassRequestFailedView", UIView);
        [self.view addSubview:_classRequestFailedView];
        [_classRequestFailedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _classRequestFailedView;
}



@end
