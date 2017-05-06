//
//  DLBrandGoodsManageVC.m
//  YilidiSeller
//
//  Created by mm on 17/1/9.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLBrandGoodsManageVC.h"
#import "SegementView.h"
#import "ClassifitionGoodsManageView.h"
#import <Masonry/Masonry.h>
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "GlobleConst.h"

@interface DLBrandGoodsManageVC ()

@property (nonatomic, strong)ClassifitionGoodsManageView *onShelfGoodsView;

@property (nonatomic, strong)ClassifitionGoodsManageView *offShelfGoodsView;

@property (nonatomic, strong)SegementView *onOffShelfSwitchView;


@end

@implementation DLBrandGoodsManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.showNavbarBottomLine = NO;
    self.pageTitle = self.brandName;
    
    [self _loadSegementView];
    
    [self _initOnShelfView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navBarColor = KSelectedBgColor;
    self.backIconName = @"返回箭头白色";
    self.titleColor = [UIColor whiteColor];
}


- (void)_loadSegementView {
    UIView *segementBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [self.view addSubview:segementBgView];
    segementBgView.backgroundColor = KSelectedBgColor;
    self.onOffShelfSwitchView = [[SegementView alloc] initWithSegementFrame:CGRectMake((kScreenWidth-156)/2, (40-30)/2, 168, 28) segementTitles:@[@"销售中",@"已下架"]];
    [segementBgView addSubview:self.onOffShelfSwitchView];
    WEAK_SELF
    self.onOffShelfSwitchView.selectedSegementBlock = ^(NSInteger selectIndex){
        if (selectIndex == 0) {
            weak_self.onShelfGoodsView.hidden = NO;
            weak_self.offShelfGoodsView.hidden = YES;
        }else {
            weak_self.onShelfGoodsView.hidden = YES;
            weak_self.offShelfGoodsView.hidden = NO;
        }
    };

    
}

- (void)_initOnShelfView {
    self.onShelfGoodsView.hidden = NO;
    self.onOffShelfSwitchView.selectedSegementIndex = 0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ClassifitionGoodsManageView *)onShelfGoodsView {
    
    if (!_onShelfGoodsView) {
        _onShelfGoodsView = BoundNibView(@"ClassifitionGoodsManageView", ClassifitionGoodsManageView);
        [self.view addSubview:_onShelfGoodsView];
        [_onShelfGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.bottom.right.mas_equalTo(self.view);
        }];
        _onShelfGoodsView.updateDataJustByShelfNumber = YES;
        _onShelfGoodsView.brandCode = self.brandCode;
        _onShelfGoodsView.shelfNumber = @(kShelfNumberOnShelf);
        
    }
    return _onShelfGoodsView;
    
}

- (ClassifitionGoodsManageView *)offShelfGoodsView {
    
    if (!_offShelfGoodsView) {
        _offShelfGoodsView = BoundNibView(@"ClassifitionGoodsManageView", ClassifitionGoodsManageView);
        [self.view addSubview:_offShelfGoodsView];
        [_offShelfGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.bottom.right.mas_equalTo(self.view);
        }];
        _offShelfGoodsView.updateDataJustByShelfNumber = YES;
        _offShelfGoodsView.brandCode = self.brandCode;
        _offShelfGoodsView.shelfNumber = @(kShelfNumberOffShelf);
    }
    return _offShelfGoodsView;
}


@end
