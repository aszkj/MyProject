//
//  DLCommunityShopMarketVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsAllClassVC.h"
#import "MycommonTableView.h"
#import "DLTagShowView.h"
#import "CommonCategaryModel.h"
#import "DLCommunityGoodsFirstLevelCategaryCell.h"
#import "DLGoodsAllshowCell.h"
#import "SUIUtils.h"
#import "CommonCategaryModel.h"
#import "GlobleConst.h"
#import "DLHomeGoodsModel.h"
#import "ProjectRelativEmerator.h"
#import "DLNearChannelVC.h"
#import "DLGoodsSearchVC.h"
#import "DLGoodsSearchTopView.h"
#import "ProjectRelativeKey.h"
#import "DLGoodsdetailVC.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLAnimatePerformer.h"
#import "ShopCartView.h"
#import "DLShopCarVC.h"

const CGFloat firstClassGoodsWidthInPhone6 = 90;

@interface DLGoodsAllClassVC ()

@property (weak, nonatomic) IBOutlet MycommonTableView *goodsFirstCategaryTableView;
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsListTableView;
@property (nonatomic, strong)DLTagShowView *goodsCategarySelectView;

@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (nonatomic, strong)DLAnimatePerformer *animatePerformer;

@property (nonatomic, strong)NSMutableArray *allCategeryArr;
@property (nonatomic, strong)NSMutableArray *totalSortArr;

@property (nonatomic, copy)NSString *firstLevelGoodsCategaryId;
@property (nonatomic, copy)NSString *secondeLevelGoodsCategaryId;
@property (weak, nonatomic) IBOutlet UILabel *goodsTypeNameTitleLabel;

@property (nonatomic, copy)NSString *requestGoodsListComponsedCategaryId;
@property (nonatomic, assign)NSInteger requestGoodsListSortNumber;

@property (nonatomic, assign)SiftGoodsRuleType siftGoodsRuleType;
@property (nonatomic, assign)BOOL trigerSelecteGoodsFirstLevelCategary;
@property (nonatomic, strong)DLGoodsSearchTopView *goodsSearchTopView;

/**
 *  根据什么进行排序 1 价格，2 销量
 */
@property (nonatomic, assign)NSInteger orderByNumber;
/**
 *  排序从低到高1 从高到低2
 */
@property (nonatomic, assign)NSInteger sortByNumber;

@property (weak, nonatomic) IBOutlet UIButton *priceSortButton;
@property (weak, nonatomic) IBOutlet UIButton *priceSortDownArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *priceSortUpArrowButton;

@property (weak, nonatomic) IBOutlet UIButton *saleVolumeButton;
@property (weak, nonatomic) IBOutlet UIButton *saleSortUpArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *saleSortDownArrowButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstClassGoodsTableWidthConstraint;

@end

@implementation DLGoodsAllClassVC

- (void)viewDidLoad {
    self.doNotNeedBaseBackItem = YES;
    [super viewDidLoad];
    [self _init];
    [self showHubWithDefaultStatus];
    [self _requestGoodsFirstLevelCategaryData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _initGoodsSearchTopView];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.goodsSearchTopView removeFromSuperview];

}


#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    [self _initInfo];
    
    [self _initGoodsFirstLevelCategaryTableView];
    
    [self _initgoodsListTableView];
}

