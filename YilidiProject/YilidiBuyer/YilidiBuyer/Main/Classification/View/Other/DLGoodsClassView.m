//
//  DLGoodsClassView.m
//  YilidiBuyer
//
//  Created by mm on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsClassView.h"
#import "DLGoodsOneLevelClassCell.h"
#import "MycommonTableView.h"
#import "GlobleConst.h"
#import "NSArray+extend.h"
#import "MyCommonCollectionView.h"
#import "DLClassificationCollectionCell.h"
#import "DLClassificationHeaderView.h"
#import "DLSecondClassTestModel.h"
#import "DLGoodsThirdLevelClassController.h"
#import "DLClassificationVC.h"
#import "Util.h"

const NSInteger subClassMaxCount = 9;
@interface DLGoodsClassView()
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsFirstCategaryTableView;
@property (nonatomic, copy)NSString *firstLevelGoodsClassCode;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *goodsSecondLevelClassCollectionView;
//上一次请求店铺分类的店铺id
@property (nonatomic,copy) NSString *lastRequestedClassDataStoreId;
@property (nonatomic,strong) UIViewController *ownVC;

@property (nonatomic,assign) BOOL classRequestFailed;

@end

@implementation DLGoodsClassView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initGoodsFirstLevelCategaryTableView];
    [self _initGoodsSecondLevelClassCollectionView];
}

- (void)_initGoodsFirstLevelCategaryTableView {
    WEAK_SELF
    self.goodsFirstCategaryTableView.cellHeight = kGoodsOneLevelClassCellHeight;
    [self.goodsFirstCategaryTableView configurecellNibName:@"DLGoodsOneLevelClassCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLGoodsOneLevelClassCell *firstLevelCategaryCell = (DLGoodsOneLevelClassCell *)cell;
        GoodsClassModel *model = (GoodsClassModel *)cellModel;
        [firstLevelCategaryCell setGoodsOneLevelModel:model];
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        GoodsClassModel *model = (GoodsClassModel *)cellModel;
        if (model.selected) {
            return ;
        }
        model.selected = YES;
        NSIndexPath *lastSelectedPath =  [model setOtherModelUnSelectedAccordingSelectedModel:model inModelArr:weak_self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr];
        if (lastSelectedPath) {
            [weak_self.goodsFirstCategaryTableView reloadRowsAtIndexPaths:@[lastSelectedPath,clickIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        weak_self.firstLevelGoodsClassCode = model.classCode;

    }];
}

- (void)_initGoodsSecondLevelClassCollectionView {
    self.goodsSecondLevelClassCollectionView.noDataLogicModule.nodataAlertTitle = @"暂无分类";
    self.goodsSecondLevelClassCollectionView.noDataLogicModule.needDealNodataCondition = NO;
    WEAK_SELF
    [self.goodsSecondLevelClassCollectionView configureMultiSetionHeaderNibName:@"DLClassificationHeaderView" collectionCellNibName:@"DLClassificationCollectionCell" getCollectionSectionCountBlock:^NSInteger(UICollectionView *collectionView, id groupModel, NSInteger section) {
        GoodsClassModel *model = (GoodsClassModel *)groupModel;
        if (model.subClassList.count <= subClassMaxCount) {
            return model.subClassList.count;
        }else {
            return subClassMaxCount;
        }
        
    } configureCollectionSectionCellBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *indexPath) {
        GoodsClassModel *model = (GoodsClassModel *)collectionModel;
        DLClassificationCollectionCell *cell = (DLClassificationCollectionCell *)collectionCell;
        [cell setCellModel:model.subClassList[indexPath.row]];
        
    } configureCollectionSectionHeaderBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionReusableView *firstSectionHeaderView) {
        DLClassificationHeaderView *classificationHeaderView = (DLClassificationHeaderView *)firstSectionHeaderView;
        GoodsClassModel *model = (GoodsClassModel *)collectionModel;
        [classificationHeaderView.secondLevelClassTitleButton setTitle:model.className forState:UIControlStateNormal];
        classificationHeaderView.clickSecondLevelClassBlock = ^{
            [weak_self _enterGoodsThirdLevelClasssPageWithGoodsClassModel:model cellModel:nil];
        };
        
    } clickCellBlock:^(UICollectionView *collectionView, id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        GoodsClassModel *groupModel = (GoodsClassModel *)collectionModel;
        GoodsClassModel *cellModel = groupModel.subClassList[clickIndexPath.row];
        [weak_self _enterGoodsThirdLevelClasssPageWithGoodsClassModel:groupModel cellModel:cellModel];
    }];
    
    
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:3 horizontalDisplayAreaWidth:kScreenWidth*0.779 cellImgToSideEdge:5 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:41 edgeBetweenCellAndCell:0 edgeBetweenCellAndSide:0];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.goodsSecondLevelClassCollectionView.cellCalculateModel = cellCaculateModel;
    self.goodsSecondLevelClassCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth-0.1, cellCaculateModel.cellHeight);
    self.goodsSecondLevelClassCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.goodsSecondLevelClassCollectionView.commonFlowLayout.minimumInteritemSpacing = 0;
    self.goodsSecondLevelClassCollectionView.commonFlowLayout.minimumLineSpacing = 0;

    self.goodsSecondLevelClassCollectionView.commonFlowLayout.headerReferenceSize = CGSizeMake(kScreenWidth*0.779, kClassificationHeaderViewHeight);

}

