//
//  GoodsManageView.m
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "GoodsManageView.h"
#import "MycommonTableView.h"
#import "CommonCategaryModel.h"
#import "DLCommunityGoodsFirstLevelCategaryCell.h"
#import "DLGoodsAllshowCell.h"
#import "SUIUtils.h"
#import "CommonCategaryModel.h"
#import "GlobleConst.h"
#import "ProjectRelativEmerator.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"
#import "NSObject+setModelIndexPath.h"
#import <Masonry/Masonry.h>
#import "NSArray+SUIAdditions.h"
#import "AlertViewManager.h"
#import <MBProgressHUD/MBProgressHUD.h>

const CGFloat firstClassGoodsWidthInPhone6 = 85;
@interface GoodsManageView()

@property (weak, nonatomic) IBOutlet MycommonTableView *goodsFirstCategaryTableView;
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsListTableView;

@property (nonatomic, strong)NSMutableArray *allCategeryArr;

@property (nonatomic, copy)NSString *firstLevelGoodsCategaryId;
@property (nonatomic, copy)NSString *secondeLevelGoodsCategaryId;
@property (weak, nonatomic) IBOutlet UILabel *goodsTypeNameTitleLabel;

@property (nonatomic, copy)NSString *requestGoodsListComponsedCategaryId;

@property (weak, nonatomic) IBOutlet UIButton *onOffShelfButton;
@property (nonatomic, assign)BOOL trigerSelecteGoodsFirstLevelCategary;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;

/**
 *  根据什么进行排序 1 库存，2 销量
 */
@property (nonatomic, assign)NSInteger orderByNumber;
/**
 *  排序从低到高1 从高到低2
 */
@property (nonatomic, assign)NSInteger sortByNumber;

@property (weak, nonatomic) IBOutlet UIButton *stockSortButton;
@property (weak, nonatomic) IBOutlet UIButton *stockSortDownArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *stockSortUpArrowButton;

@property (weak, nonatomic) IBOutlet UIButton *saleVolumeButton;
@property (weak, nonatomic) IBOutlet UIButton *saleSortUpArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *saleSortDownArrowButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstClassGoodsTableWidthConstraint;
@property (nonatomic, assign)NSInteger selectGoodsCount;


@end

@implementation GoodsManageView

- (void)awakeFromNib {
    
    [self _init];
    [self _requestGoodsFirstLevelCategaryData];
    [self _registerNotification];
//    [self _requestGoodsData];

}



#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    [self _initInfo];
    
    [self _initGoodsFirstLevelCategaryTableView];
    
    [self _initgoodsListTableView];
}

-(void)_initInfo {
    
    _orderByNumber = kGoodsSortNumberByStock;
    _sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
    _trigerSelecteGoodsFirstLevelCategary = NO;
    self.firstClassGoodsTableWidthConstraint.constant = ADAPT_SCREEN_WIDTH(firstClassGoodsWidthInPhone6);
}

- (void)_registerNotification {
    [kNotification addObserver:self selector:@selector(observeGoodsOnOffShelfSuccess:) name:KNotificationGoodsOnOffShelfSuccess object:nil];
}

