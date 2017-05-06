//
//  DLScanGoodsResultVC.m
//  YilidiBuyer
//
//  Created by yld on 16/7/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLScanGoodsResultVC.h"
#import "MycommonTableView.h"
#import "DLGoodsAllshowCell.h"
#import "DLGoodsdetailVC.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLAnimatePerformer.h"
#import "ShopCartView.h"
#import "GlobleConst.h"
#import "NSArray+extend.h"
#import "DLShopCarVC.h"
#import "ProjectRelativeKey.h"
#import "UIViewController+unLoginHandle.h"
static NSString *notScanedTheGoods = @"没有扫到相关商品";
static NSString *notSearchedTheGoods = @"没有查询到相关商品";
static NSString *goodsIsOffShelf = @"该商品已下架";

@interface DLScanGoodsResultVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *scanGoodsResultTableView;
@property (nonatomic, strong)DLAnimatePerformer *animatePerformer;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (weak, nonatomic) IBOutlet UILabel *scanResultLabel;

@end

@implementation DLScanGoodsResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initScanedGoodsListTableView];
    
    if (isEmpty(self.scanedGoodsQRCodeStr)) {
        [self _canShowScanGoods:NO withScanResultStr:notScanedTheGoods];
    }else {
        [self _requestGoodsInfo];
    }
    
    [self _init];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.shopCartView initShopCartGoods];
}

-(void)_init {
    self.pageTitle = @"码上购";
    WEAK_SELF
    self.shopCartView.gotoShopCartPageBlock = ^{
        [weak_self _enterShopCartPage];
    };
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterShopCartPage {
    if (![self unloginHandle]) {
        return;
    }
    DLShopCarVC *shopCartVC = [[DLShopCarVC alloc] init];
    [self navigatePushViewController:shopCartVC animate:YES];
}


#pragma mark -------------------Api Method----------------------
- (void)_requestGoodsInfo {
    self.requestParam = @{@"barCode":self.scanedGoodsQRCodeStr,
                          KStoreIdKey:kCommunityStoreId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_SearchGoodsInfoByQrCode block:^(NSDictionary *resultDic, NSError *error) {
        NSDictionary *goodsInfo = resultDic[EntityKey];
        if (isEmpty(goodsInfo)) {
            [self _canShowScanGoods:NO withScanResultStr:notScanedTheGoods];
        }else {
            NSNumber *goodsOnShelfStatus = goodsInfo[@"productStatus"];
            if (!goodsOnShelfStatus.integerValue) {
                [self _canShowScanGoods:NO withScanResultStr:goodsIsOffShelf];
            }else {
                NSArray *transferedArr = [@[goodsInfo] transferDicArrToModelArrWithModelClass:[GoodsModel class]];
                self.scanGoodsResultTableView.dataLogicModule.currentDataModelArr = [transferedArr mutableCopy];
                [self.scanGoodsResultTableView reloadData];
                [self _canShowScanGoods:YES withScanResultStr:@""];
            }
        }
    }];
}

#pragma mark -------------------Private Method----------------------
- (void)_initScanedGoodsListTableView {
    
    WEAK_SELF
    self.scanGoodsResultTableView.cellHeight = GoodsAllshowHeight;
    self.scanGoodsResultTableView.nodataAlertTitle = @"暂无商品";
    [self.scanGoodsResultTableView configurecellNibName:@"DLGoodsAllshowCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLGoodsAllshowCell *goodsCell = (DLGoodsAllshowCell *)cell;
        goodsCell.imgWidthConstraint.constant = GoodsAllshowCellImgWidth ;
        goodsCell.imgHeightConstraint.constant = GoodsAllshowCellImgHeight ;
        GoodsModel *model = (GoodsModel *)cellModel;
        [goodsCell setGoodsAllshowCell:model];
        WEAK_OBJ(goodsCell)
        goodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [weak_self _performAddShopCartAnimationUsingImgView:weak_goodsCell.productImage isAdd:isAdd];
        };
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)cellModel;
        [weak_self _enterGoodsDetailPageWithGoodsId:model.goodsId];
    }];
}

- (void)_canShowScanGoods:(BOOL)canShow withScanResultStr:(NSString *)scanResultStr{
    self.scanGoodsResultTableView.hidden = !canShow;
    self.scanResultLabel.hidden = canShow;
    self.shopCartView.hidden = !canShow;
    self.scanResultLabel.text = scanResultStr;
}



- (void)_performAddShopCartAnimationUsingImgView:(UIImageView *)animationImageView isAdd:(BOOL)isAdd{
    
    if (!isAdd) {
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
        return;
    }
    self.scanGoodsResultTableView.scrollEnabled = NO;
    WEAK_SELF
    [self.animatePerformer performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animationImageView animateEndPoint: CGPointMake(kScreenWidth-34-50/2, kScreenHeight-58 - 50/2) animateDidEndBlock:^{
        weak_self.scanGoodsResultTableView.scrollEnabled = YES;
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
    }];
}

- (void)_enterGoodsDetailPageWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}

#pragma mark -------------------Setter/Getter Method----------------------
- (DLAnimatePerformer *)animatePerformer {
    
    if (!_animatePerformer) {
        _animatePerformer = [[DLAnimatePerformer alloc] init];
    }
    return _animatePerformer;
}





@end
