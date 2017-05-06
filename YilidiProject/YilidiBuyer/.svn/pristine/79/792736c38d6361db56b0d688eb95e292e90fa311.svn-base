//
//  DLGoodsSecondLevelClassController.m
//  YilidiBuyer
//
//  Created by mm on 16/12/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsThirdLevelClassController.h"
#import "JJScrollMenu.h"
#import "DLGoodsThirdLevelClassChildController.h"
#import "DLGoodsThirdLevelClassChildController.h"
#import "GlobleConst.h"
#import "SGTopTitleView.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
#import "DLGoodsThirdLevelClassChildController.h"
#import "HMSegmentedControl.h"
#import "ProjectStandardUIDefineConst.h"
#import "HMSegementController.h"
#import "GoodsClassModel.h"
#import "NSArray+SUIAdditions.h"
#import "ShopCartView.h"
#import <Masonry.h>
#import "DLShopCarVC.h"
#import "UIViewController+unLoginHandle.h"
#import "HMSegmentedControl+setAttribute.h"

@interface DLGoodsThirdLevelClassController ()<SGTopTitleViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic,strong)JJScrollMenu *menu;
@property (strong, nonatomic) ShopCartView *shopCartView;

@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;



@end

@implementation DLGoodsThirdLevelClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.titles = @[@"优惠券(21)", @"代金券(0)", @"实物券(10)",@"优惠券(21)", @"代金券(0)", @"321323"];
    [self _setTitle];
    
    [self _createSegementControll];
    
    [self _creatHMSegementController];
    
    [self _initShopCartView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.topBarController setSegementIndex:[self _getDefaultSelectIndex] animated:YES];
    

}

- (void)_initShopCartView {
    self.shopCartView.hidden = NO;
}

- (void)_setTitle {
    
    NSString *pageTitle = nil;
    if (self.goodsClassModel.subClassList.count == 1) {
            GoodsClassModel *goodsClassModel = self.goodsClassModel.subClassList.firstObject;
            pageTitle = goodsClassModel.className;
    }else {
            pageTitle = self.goodsClassModel.className;
    }
    self.pageTitle = pageTitle;
}


- (void)_createSegementControll {
    NSArray *classNames = [self _getClassNames];
    self.topBarControl = [[HMSegmentedControl alloc] initWithSectionTitles:classNames];
    [self.view addSubview:self.topBarControl];
    self.topBarControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    self.topBarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topBarControl.selectionIndicatorHeight = 2.0f;
//    [self _calAndSetTopBarDisplayWidthStyle];
    [self.topBarControl autoAdapTitleWidthStyle];
    self.topBarControl.font = [UIFont fontWithName:@"Heiti SC" size:16.0f];
    self.topBarControl.textColor = KCOLOR_NOMAL_TEXT;
    self.topBarControl.selectedTextColor = KCOLOR_PROJECT_RED;
    self.topBarControl.selectionIndicatorColor = KCOLOR_PROJECT_RED;
}

- (void)_calAndSetTopBarDisplayWidthStyle {
    
    CGFloat topTitleTotalWidth = 0.0f;
    UIFont *calFont = self.topBarControl.font;
    for (NSString *titleString in self.topBarControl.sectionTitles) {
        CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: calFont}].width + 10;
        topTitleTotalWidth += stringWidth;
    }
    self.topBarControl.segmentWidthStyle = topTitleTotalWidth < kScreenWidth ? HMSegmentedControlSegmentWidthStyleFixed : HMSegmentedControlSegmentWidthStyleDynamic;

}



- (void)_creatHMSegementController {
    CGFloat topControlY,childControllerHeight;
    if ([self _TopThirdGoodsClassBarControlShow]) {
        childControllerHeight = kScreenHeight-kNavBarAndStatusBarHeight-44;
        topControlY = 44;
    }else {
        childControllerHeight = kScreenHeight-kNavBarAndStatusBarHeight;
        topControlY = 0;
    }
    WEAK_SELF
    self.topBarController = [[HMSegementController alloc] initWithSegementControl:self.topBarControl segementControllerFrame:CGRectMake(0, topControlY, kScreenWidth, childControllerHeight) childSegementControllClass:[DLGoodsThirdLevelClassChildController class] childControllersCompletedAddedBlock:^(NSArray *childControllers) {
        [weak_self _assignClassCodeForChildVcs:childControllers];

    }];
    self.topBarController.indexChangeBlock = ^(NSInteger index, UIViewController *childVc){
        DLGoodsThirdLevelClassChildController *childVCR = (DLGoodsThirdLevelClassChildController *)childVc;
    };
//    [self.topBarController setSegementIndex:[self _getDefaultSelectIndex] animated:YES];
    
    [self _dealClassCodeDataAndUi];
}

- (void)_assignClassCodeForChildVcs:(NSArray *)chilVcs {
    NSArray *classCodes = [self _getClassCodes];
    for (NSInteger i=0; i<chilVcs.count; i++) {
        DLGoodsThirdLevelClassChildController *vc = (DLGoodsThirdLevelClassChildController *)chilVcs[i];
        vc.classCode = classCodes[i];
    }
}


- (void)_dealClassCodeDataAndUi {
    BOOL TopThirdGoodsClassBarControlShow = [self _TopThirdGoodsClassBarControlShow];
    [self _showTopThirdGoodsClassBarControl:TopThirdGoodsClassBarControlShow];
}

- (BOOL)_TopThirdGoodsClassBarControlShow {
    if (!self.goodsClassModel.subClassList.count) {
        return NO;
    }else if (self.goodsClassModel.subClassList.count == 1){
        return NO;
    }
    return YES;
}

- (void)_showTopThirdGoodsClassBarControl:(BOOL)show {
    CGRect frame = CGRectZero;
    if (show) {
        self.topBarControl.hidden = NO;
        frame = CGRectMake(0, 0, kScreenWidth, 44);
    }else {
        self.topBarControl.hidden = YES;
        frame = CGRectMake(0, 0, kScreenWidth, 0);
    }
    self.topBarControl.frame = frame;
}

#pragma mark ---------------------PageNavigate Method------------------------------

#pragma mark ---------------------Setter/Getter Method------------------------------
- (NSArray *)_getClassNames {
    if (!self.goodsClassModel.subClassList.count) {
        return @[self.goodsClassModel.className];
    }else {
        return [self.goodsClassModel.subClassList sui_map:^id _Nonnull(GoodsClassModel *obj, NSUInteger index) {
            return obj.className;
        }];
    }
}

- (NSArray *)_getClassCodes {
    if (!self.goodsClassModel.subClassList.count) {
        return @[self.goodsClassModel.classCode];
    }else {
        return [self.goodsClassModel.subClassList sui_map:^id _Nonnull(GoodsClassModel *obj, NSUInteger index) {
            return obj.classCode;
        }];
    }
}

- (NSInteger)_getDefaultSelectIndex {
    if (isEmpty(self.goodsClassChildModel)) {
        return 0;
    }else {
        return [self.goodsClassModel.subClassList indexOfObject:self.goodsClassChildModel];
    }
}

- (ShopCartView *)shopCartView {
    if (!_shopCartView) {
        _shopCartView = [[ShopCartView alloc] init];
        [self.view addSubview:_shopCartView];
        [_shopCartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.bottom.mas_equalTo(-34);
            make.right.mas_equalTo(-58);
        }];
    }
    return _shopCartView;
}




@end