- (void)_initgoodsListTableView {
    
    WEAK_SELF
    self.goodsListTableView.cellHeight = GoodsAllshowHeight;
    JLog(@"cellHeight ---- %.2f",GoodsAllshowHeight);
    self.goodsListTableView.noDataLogicModule.nodataAlertTitle = @"暂无商品";
    [self.goodsListTableView configurecellNibName:@"DLGoodsAllshowCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLGoodsAllshowCell *goodsCell = (DLGoodsAllshowCell *)cell;
        goodsCell.imgBgViewWidthConstraint.constant = GoodsAllshowCellImgWidth ;
        goodsCell.imgBgViewHeightConstraint.constant = GoodsAllshowCellImgHeight ;
        GoodsModel *model = (GoodsModel *)cellModel;
        WEAK_OBJ(model)
        [goodsCell setGoodsAllshowCell:model];
        goodsCell.selectGoodsBlock = ^(UIButton *selectedButton){
            weak_model.selected = selectedButton.selected;
            [weak_self _selectDeselecteGoodOfGoodsModel:weak_model];
        };
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    [self.goodsListTableView headerRreshRequestBlock:^{
        weak_self.selectGoodsCount = 0;
        [weak_self _requestGoodsData];
    }];
    
    [self.goodsListTableView footerRreshRequestBlock:^{
        [weak_self _requestGoodsData];
    }];
    
}



- (void)_initGoodsFirstLevelCategaryTableView {
    WEAK_SELF
    self.goodsFirstCategaryTableView.cellHeight = 44.0f;
    [self.goodsFirstCategaryTableView configurecellNibName:@"DLCommunityGoodsFirstLevelCategaryCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLCommunityGoodsFirstLevelCategaryCell *firstLevelCategaryCell = (DLCommunityGoodsFirstLevelCategaryCell *)cell;
        CommonCategaryModel *model = (CommonCategaryModel *)cellModel;
//        firstLevelCategaryCell.titleLabel.textColor = (model.selected ? [UIColor redColor] : [UIColor darkTextColor]);
        firstLevelCategaryCell.titleBgView.backgroundColor = (model.selected ? KSelectedBgColor : [UIColor clearColor]);
        firstLevelCategaryCell.contentView.backgroundColor = (model.selected ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor]);
        
        firstLevelCategaryCell.titleLabel.text = model.categaryName;
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        CommonCategaryModel *model = (CommonCategaryModel *)cellModel;
        if (model.selected) {
            return ;
        }
        model.selected = YES;
        NSIndexPath *lastSelectedPath =  [model setOtherModelUnSelectedAccordingSelectedModel:model inModelArr:weak_self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr];
        if (lastSelectedPath) {
            [weak_self.goodsFirstCategaryTableView reloadRowsAtIndexPaths:@[lastSelectedPath,clickIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        weak_self.goodsTypeNameTitleLabel.text = model.categaryName;
        weak_self.firstLevelGoodsCategaryId = model.categaryId;
        weak_self.trigerSelecteGoodsFirstLevelCategary = YES;
    }];
}

#pragma mark ------------------------Private-------------------------
- (void)_setSaleVolomeNumberToSortNumber {
    if (self.sortByNumber == kGoodsSortTypeNumberFromLowToHigh) {
        self.sortByNumber = kGoodsSortTypeNumberFromHighToLow;
        self.saleSortUpArrowButton.selected = NO;
        self.saleSortDownArrowButton.selected = YES;
    }else {
        self.sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
        self.saleSortUpArrowButton.selected = YES;
        self.saleSortDownArrowButton.selected = NO;
    }
}


- (void)_setPriceSortNumberToSortNumber {
    
    if (self.sortByNumber == kGoodsSortTypeNumberFromLowToHigh) {
        self.sortByNumber = kGoodsSortTypeNumberFromHighToLow;
        self.stockSortUpArrowButton.selected = NO;
        self.stockSortDownArrowButton.selected = YES;
    }else {
        self.stockSortUpArrowButton.selected = YES;
        self.stockSortDownArrowButton.selected = NO;
        self.sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
    }
}

- (void)_selectDeselecteGoodOfGoodsModel:(GoodsModel *)goodsModel {
    if (!goodsModel.selected) {
        self.allSelectButton.selected = NO;
        self.selectGoodsCount --;
    }else {
        self.selectGoodsCount ++;
        if (self.selectGoodsCount < self.goodsListTableView.dataLogicModule.currentDataModelArr.count) {
            self.allSelectButton.selected = NO;
        }else {
            self.allSelectButton.selected = YES;
        }
    }
}

- (NSString *)_getSelectedGoodsIdStr {
    NSArray *selectedGoodsIds = [self.goodsListTableView.dataLogicModule.currentDataModelArr sui_map:^NSString *(GoodsModel *goodsModel, NSUInteger index) {
        return goodsModel.selected ? goodsModel.goodsId : nil;
    }];
    return [selectedGoodsIds componentsJoinedByString:@","];
}

- (void)_selecteAllGoods:(BOOL)selectAllGoods {
    self.selectGoodsCount = 0;
    for (GoodsModel *goodsModel in self.goodsListTableView.dataLogicModule.currentDataModelArr) {
        goodsModel.selected = selectAllGoods;
        if (selectAllGoods) {
            self.selectGoodsCount ++;
        }
    }
    [self.goodsListTableView reloadData];
}

- (NSArray *)_dealCategaryResultData:(NSDictionary *)result {
    NSArray *resultArr = result[EntityKey];
    if (isEmpty(resultArr)) {
        return @[];
    }
    return [resultArr sui_map:^CommonCategaryModel *(NSDictionary * obj, NSUInteger index) {
        CommonCategaryModel *model = [CommonCategaryModel initWithGoodsCategaryDic:obj];
        return model;
    }];
}



- (void)_setReqeustGoodsCategaryCoposedStrWithGoodsCategaryIds:(NSArray *)goodsCategaryIdS {
    self.requestGoodsListComponsedCategaryId = [goodsCategaryIdS componentsJoinedByString:@"_"];
}

- (void)_requestGoodsDataConfigure {
    self.goodsListTableView.dataLogicModule.requestFromPage = 1;
    self.selectGoodsCount = 0;
    [self _requestGoodsData];
}

- (void)_configureTheFirstLevelCategaryTableWithDatas:(NSArray *)tranferedArr {
    CommonCategaryModel *model = tranferedArr.firstObject;
    model.selected = YES;
    self.goodsTypeNameTitleLabel.text = model.categaryName;
    self.firstLevelGoodsCategaryId = model.categaryId;
    self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr = [tranferedArr mutableCopy];
    [self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    [self.goodsFirstCategaryTableView reloadData];
}

- (void)_configureShelfButton {
    NSString *shelfButtonTitle = nil;
    if (self.shelfNumber.integerValue == kShelfNumberOnShelf) {
        shelfButtonTitle = @"下架";
    }else if (self.shelfNumber.integerValue == kShelfNumberOffShelf) {
        shelfButtonTitle = @"上架";
    }
    [self.onOffShelfButton setTitle:shelfButtonTitle forState:UIControlStateNormal];
}

- (void)_updateUiAndDatasourceAfterOnffShelf {
    
    NSMutableArray *willUpdateIndexPaths = [NSMutableArray arrayWithCapacity:self.goodsListTableView.dataLogicModule.currentDataModelArr.count];
    NSMutableIndexSet *willUpdateIndexSets = [[NSMutableIndexSet alloc] init];
    [self.goodsListTableView.dataLogicModule.currentDataModelArr enumerateObjectsUsingBlock:^(GoodsModel* goodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (goodsModel.selected) {
            [willUpdateIndexPaths addObject:goodsModel.modelAtIndexPath];
            [willUpdateIndexSets addIndexes:[NSIndexSet indexSetWithIndex:goodsModel.modelAtIndexPath.row]];
        }
    }];
    if (willUpdateIndexSets.count > 0) {
        [self.goodsListTableView.dataLogicModule.currentDataModelArr removeObjectsAtIndexes:willUpdateIndexSets];
        [self.goodsListTableView deleteRowsAtIndexPaths:willUpdateIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (void)_configureInfoAfterOnffShelf {
    self.allSelectButton.selected = NO;
    self.selectGoodsCount = 0;
    NSDictionary *postDic = @{kGoodsOnOffShelfNumberKey:self.shelfNumber,
                              kGoodsClassJoinedStrKey:self.requestGoodsListComponsedCategaryId};
    [kNotification postNotificationName:KNotificationGoodsOnOffShelfSuccess object:postDic];

}

- (void)_alertOnOffShelf {
    NSString *alertTitle = nil;
    if (self.shelfNumber.integerValue == kShelfNumberOffShelf) {
        alertTitle = @"确认要上架选中商品吗？";
    }else if (self.shelfNumber.integerValue == kShelfNumberOnShelf) {
        alertTitle = @"确认要下架选中商品吗？";
    }
    
    AlertViewManager *alertManager = [[AlertViewManager alloc] init];
    //两个action
    [alertManager showAlertViewWithControllerTitle:alertTitle message:alertTitle controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        
        [self _requestSetGoodsOnOffShelf];
        
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
    
    }];

}


#pragma mark ------------------------Api----------------------------------
- (void)_requestGoodsFirstLevelCategaryData {
        NSDictionary *requestParam = @{@"parentClassCode":TOP_LEVEL_CLASS};
        [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetGoodsTypelist block:^(NSDictionary *resultDic, NSError *error) {
            if (error.code != 1) {
                return;
            }
            NSArray *tranferedArr = [self _dealCategaryResultData:resultDic];
            [self _configureTheFirstLevelCategaryTableWithDatas:tranferedArr];
            [self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    
        }];
}

- (void)_requestGoodsData{
    
        NSDictionary *requestParam = @{@"classCode":self.requestGoodsListComponsedCategaryId,
                              @"orderBy":@(self.orderByNumber),
                              @"sortBy":@(self.sortByNumber),
                              @"enabledFlag":self.shelfNumber,
                              kRequestPageNumKey:@(self.goodsListTableView.dataLogicModule.requestFromPage),
                              kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
        [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GoodsSearch block:^(NSDictionary *resultDic, NSError *error) {
            if (isEmpty(resultDic[EntityKey])) {
                return ;
            }
            NSArray *resultArr = resultDic[EntityKey][ListKey];
            NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
            self.goodsListTableView.dataLogicModule.totalPage = [resultDic[EntityKey][kTotalPages] integerValue];
            [self.goodsListTableView configureTableAfterRequestPagingData:transferedArr];
            [self.goodsListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
            self.allSelectButton.selected = NO;
        }];
}

- (void)_requestSetGoodsOnOffShelf {
    
    NSInteger requestShelfNumber = 0;
    NSString *loadingTitle = nil;
    if (self.shelfNumber.integerValue == kShelfNumberOffShelf) {
        requestShelfNumber = kShelfNumberOnShelf;
        loadingTitle = @"正在上架商品..";
    }else if (self.shelfNumber.integerValue == kShelfNumberOnShelf) {
        requestShelfNumber = kShelfNumberOffShelf;
        loadingTitle = @"正在下架商品..";
    }
    NSDictionary *requestParam = @{@"saleProductIds":[self _getSelectedGoodsIdStr],
                                   @"enabledFlag":@(requestShelfNumber)
                                 };
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hub.labelText = loadingTitle;
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_SetGoodsOnOffShelf block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code  != 1) {
            hub.labelText = error.localizedDescription;
        }else {
            NSString *hideSuccessTitle = self.shelfNumber.integerValue == kShelfNumberOffShelf ? @"上架成功" : @"下架成功";
            hub.labelText = hideSuccessTitle;
            [self _updateUiAndDatasourceAfterOnffShelf];
            [self _configureInfoAfterOnffShelf];
            [self.goodsListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
        }
        [hub hide:YES afterDelay:0.8];
    }];
    
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterSearchPage {
    //    DLGoodsSearchVC *searchVC = [[DLGoodsSearchVC alloc] init];
    //    [self navigatePushViewController:searchVC animate:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)onOffShelfAction:(id)sender {
    [self _alertOnOffShelf];
}

- (IBAction)selectDeselectAllAction:(id)sender {
    UIButton *allSelectedButton = (UIButton *)sender;
    allSelectedButton.selected = !allSelectedButton.selected;
    [self _selecteAllGoods:allSelectedButton.selected];
}

- (IBAction)stockSortAction:(id)sender {
    
    if (self.stockSortButton.selected) {
        [self _setPriceSortNumberToSortNumber];
    }else {
        self.stockSortButton.selected = YES;
        self.stockSortUpArrowButton.selected = YES;
        self.saleVolumeButton.selected = NO;
        self.saleSortUpArrowButton.selected = NO;
        self.saleSortDownArrowButton.selected = NO;
        _sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
        self.orderByNumber = kGoodsSortNumberByStock;
    }
}

- (IBAction)saleValumeSortAction:(id)sender {
    
    if (self.saleVolumeButton.selected) {
        [self _setSaleVolomeNumberToSortNumber];
    }else {
        self.saleVolumeButton.selected = YES;
        self.saleSortUpArrowButton.selected = YES;
        self.stockSortButton.selected = NO;
        self.stockSortDownArrowButton.selected = NO;
        self.stockSortUpArrowButton.selected = NO;
        _sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
        self.orderByNumber = kGoodsSortNumberBySaleVolume;
    }
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------
- (void)observeGoodsOnOffShelfSuccess:(NSNotification *)info {
    
    NSDictionary *postDic = (NSDictionary *)info.object;
    
    NSNumber *onOffShelfNumber = postDic[kGoodsOnOffShelfNumberKey];
    if (onOffShelfNumber.integerValue == self.shelfNumber.integerValue) {
        return;
    }
    
    NSString *selectedGoodsClassJoinedStr = postDic[kGoodsClassJoinedStrKey];
    if ([selectedGoodsClassJoinedStr isEqualToString:self.requestGoodsListComponsedCategaryId]) {
        [self _requestGoodsDataConfigure];
    }

}

#pragma mark ------------------------Getter / Setter----------------------

- (void)setRequestGoodsListComponsedCategaryId:(NSString *)requestGoodsListComponsedCategaryId {
    if (!requestGoodsListComponsedCategaryId) {
        return;
    }
    _requestGoodsListComponsedCategaryId = requestGoodsListComponsedCategaryId;
    [self _requestGoodsDataConfigure];
}

- (void)setShelfNumber:(NSNumber *)shelfNumber {
    _shelfNumber = shelfNumber;
    [self _configureShelfButton];
    
}

- (void)setFirstLevelGoodsCategaryId:(NSString *)firstLevelGoodsCategaryId {
    if (!firstLevelGoodsCategaryId) {
        return;
    }
    _firstLevelGoodsCategaryId = firstLevelGoodsCategaryId;
    [self _setReqeustGoodsCategaryCoposedStrWithGoodsCategaryIds:@[_firstLevelGoodsCategaryId]];
    
}

- (void)setSecondeLevelGoodsCategaryId:(NSString *)secondeLevelGoodsCategaryId {
    _secondeLevelGoodsCategaryId = secondeLevelGoodsCategaryId;
    [self _setReqeustGoodsCategaryCoposedStrWithGoodsCategaryIds:@[_firstLevelGoodsCategaryId,_secondeLevelGoodsCategaryId]];
    
}

- (void)setOrderByNumber:(NSInteger)orderByNumber {
    _orderByNumber = orderByNumber;
    [self _requestGoodsDataConfigure];
}

- (void)setSortByNumber:(NSInteger)sortByNumber {
    _sortByNumber = sortByNumber;
    [self _requestGoodsDataConfigure];
}

- (void)setTrigerSelecteGoodsFirstLevelCategary:(BOOL)trigerSelecteGoodsFirstLevelCategary {
    _trigerSelecteGoodsFirstLevelCategary = trigerSelecteGoodsFirstLevelCategary;
    if (_trigerSelecteGoodsFirstLevelCategary) {
    }
}

- (void)setAllCategeryArr:(NSMutableArray *)allCategeryArr {
    _allCategeryArr = allCategeryArr;
}



@end
