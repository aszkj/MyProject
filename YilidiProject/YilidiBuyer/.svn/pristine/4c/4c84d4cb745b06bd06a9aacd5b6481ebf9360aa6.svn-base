//
//  DLGoodsSearchShowView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsSearchShowView.h"
#import "DLGoodsAllshowCell.h"
#import "DLHomeGoodsModel.h"
#import "GlobleConst.h"
#import "GoodsModel.h"
#import "ProjectRelativeKey.h"
#import "DLHomeGoodsVerticalCell.h"
#import "CommunityDataManager.h"
#import "ShopCartView.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLAnimatePerformer.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "DLGoodsSearchVC.h"
#import "HMSegmentedControl.h"
#import "DLBrandView.h"
#import <Masonry.h>
#import "DLBrandCollectionCell.h"
#import "DLBrandModel.h"
#import "DLBrandGoodsVC.h"
#import "DLAnimatePerformer+business.h"
@interface DLGoodsSearchShowView()
@property (nonatomic, assign)NSInteger searchedGoodsCount;
@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (nonatomic,strong)HMSegmentedControl *topSegmentedView;
@property (nonatomic,strong)DLBrandView *brandView;
@property (strong, nonatomic) IBOutlet UIView *topView;

@property (nonatomic,assign)NSInteger currentIndex;
@end

@implementation DLGoodsSearchShowView

#pragma mark -------------------Init Method----------------------
- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self _init];
    
    [self _initSegmentedView];
}


-(void)_init {
    [self _initGoodsSearchResultCollectionView];

}

- (void)_initSegmentedView {
    
    NSArray *topBarTitles = @[@"商品",@"品牌"];

    
    self.topSegmentedView = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    self.topSegmentedView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topSegmentedView.selectionIndicatorHeight = 2.0f;
    self.topSegmentedView.font = kSystemFontSize(15);
    self.topSegmentedView.sectionTitles = topBarTitles;
    self.topSegmentedView.textColor = KTextColor;
    self.topSegmentedView.selectedTextColor = KCOLOR_MAIN_TEXT;
    self.topSegmentedView.selectionIndicatorColor = KCOLOR_PROJECT_RED;
    self.topSegmentedView.selectedSegmentIndex=0;
    self.topSegmentedView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    WEAK_SELF
    self.topSegmentedView.indexChangeBlock = ^(NSInteger index){
        
        if (index ==0) {
            
            
            [weak_self.ownVC showHubWithDefaultStatus];
            weak_self.searchGoodsResultCollectionView.dataLogicModule.requestFromPage = 1;
            [weak_self requestGoodsData];
            weak_self.brandView.hidden = YES;
            weak_self.searchGoodsResultCollectionView.hidden=NO;
            weak_self.currentIndex =index;
        }else{
            
            
            weak_self.brandView.hidden = NO;
            weak_self.searchGoodsResultCollectionView.hidden=YES;
            weak_self.currentIndex =index;
        }
        
    };
    
    [self.topView addSubview:self.topSegmentedView];
}



-(void)_initGoodsSearchResultCollectionView {
    
    
    
    WEAK_SELF
    self.searchGoodsResultCollectionView.noDataLogicModule.nodataAlertTitle = @"抱歉，没有搜到相关商品";
    [self.searchGoodsResultCollectionView configureCollectionCellNibName:@"DLHomeGoodsVerticalCell" configureCollectionCellData:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        DLHomeGoodsVerticalCell *searchGoodsCell = (DLHomeGoodsVerticalCell *)collectionCell;
        [searchGoodsCell setCellModel:model];
        MyCommonCollectionView *collectionview = (MyCommonCollectionView *)collectionView;
        searchGoodsCell.imgHeightConstraint.constant = collectionview.cellCalculateModel.cellImgHeight;
        searchGoodsCell.imgWidthConstraint.constant = collectionview.cellCalculateModel.cellImgWidth;
        WEAK_OBJ(searchGoodsCell)
        searchGoodsCell.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
            [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:weak_searchGoodsCell.goodsImgView contentListView:weak_self.searchGoodsResultCollectionView shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:isAdd];

        };


    } clickCell:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)collectionModel;
        emptyBlock(weak_self.gotoGoodsDetailPageBlock,model.goodsId);
    }];
    
    self.searchGoodsResultCollectionView.commonFlowLayout.minimumInteritemSpacing = 5;
   self.searchGoodsResultCollectionView.commonFlowLayout.minimumLineSpacing = 5;
    
    self.searchGoodsResultCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:2 horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:8 cellImgWidthToHeightScale:0.9 cellOterPartHeightBesideImg:97 edgeBetweenCellAndCell:5 edgeBetweenCellAndSide:5];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.searchGoodsResultCollectionView.cellCalculateModel = cellCaculateModel;
    self.searchGoodsResultCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    [self.searchGoodsResultCollectionView headerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
    [self.searchGoodsResultCollectionView footerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];

}



