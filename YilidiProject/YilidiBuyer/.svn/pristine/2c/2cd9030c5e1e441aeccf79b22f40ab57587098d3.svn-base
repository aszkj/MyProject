#//
//  DLMyfavoriteListVC.m
//  YilidiBuyer
//
//  Created by mm on 17/2/20.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLMyfavoriteListVC.h"
#import "MycommonTableView.h"
#import "GlobleConst.h"
#import "DLFavoriteCell.h"
#import "NSArray+SUIAdditions.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLAnimatePerformer.h"
#import "ShopCartView.h"
#import "DLShopCarVC.h"
#import "UIViewController+unLoginHandle.h"
#import "ListSelectOperator.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ProjectStandardUIDefineConst.h"
#import "DLGoodsdetailVC.h"
#import "DLAnimatePerformer+business.h"

const CGFloat favoriteGoodsTableToBottomConstraintMax = 50;
const CGFloat favoriteGoodsTableToBottomConstraintMin = 0;

@interface DLMyfavoriteListVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *myFavoriteListTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *favoriteGoodsTableToBottomConstraint;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (nonatomic,strong) ListSelectOperator *listSelectOperator;
@property (nonatomic,assign) BOOL isEditing;
@property (nonatomic,strong) UIButton *rightItemButton;

@end

@implementation DLMyfavoriteListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pageTitle = @"商品收藏";
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self _initMyfavoriteGoodsTableView];
    
    
    [self _initRightItem];
    
    
    [self _requestFavoriteGoodsData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_initMyfavoriteGoodsTableView {
    self.myFavoriteListTableView.cellHeight = kDLFavoriteCellHeight;
    self.myFavoriteListTableView.noDataLogicModule.nodataAlertTitle = @"你还没有收藏过宝贝";
    self.myFavoriteListTableView.noDataLogicModule.nodataAlertImage = @"无收藏";
    WEAK_SELF
    [self.myFavoriteListTableView configurecellNibName:@"DLFavoriteCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        GoodsModel *goodsModel = (GoodsModel *)cellModel;
        DLFavoriteCell *favoriteCell = (DLFavoriteCell *)cell;
        [favoriteCell setFavoriteCellModel:goodsModel];
        [favoriteCell favoriteCellIsEdit:weak_self.isEditing cellModel:goodsModel];
        WEAK_OBJ(favoriteCell)
        WEAK_OBJ(goodsModel)
        favoriteCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [weak_self _showShopCart];
            [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:weak_favoriteCell.goodsImgView contentListView:weak_self.myFavoriteListTableView shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:isAdd];

        };
        favoriteCell.selectFavoriteGoodsBlock = ^(UIButton *selectButton){
            [weak_self.listSelectOperator select:selectButton.selected item:weak_goodsModel];
        };

        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        GoodsModel *goodsModel = (GoodsModel *)cellModel;
        GoodsStatus goodsStatus = [goodsModel goodsStatus];
        if (goodsStatus == GoodsStatus_Normal || goodsStatus == GoodsStatus_NoStock) {
            [weak_self _enterGoodsDetailWithGoodsId:goodsModel.goodsId];
        }
        
    }];
    
    self.myFavoriteListTableView.editingStyle = UITableViewCellEditingStyleDelete;
    self.myFavoriteListTableView.editingCellBlock = ^(UITableView *tableView, UITableViewCellEditingStyle editingStyle,NSIndexPath *editingIndexPath, id cellModel){
        GoodsModel *goodsModel = (GoodsModel *)cellModel;
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [weak_self.listSelectOperator setSwipItem:goodsModel];
            [weak_self _requestDeleteSelectGoods:goodsModel.productId isSwipDelete:YES];
        }
    };
    
    [self.myFavoriteListTableView headerRreshRequestBlock:^{
        [weak_self _requestFavoriteGoodsData];
    }];
    
    [self.myFavoriteListTableView footerRreshRequestBlock:^{
        [weak_self _requestFavoriteGoodsData];
    }];
}

- (void)_initRightItem {
    self.rightItemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    self.rightItemButton.titleLabel.font = kSystemFontSize(15);
    [self.rightItemButton setTitleColor:KTextColor forState:UIControlStateNormal];
    [self.rightItemButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightItemButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.rightItemButton addTarget:self action:@selector(switchEditStateAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *spaceItem = [UIBarButtonItem barButtonItemSpace:-15];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightItemButton];
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];

    RAC(self,isEditing) = RACObserve(self.rightItemButton, selected);

}

