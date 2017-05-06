//
//  DLGoodsTotalShowVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsAllCategoriVC.h"
#import "MycommonTableView.h"
#import "MyCommonCollectionView.h"
#import "DLGoodsAllshowCell.h"
#import "DLHomeGoodsModel.h"
#import "DLFreshFruitCollectionViewCell.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "CellCalculateModel.h"
#import "DLCommunityGoodsCollectionViewCell.h"
#import "MyCommonCollectionView.h"
#import "GlobleConst.h"
#import "DLGoodsSearchTopView.h"
#import "DLGoodsSearchShowView.h"
#import "DLGoodsSearchVC.h"
#import <Masonry/Masonry.h>

@interface DLGoodsAllCategoriVC ()
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *allGoodsCollectionView;
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsAllTabbleView;

@property (nonatomic, assign)NSInteger goodsSortRuleNumber;
@property (nonatomic, assign)NSInteger goodsVolomeSortRuleNumber;
@property (nonatomic, assign)NSInteger goodsPriceSortRuleNumber;

@property (nonatomic, assign)NSInteger requestFromPage;

@property (nonatomic, copy)NSString *keyWords;
@property (weak, nonatomic) IBOutlet UILabel *goodsTypeTitleLabel;

@property (nonatomic, strong)DLGoodsSearchTopView *goodsSearchTopView;
@property (nonatomic, strong)DLGoodsSearchShowView *goodsSearchShowView;
@property (weak, nonatomic) IBOutlet UIButton *salesValumeButton;
@property (weak, nonatomic) IBOutlet UIButton *salesValumeArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UIButton *priceArrowButton;

@property (nonatomic,assign)GoodsSearchShowModal goodsSearchShowModal;

@end

@implementation DLGoodsAllCategoriVC

- (void)viewDidLoad {
    //不需要父类的返回键，必须要在调用父类的viewDidload方法之前调
    self.doNotNeedBaseBackItem = YES;
    [super viewDidLoad];
    
    [self _init];
    
    [self _requestGoodsData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.goodsSearchTopView removeFromSuperview];
}



#pragma mark ------------------------Init---------------------------------
-(void)_init {
    [self _initInfo];
    [self _initgoodsAllTableView];
    [self _initGoodsCollectionView];
    [self _initGoodsSearchTopView];
    [self _initGoodsTypeLabel];
}

- (void)_initGoodsTypeLabel {
    NSString *goodsTypeTitle = nil;
    switch (self.goodsTypeNumber) {
        case kGoodsTypeNumberCommnuntiyWellSelect:
            goodsTypeTitle = kGoodsTypeTitleCommunityWellSelected;
            break;
        case kGoodsTypeNumberCommunityHoteSale:
            goodsTypeTitle = kGoodsTypeTitleCommunityHoteSale;
            break;
        case kGoodsTypeNumberSpecialPrice:
            goodsTypeTitle = kGoodsTypeTitleSpecialPrice;
            break;
        case kGoodsTypeNumberNewProduct:
            goodsTypeTitle = kGoodsTypeTitleNewProduct;
            break;
        default:
            break;
    }
    self.goodsTypeTitleLabel.text = goodsTypeTitle;
}

-(void)_initInfo {
    
    self.goodsSortRuleNumber = kGoodsSortNumberFromLowtoHighBySalesVolume;
    self.goodsVolomeSortRuleNumber = kGoodsSortNumberFromLowtoHighBySalesVolume;
    self.goodsPriceSortRuleNumber = kGoodsSortNumberFromLowtoHighByPrice;
    self.requestFromPage = 1;
    self.goodsSearchShowModal = GoodsShowPreviewHorizonalModal;
    self.navigationController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)_requestReset {
    self.requestFromPage = 1;
    [self.allGoodsCollectionView.mj_footer resetNoMoreData];
    [self.goodsAllTabbleView.mj_footer resetNoMoreData];
    [self _requestGoodsData];
}