-(void)_initGoodsSearchTableView {
    
    WEAK_SELF
    self.searchGoodsTableView.cellHeight = GoodsAllshowHeight;
    self.searchGoodsTableView.firstSectionHeaderHeight = 28;
    [self.searchGoodsTableView configurecellNibName:@"DLGoodsAllshowCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        GoodsModel *model = (GoodsModel *)cellModel;
        DLGoodsAllshowCell *searchGoodsCell = (DLGoodsAllshowCell *)cell;
        [searchGoodsCell setGoodsAllshowCell:model];
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)cellModel;
        emptyBlock(weak_self.gotoGoodsDetailPageBlock,model.goodsId);
    }];
    
    [self.searchGoodsTableView configureFirstSectioHeaderNibName:@"DLSearchGoodsHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView,id cellModel, UIView *firstSectionHeaderView) {
        
        NSString *keyWords = weak_self.keyWords;
        if (isEmpty(keyWords)) {
            keyWords = @"全部商品";
        }
        NSString *searchResultStr = [NSString stringWithFormat:@"搜到“%@”%ld条",keyWords,        weak_self.searchGoodsTableView.dataLogicModule.currentDataModelArr.count];
        NSRange keyWordsRange = [searchResultStr rangeOfString:keyWords];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:searchResultStr];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]
                                range:keyWordsRange];
        UILabel *searchLabel = (UILabel *)[firstSectionHeaderView viewWithTag:1];
        searchLabel.attributedText = attriString;
    }];
    
    [self.searchGoodsTableView headerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
    [self.searchGoodsTableView footerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
}


- (void)requestGoodsData {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(self.keyWords)) {
        [requestParam setObject:self.keyWords forKey:@"keywords"];
    }
    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    [requestParam setObject:@(self.searchGoodsResultCollectionView.dataLogicModule.requestFromPage) forKey:kRequestPageNumKey];
    [requestParam setObject:@(kRequestDefaultPageSize) forKey:kRequestPageSizeKey];
    [requestParam setObject:kCommunityStoreId forKey:KStoreIdKey];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GoodsSearch block:^(NSDictionary *resultDic, NSError *error) {
        [self.ownVC dissmiss];
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [self.searchGoodsResultCollectionView configureCollectionAfterRequestPagingData:transferedArr];
    }];
}



#pragma mark -------------------Setter/Getter Method----------------------
-(void)setKeyWords:(NSString *)keyWords {
    _keyWords = keyWords;
    
    if (_currentIndex==1) {
        
        [_brandView setKeyWords:_keyWords];
    }else{
        
        [self.ownVC showHubWithDefaultStatus];
        self.searchGoodsResultCollectionView.dataLogicModule.requestFromPage = 1;
        [self requestGoodsData];
    }
}

-(DLBrandView *)brandView {
    
    if (!_brandView) {
        _brandView = BoundNibView(@"DLBrandView", DLBrandView);
        _brandView.keyWords = _keyWords;
        _brandView.brandCollectionView.backgroundColor = KViewBgColor;
        [self addSubview:_brandView];
        [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.top.mas_equalTo(40);
        }];
        _brandView.searchVC = self.ownVC;
    }
    return _brandView;
    
}


@end