#pragma mark ------------------------Private-------------------------
- (void)_switchEditState{
    self.bottomView.hidden = !self.isEditing;
    self.favoriteGoodsTableToBottomConstraint.constant = self.isEditing ? favoriteGoodsTableToBottomConstraintMax : favoriteGoodsTableToBottomConstraintMin;
    self.shopCartView.hidden = self.isEditing;
    [self.myFavoriteListTableView reloadData];
    [self.myFavoriteListTableView closeFooterFresh:self.isEditing];
    [self.myFavoriteListTableView closeHeaderFresh:self.isEditing];
}

- (void)_showShopCart {
    if (self.shopCartView.hidden) {
        self.shopCartView.hidden = NO;
    }
}


- (void)_checkUIAfterDeleteSelectGoods {
    if (!self.myFavoriteListTableView.dataLogicModule.currentDataModelArr.count) {
        self.rightItemButton.selected = NO;
        [self _switchEditState];
        [self.myFavoriteListTableView dataEmptyHandle];
    }
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestFavoriteGoodsData {
    if (self.isEditing) {
        return;
    }
    self.requestParam = @{@"storeId":kCommunityStoreId,
                          kRequestPageNumKey:@(self.myFavoriteListTableView.dataLogicModule.requestFromPage),
                          kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:KUrl_GetMyfavoriteList block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        NSArray *favoriteList = resultDic[EntityKey][@"list"];
        if (isEmpty(favoriteList)) {
            favoriteList = @[];
        }
        NSArray *transFeredArr = [favoriteList sui_map:^GoodsModel *(NSDictionary* obj, NSUInteger index) {
            GoodsModel *model = [[GoodsModel alloc] initWithDefaultDataDic:obj];
            model.goodsOnShelf = obj[@"productStatus"];
            return model;
        }];
        [self.myFavoriteListTableView configureTableAfterRequestPagingData:transFeredArr];
        [self.listSelectOperator resetAllSelectedItems];
    }];
}

- (void)_requestDeleteSelectGoods:(NSString *)goodsProductIds isSwipDelete:(BOOL)isSwipDelete{
    [self showLoadingHub];
    self.requestParam = @{@"productIds":goodsProductIds};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:Kurl_CancelFavoriteGoods block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code == 1) {
            if (isSwipDelete) {//滑动删除
                [self.listSelectOperator deleteSwipItem];
            }else {//编辑删除
                [self.listSelectOperator deleteSelectItems];
            }
//            [self _checkUIAfterDeleteSelectGoods];
        }
        
    }];
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterGoodsDetailWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}


#pragma mark ------------------------View Event---------------------------
- (IBAction)selectAllAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    [self.listSelectOperator allItemSelected:button.selected];
}

- (IBAction)deleteSelectFavoriteItemAction:(id)sender {
    NSString *selectedGooodsProductIds = [self selectGoodsProductIds];
    if (isEmpty(selectedGooodsProductIds)) {
        [Util ShowAlertWithOnlyMessage:@"亲，您还未选择商品"];
        return;
    }
    [self _requestDeleteSelectGoods:selectedGooodsProductIds isSwipDelete:NO];
}

- (void)switchEditStateAction:(UIButton *)button {
//    if (!self.myFavoriteListTableView.dataLogicModule.currentDataModelArr.count) {
//        return;
//    }
    button.selected = !button.selected;
    [self _switchEditState];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (ListSelectOperator *)listSelectOperator {
    
    if (!_listSelectOperator) {
        _listSelectOperator = [[ListSelectOperator alloc] initItemTableView:self.myFavoriteListTableView allSelectButton:self.allSelectButton];
    }
    return _listSelectOperator;

}


- (NSString *)selectGoodsProductIds {
    NSArray *selectGoodsProuctIds = [[self.listSelectOperator getSelectedItems] sui_map:^NSString *(GoodsModel *goodsModel, NSUInteger index) {
        return goodsModel.productId;
    }];
    return [selectGoodsProuctIds componentsJoinedByString:@","];
}

@end