-(void)_initInfo {
    
   _orderByNumber = kGoodsSortNumberByPrice;
    _sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
    _trigerSelecteGoodsFirstLevelCategary = NO;
    self.firstClassGoodsTableWidthConstraint.constant = ADAPT_SCREEN_WIDTH(firstClassGoodsWidthInPhone6);
    WEAK_SELF
    self.shopCartView.gotoShopCartPageBlock = ^{
        [weak_self _enterShopCartPage];
    };
    
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
    self.goodsSearchTopView.searchType = SearchType_Goods;
    
    self.goodsSearchTopView.clickToBeginSearchBlock = ^{
        [weak_self _enterSearchPage];
    };
    self.goodsSearchTopView.noCancel = YES;
    self.goodsSearchTopView.searchBackBlock = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.goodsSearchTopView.cancelSearchBlock = ^(){
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
}

- (void)_performAddShopCartAnimationUsingImgView:(UIImageView *)animationImageView isAdd:(BOOL)isAdd{
    
    if (!isAdd) {
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
        return;
    }
    self.goodsListTableView.scrollEnabled = NO;
    WEAK_SELF
    [self.animatePerformer performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animationImageView animateEndPoint: CGPointMake(kScreenWidth-34-50/2, kScreenHeight-58 - 50/2) animateDidEndBlock:^{
        weak_self.goodsListTableView.scrollEnabled = YES;
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
    }];
}


- (void)_initgoodsListTableView {
    
    WEAK_SELF
    self.goodsListTableView.cellHeight = GoodsAllshowHeight;
    [self.goodsListTableView configurecellNibName:@"DLGoodsAllshowCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
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

    [self.goodsListTableView headerRreshRequestBlock:^{
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
        firstLevelCategaryCell.titleLabel.textColor = (model.selected ? [UIColor redColor] : [UIColor darkTextColor]);
        firstLevelCategaryCell.lineView.backgroundColor = (model.selected ? [UIColor redColor] : UIColorFromRGB(0xE3E5E5));

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
- (NSArray *)getTotalSortArr{
    CommonCategaryModel *model1 = [[CommonCategaryModel alloc] init];
    model1.categaryName = @"价格从低到高";
    model1.selected = YES;
    
    CommonCategaryModel *model2 = [[CommonCategaryModel alloc] init];
    model2.categaryName = @"价格从高到低";
    model2.selected = NO;
    
    CommonCategaryModel *model3 = [[CommonCategaryModel alloc] init];
    model3.categaryName = @"销量从低到高";
    model3.selected = NO;
    
    CommonCategaryModel *model4 = [[CommonCategaryModel alloc] init];
    model4.categaryName = @"销量从高到低";
    model4.selected = NO;

    NSArray *goodsTotalSortArr = @[model1,model2,model3,model4];
    return goodsTotalSortArr;
}

- (void)_goodsSecondCategaryShowWithData:(NSArray *)datas {
    [self.goodsCategarySelectView showWithData:datas];
}

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
        self.priceSortUpArrowButton.selected = NO;
        self.priceSortDownArrowButton.selected = YES;
    }else {
        self.priceSortUpArrowButton.selected = YES;
        self.priceSortDownArrowButton.selected = NO;
        self.sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
    }
}

- (NSArray *)_dealCategaryResultData:(NSDictionary *)result {
    NSArray *resultArr = result[EntityKey];
    return [resultArr sui_map:^CommonCategaryModel *(NSDictionary * obj, NSUInteger index) {
        CommonCategaryModel *model = [CommonCategaryModel initWithGoodsCategaryDic:obj];
//        if (index == 0) {
//            model.selected = YES;
//        }
        return model;
    }];
}

- (void)_setReqeustGoodsCategaryCoposedStrWithGoodsCategaryIds:(NSArray *)goodsCategaryIdS {
    self.requestGoodsListComponsedCategaryId = [goodsCategaryIdS componentsJoinedByString:@"_"];
}

- (void)_switchDifferentGoodsSiftRuleToShow {
    if (self.siftGoodsRuleType == SelecteGoodsTotalSortType) {
        [self _goodsSecondCategaryShowWithData:self.totalSortArr];
    }else {
        if (self.allCategeryArr.count > 0) {
            if (self.trigerSelecteGoodsFirstLevelCategary) {
                [self _requestGoodsSecondLevelDataByGoodsFirstLevelCategaryId:self.firstLevelGoodsCategaryId];
            }else {
                [self _goodsSecondCategaryShowWithData:self.allCategeryArr];
            }
        }else {
            [self _requestGoodsSecondLevelDataByGoodsFirstLevelCategaryId:self.firstLevelGoodsCategaryId];
        }
    }
}

- (void)_selectGoodsFirstLevelCategaryConfigureUi {
    
    if (_goodsCategarySelectView.isOpen) {
        [self _switchDifferentGoodsSiftRuleToShow];
    }else {
    
    }
}

- (void)_requestGoodsDataConfigure {
    self.goodsListTableView.dataLogicModule.requestFromPage = 1;
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

- (NSArray *)_getFirstlevelData {
    
    CommonCategaryModel *model1 = [[CommonCategaryModel alloc] init];
    model1.categaryName = @"香蕉";
    
    CommonCategaryModel *model2 = [[CommonCategaryModel alloc] init];
    model2.categaryName = @"栗子";
    
    CommonCategaryModel *model3 = [[CommonCategaryModel alloc] init];
    model3.categaryName = @"蜜桃";
    
    return @[model1,model2,model3];
}

- (NSArray *)_getGoodsData {
    GoodsModel *model1 = [[GoodsModel alloc] init];
    model1.goodsName = @"水果绿茶";
    model1.goodsId = @"123";
    model1.goodsOriginalPrice = @(10.9);
    model1.goodsVipPrice = @(11.0);
    model1.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model2 = [[GoodsModel alloc] init];
    model2.goodsId = @"124";
    model2.goodsName = @"水果绿茶";
    model2.goodsOriginalPrice = @(11.0);
    model2.goodsVipPrice = @(11.0);
    model2.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model3 = [[GoodsModel alloc] init];
    model3.goodsName = @"水果绿茶";
    model3.goodsId = @"125";
    model3.goodsOriginalPrice = @(12.0);
    model3.goodsVipPrice = @(11.0);
    model3.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model4 = [[GoodsModel alloc] init];
    model4.goodsName = @"水果绿茶";
    model4.goodsId = @"126";
    model4.goodsOriginalPrice = @(13.0);
    model4.goodsVipPrice = @(11.0);
    model4.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model5 = [[GoodsModel alloc] init];
    model5.goodsId = @"127";
    model5.goodsName = @"水果绿茶";
    model5.goodsOriginalPrice = @(14.0);
    model5.goodsVipPrice = @(11.0);
    model5.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model6 = [[GoodsModel alloc] init];
    model6.goodsName = @"水果绿茶";
    model6.goodsId = @"123";
    model6.goodsOriginalPrice = @(15.0);
    model6.goodsVipPrice = @(11.0);
    model6.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    return @[model1,model2,model3,model4,model5,model6];
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestGoodsFirstLevelCategaryData {
    NSString *storeId = [CommunityDataManager sharedManager].communityModel.communityStore.storeId;
    self.requestParam = @{@"parentClassCode":TOP_CLASS_CODE,
                          @"storeId":storeId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GoodsTypeList block:^(NSDictionary *resultDic, NSError *error) {
            NSArray *tranferedArr = [self _dealCategaryResultData:resultDic];
            [self _configureTheFirstLevelCategaryTableWithDatas:tranferedArr];

    }];
}

- (void)_requestGoodsData{
    self.requestParam = @{@"parentClassCode":self.requestGoodsListComponsedCategaryId,
                          @"orderBy":@(self.orderByNumber),
                          @"sortBy":@(self.sortByNumber),
                          KCommutityIdKey:kCommunityId,
                          kRequestPageNumKey:@(self.goodsListTableView.dataLogicModule.requestFromPage),
                          kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GoodsSearch parameters:self.requestParam block:^(id result, NSError *error) {
        [self dissmiss];
        NSArray *resultArr = result[EntityKey][@"list"];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [self.goodsListTableView configureTableAfterRequestData:transferedArr];
    }];
    
}

- (void)_requestGoodsSecondLevelDataByGoodsFirstLevelCategaryId:(NSString *)firstLevelId{
    self.requestParam = @{@"categoryId":firstLevelId};
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GoodsSecondLevelCategary parameters:self.requestParam block:^(id result, NSError *error) {
        NSArray *tranferedArr = [self _dealCategaryResultData:result];
        self.allCategeryArr = [tranferedArr mutableCopy];
        _trigerSelecteGoodsFirstLevelCategary = NO;
    }];
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterShopListPage{
    
    DLNearChannelVC *nearByShopVC= [[DLNearChannelVC alloc]init];
    [self navigatePushViewController:nearByShopVC animate:YES];
}

- (void)_enterSearchPage {
    DLGoodsSearchVC *searchVC = [[DLGoodsSearchVC alloc] init];
    [self navigatePushViewController:searchVC animate:YES];
}

- (void)_enterGoodsDetailPageWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}

- (void)_enterShopCartPage {
    DLShopCarVC *shopCartVC = [[DLShopCarVC alloc] init];
    [self navigatePushViewController:shopCartVC animate:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)allCategaryAction:(id)sender {
    self.siftGoodsRuleType = SelectGoodsAllCategaryType;
}

- (IBAction)totalSortAction:(id)sender {
    self.siftGoodsRuleType = SelecteGoodsTotalSortType;
}

- (IBAction)priceSortAction:(id)sender {
    
    if (self.priceSortButton.selected) {
        [self _setPriceSortNumberToSortNumber];
    }else {
        self.priceSortButton.selected = YES;
        self.priceSortUpArrowButton.selected = YES;
        self.saleVolumeButton.selected = NO;
        self.saleSortUpArrowButton.selected = NO;
        self.saleSortDownArrowButton.selected = NO;
        _sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
        self.orderByNumber = kGoodsSortNumberByPrice;
    }
}

- (IBAction)saleValumeSortAction:(id)sender {
    
    if (self.saleVolumeButton.selected) {
        [self _setSaleVolomeNumberToSortNumber];
    }else {
        self.saleVolumeButton.selected = YES;
        self.saleSortUpArrowButton.selected = YES;
        self.priceSortButton.selected = NO;
        self.priceSortDownArrowButton.selected = NO;
        self.priceSortUpArrowButton.selected = NO;
        _sortByNumber = kGoodsSortTypeNumberFromLowToHigh;
        self.orderByNumber = kGoodsSortNumberBySaleVolume;

    }

}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (void)setRequestGoodsListComponsedCategaryId:(NSString *)requestGoodsListComponsedCategaryId {
    if (!requestGoodsListComponsedCategaryId) {
        return;
    }
    _requestGoodsListComponsedCategaryId = requestGoodsListComponsedCategaryId;
    [self _requestGoodsDataConfigure];
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

- (void)setSiftGoodsRuleType:(SiftGoodsRuleType)siftGoodsRuleType {
    _siftGoodsRuleType = siftGoodsRuleType;
    [self _switchDifferentGoodsSiftRuleToShow];
}

- (void)setTrigerSelecteGoodsFirstLevelCategary:(BOOL)trigerSelecteGoodsFirstLevelCategary {
    _trigerSelecteGoodsFirstLevelCategary = trigerSelecteGoodsFirstLevelCategary;
    if (_trigerSelecteGoodsFirstLevelCategary) {
        [self _selectGoodsFirstLevelCategaryConfigureUi];
    }
}

- (void)setAllCategeryArr:(NSMutableArray *)allCategeryArr {
    _allCategeryArr = allCategeryArr;
    [self _goodsSecondCategaryShowWithData:_allCategeryArr];
}

-(DLTagShowView *)goodsCategarySelectView {
    
    if (!_goodsCategarySelectView) {
        _goodsCategarySelectView = [DLTagShowView new];
        [self.view addSubview:_goodsCategarySelectView];
        WEAK_SELF
        [_goodsCategarySelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.goodsListTableView.mas_top).with.offset(-5);
            make.left.bottom.right.mas_equalTo(weak_self.goodsListTableView);
        }];
        _goodsCategarySelectView.selectItemBlock = ^(CommonCategaryModel *model){
            NSNumber *selectId = model.categaryId;
            if (weak_self.siftGoodsRuleType == SelecteGoodsTotalSortType) {
                weak_self.requestGoodsListSortNumber = selectId.integerValue;
            }else {
                weak_self.secondeLevelGoodsCategaryId = selectId;
            }
        };
    }
    return _goodsCategarySelectView;

}

- (NSMutableArray *)totalSortArr {
    
    if (!_totalSortArr) {
        _totalSortArr = [NSMutableArray arrayWithArray:[self getTotalSortArr]];
        [_totalSortArr setIndexPathInselfContainer];
    }
    return _totalSortArr;
}

- (DLAnimatePerformer *)animatePerformer {
    
    if (!_animatePerformer) {
        _animatePerformer = [[DLAnimatePerformer alloc] init];
    }
    return _animatePerformer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