#pragma mark ---------------------Api Method------------------------------
- (void)_requestGoodsSecondLevelData {
    NSDictionary *param = @{@"parentClassCode":self.firstLevelGoodsClassCode,
                            @"storeId":kCommunityStoreId};
    [self.ownVC showHubWithDefaultStatus];
    DDLogVerbose(@"正在获取商品二三级分类列表信息...");
    [AFNHttpRequestOPManager postWithParameters:param subUrl:kUrl_GoodsTypeList block:^(NSDictionary *resultDic, NSError *error) {
        [self.ownVC dissmiss];
        NSArray *secondGoodsClassArr = resultDic[EntityKey];
        if (isEmpty(secondGoodsClassArr)) {
            secondGoodsClassArr = @[];
        }
        NSArray *tranferedArr = [secondGoodsClassArr transferDicArrToModelArrWithModelClass:[GoodsClassModel class]];
        [self.goodsSecondLevelClassCollectionView configureCollectionAfterRequestTotalData:tranferedArr];
    }];
}

- (void)_requestGoodsFirstLevelCategaryData {
    [self.ownVC showHubWithDefaultStatus];
    NSDictionary *param = @{@"parentClassCode":TOP_CLASS_CODE,
                          @"storeId":self.lastRequestedClassDataStoreId};
    DDLogVerbose(@"正在获取商品一级分类列表信息...");
    [AFNHttpRequestOPManager postWithParameters:param subUrl:kUrl_GoodsTypeList block:^(NSDictionary *resultDic, NSError *error) {
        [self.ownVC dissmiss];
        BOOL requestClassFailed = error.code == -1;
        self.classRequestFailed = requestClassFailed;
        emptyBlock(self.classRequestFailedBlock,requestClassFailed)
        
        NSArray *firstGoodsLevelArr = resultDic[EntityKey];
        if (isEmpty(firstGoodsLevelArr)) {
            return ;
        }

        NSArray *tranferedArr = [firstGoodsLevelArr transferDicArrToModelArrWithModelClass:[GoodsClassModel class]];
        [self _configureTheFirstLevelCategaryTableWithDatas:tranferedArr];
    }];
}

#pragma mark ---------------------PageNavigate Method------------------------------
- (void)_enterGoodsThirdLevelClasssPageWithGoodsClassModel:(GoodsClassModel *)groupModel cellModel:(GoodsClassModel *)cellModel{
    DLGoodsThirdLevelClassController *goodsThirdLevelClassController = [[DLGoodsThirdLevelClassController alloc] init];
    goodsThirdLevelClassController.goodsClassModel = groupModel;
    goodsThirdLevelClassController.goodsClassChildModel = cellModel;
    [self.ownVC.navigationController pushViewController:goodsThirdLevelClassController animated:YES];
}


#pragma mark ---------------------Public Method------------------------------
- (void)requestClassDataConfigure
 {
     BOOL needRequestStoreClassData = NO;
     if (isEmpty(kCommunityStoreId)) {//店铺为空默认处理和请求失败处理一样
         emptyBlock(self.classRequestFailedBlock,YES);
         return;
     }
     
     if (self.classRequestFailed) {
         self.lastRequestedClassDataStoreId = kCommunityStoreId;
         [self _requestGoodsFirstLevelCategaryData];
         return;
     }
     
     if (isEmpty(self.lastRequestedClassDataStoreId)) {
         needRequestStoreClassData = YES;
     }else {
         //上一次请求的storeId有值，但是又和当前的不一样，说明店铺换了,得重新请求分类
         if (![self.lastRequestedClassDataStoreId isEqualToString:kCommunityStoreId]) {
             needRequestStoreClassData = YES;
         }
     }
     if (needRequestStoreClassData) {
         self.lastRequestedClassDataStoreId = kCommunityStoreId;
         [self _requestGoodsFirstLevelCategaryData];
     }

}


#pragma mark ---------------------Private Method------------------------------
- (void)_configureTheFirstLevelCategaryTableWithDatas:(NSArray *)tranferedArr {
    
    GoodsClassModel *model = tranferedArr.firstObject;
    model.selected = YES;
    self.firstLevelGoodsClassCode = model.classCode;
    
    self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr = [tranferedArr mutableCopy];
    [self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    [self.goodsFirstCategaryTableView reloadData];
}

- (void)_requestGoodsSecondLevelDataConfigure {
    [self _requestGoodsSecondLevelData];
}

#pragma mark ---------------------Setter/Getter Method------------------------------
- (void)setFirstLevelGoodsClassCode:(NSString *)firstLevelGoodsClassCode {
    _firstLevelGoodsClassCode = firstLevelGoodsClassCode;
    [self _requestGoodsSecondLevelDataConfigure];
}

- (UIViewController *)ownVC {
    if (!_ownVC) {
        _ownVC = [Util currentViewController];
    }
    return _ownVC;
}

@end