-(void)_initGoodsSearchTopView {
    
    self.goodsSearchTopView = BoundNibView(@"DLGoodsSearchTopView", DLGoodsSearchTopView);
    [self.navigationController.view addSubview:self.goodsSearchTopView];
    WEAK_SELF
    [self.goodsSearchTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.navigationController.view.mas_top).with.offset(20);
        make.left.right.mas_equalTo(weak_self.navigationController.view);
        make.height.mas_equalTo(44);
    }];
    self.goodsSearchTopView.searchBackBlock = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
 
    self.goodsSearchTopView.beginSearchBlock = ^(NSString *keyWords){
        weak_self.goodsSearchShowView.keyWords = keyWords;
    };
}


-(void)_initgoodsAllTableView {
    
    self.goodsAllTabbleView.cellHeight = GoodsAllshowHeight;
    [self.goodsAllTabbleView configurecellNibName:@"DLGoodsAllshowCell" cellDataSource:nil configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLGoodsAllshowCell *allshowCell = (DLGoodsAllshowCell *)cell;
        DLHomeGoodsModel *model =  (DLHomeGoodsModel *)cellModel;
        
        [allshowCell setGoodsAllshowCell:model];
        
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    WEAK_SELF
    [self.goodsAllTabbleView headerRreshRequestBlock:^{
        [weak_self _requestReset];
    }];
    
    [self.goodsAllTabbleView footerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
}


- (void)_initGoodsCollectionView
{
    WEAK_SELF
    [self.allGoodsCollectionView headerRreshRequestBlock:^{
        [weak_self _requestReset];
    }];
    
    [self.allGoodsCollectionView footerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
    
    [self.allGoodsCollectionView configureCollectionCellNibName:@"DLCommunityGoodsCollectionViewCell" cellDataSource:nil configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        
        DLCommunityGoodsCollectionViewCell *goodsCell = (DLCommunityGoodsCollectionViewCell *)collectionCell;
        DLHomeGoodsModel *model = (DLHomeGoodsModel *)collectionModel;
        [goodsCell setCellModel:model];
        goodsCell.imgWidthConstraint.constant = weak_self.allGoodsCollectionView.cellCalculateModel.cellImgWidth;
        goodsCell.imgHeightConstraint.constant = weak_self.allGoodsCollectionView.cellCalculateModel.cellImgHeight;
        
    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        
    }];
    self.allGoodsCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.allGoodsCollectionView.commonFlowLayout.minimumInteritemSpacing = 10;
    self.allGoodsCollectionView.commonFlowLayout.minimumLineSpacing = 10;
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.95 cellOterPartHeightBesideImg:70 edgeBetweenCellAndCell:10 edgeBetweenCellAndSide:10];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.allGoodsCollectionView.cellCalculateModel = cellCaculateModel;
    self.allGoodsCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    
}


#pragma mark ------------------------Private-------------------------
- (void)_configureUiWhenSwithchGoodsShowmodal{
    if (self.goodsSearchShowModal == GoodsShowPreviewHorizonalModal) {
        _goodsSearchShowView.hidden = YES;
        self.goodsAllTabbleView.hidden = NO;
        self.allGoodsCollectionView.hidden = YES;
    }else if(self.goodsSearchShowModal == GoodsShowPreviewVerticalModal){
        _goodsSearchShowView.hidden = YES;
        self.goodsAllTabbleView.hidden = YES;
        self.allGoodsCollectionView.hidden = NO;
    }else if (self.goodsSearchShowModal == GoodsSearchModal){
        self.goodsSearchShowView.hidden = NO;
        self.goodsAllTabbleView.hidden = YES;
        self.allGoodsCollectionView.hidden = YES;
    }
}

- (void)_rotateSalesVolomnArrowButtonSelectedClick {
    CGAffineTransform willTransform;
    if (self.goodsVolomeSortRuleNumber == kGoodsSortNumberFromLowtoHighBySalesVolume) {
        willTransform = CGAffineTransformMakeRotation(M_PI);
        self.goodsVolomeSortRuleNumber = kGoodsSortNumberFromHightoLowBySalesVolume;
    }else {
        willTransform = CGAffineTransformIdentity;
        self.goodsVolomeSortRuleNumber = kGoodsSortNumberFromLowtoHighBySalesVolume;
    }
    self.goodsSortRuleNumber = self.goodsVolomeSortRuleNumber;
    [UIView animateWithDuration:0.2 animations:^{
        self.salesValumeArrowButton.transform = willTransform;
        [self.view layoutIfNeeded];
    }];
}

- (void)_rotatePriceArrowButtonSelectedClick {
    
    CGAffineTransform willTransform;
    if (self.goodsPriceSortRuleNumber == kGoodsSortNumberFromLowtoHighByPrice) {
        willTransform = CGAffineTransformMakeRotation(M_PI);
        self.goodsPriceSortRuleNumber = kGoodsSortNumberFromHightoLowByPrice;
    }else {
        willTransform = CGAffineTransformIdentity;
        self.goodsPriceSortRuleNumber = kGoodsSortNumberFromLowtoHighByPrice;
    }
    self.goodsSortRuleNumber = self.goodsPriceSortRuleNumber;
    [UIView animateWithDuration:0.2 animations:^{
        self.priceArrowButton.transform = willTransform;
        [self.view layoutIfNeeded];

    }];
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestGoodsData {
    self.goodsAllTabbleView.dataLogicModule.requestFromPage = self.requestFromPage;
    self.allGoodsCollectionView.dataLogicModule.requestFromPage = self.requestFromPage;
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    [requestParam setObject:@(self.goodsSortRuleNumber) forKey:@"sortRule"];
    [requestParam setObject:@(self.goodsTypeNumber) forKey:@"goodsType"];
    [requestParam  setObject:@(self.requestFromPage) forKey:kRequestPageNumKey];
    [requestParam  setObject:@(kRequestDefaultPageSize) forKey:kRequestPageSizeKey];
    if (!isEmpty(self.keyWords)) {
        [requestParam setObject:self.keyWords forKey:@"keywords"];
    }
    
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GoodsSearch parameters:requestParam block:^(id result, NSError *error) {
        NSArray *resultArr = result[@"data"][@"items"];
        NSArray *transferedArr = [DLHomeGoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [self.goodsAllTabbleView configureTableAfterRequestPagingData:transferedArr];
        [self.allGoodsCollectionView configureCollectionAfterRequestPagingData:transferedArr];
        self.requestFromPage  = self.goodsAllTabbleView.dataLogicModule.requestFromPage;

    }];
}



#pragma mark ------------------------Page Navigate---------------------------
#pragma mark ------------------------View Event---------------------------

- (IBAction)clickSalesVolomeAction:(id)sender {
    if (self.salesValumeButton.selected) {
        [self _rotateSalesVolomnArrowButtonSelectedClick];
    }else {
        self.salesValumeButton.selected = YES;
        self.salesValumeArrowButton.selected = YES;
        self.priceButton.selected = NO;
        self.priceArrowButton.selected = NO;
        self.goodsSortRuleNumber = self.goodsVolomeSortRuleNumber;
    }
}

- (IBAction)clickPriceAction:(id)sender {
    if (self.priceButton.selected) {
        [self _rotatePriceArrowButtonSelectedClick];
    }else {
        self.salesValumeButton.selected = NO;
        self.salesValumeArrowButton.selected = NO;
        self.priceButton.selected = YES;
        self.priceArrowButton.selected = YES;
        self.goodsSortRuleNumber = self.goodsPriceSortRuleNumber;
    }
}
#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (DLGoodsSearchShowView *)goodsSearchShowView {
    
    if (!_goodsSearchShowView) {
        _goodsSearchShowView = BoundNibView(@"DLGoodsSearchShowView", DLGoodsSearchShowView);
//        _goodsSearchShowView.goodsTypeNumber = @(self.goodsTypeNumber);
        [self.view addSubview:_goodsSearchShowView];
        WEAK_SELF
        [_goodsSearchShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weak_self.view);
        }];
    }
    return _goodsSearchShowView;
}

- (void)setGoodsSortRuleNumber:(NSInteger)goodsSortRuleNumber {
    _goodsSortRuleNumber = goodsSortRuleNumber;
    [self _requestReset];
}

- (void)setGoodsSearchShowModal:(GoodsSearchShowModal)goodsSearchShowModal {
    _goodsSearchShowModal = goodsSearchShowModal;
    [self _configureUiWhenSwithchGoodsShowmodal];
}

- (void)dealloc
{
    
}
@end
