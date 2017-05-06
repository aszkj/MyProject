//
//  DLGoodsManageMentVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsManageMentVC.h"
#import "SegementView.h"
#import "GoodsManageView.h"
#import <Masonry/Masonry.h>
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLSearchVC.h"
#import "GlobleConst.h"

@interface DLGoodsManageMentVC ()

@property (nonatomic, strong)GoodsManageView *onShelfGoodsView;

@property (nonatomic, strong)GoodsManageView *offShelfGoodsView;

@property (nonatomic, strong)SegementView *onOffShelfSwitchView;

@end

@implementation DLGoodsManageMentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initOnOffShelfSwitchView];
    
    [self _initOnShelfView];
}


#pragma mark -------------------Init Method----------------------
-(void)_init {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"搜索白" target:self action:@selector(searchGoods)];
}

-(void)_initOnOffShelfSwitchView {
    
    self.onOffShelfSwitchView = [[SegementView alloc] initWithSegementFrame:CGRectMake(0, 0, 156, 30) segementTitles:@[@"销售中",@"已下架"]];
    self.navigationItem.titleView = self.onOffShelfSwitchView;
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
}

#pragma mark -------------------Action Method----------------------
- (void)searchGoods {
    DLSearchVC *goodsSearchVC = [[DLSearchVC alloc] init];
    goodsSearchVC.searchType = SearchType_Goods;
    [self navigatePushViewController:goodsSearchVC animate:YES];
}

#pragma mark -------------------Setter/Getter Method----------------------
- (GoodsManageView *)onShelfGoodsView {

    if (!_onShelfGoodsView) {
        _onShelfGoodsView = BoundNibView(@"GoodsManageView", GoodsManageView);
        [self.view addSubview:_onShelfGoodsView];
        [_onShelfGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        _onShelfGoodsView.shelfNumber = @(kShelfNumberOnShelf);

    }
    return _onShelfGoodsView;
    
}

- (GoodsManageView *)offShelfGoodsView {
    
    if (!_offShelfGoodsView) {
        _offShelfGoodsView = BoundNibView(@"GoodsManageView", GoodsManageView);
        [self.view addSubview:_offShelfGoodsView];
        [_offShelfGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        _offShelfGoodsView.shelfNumber = @(kShelfNumberOffShelf);
    }
    return _offShelfGoodsView;
}




@end
