//
//  DLDispatchGoodsManageVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLDispatchGoodsManageVC.h"
#import "MycommonTableView.h"
#import "CommonCategaryModel.h"
#import "DLCommunityGoodsFirstLevelCategaryCell.h"
#import "SUIUtils.h"
#import "CommonCategaryModel.h"
#import "GlobleConst.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"
#import "NSObject+setModelIndexPath.h"
#import "DLDispatchGoodsCell.h"
#import "DLDispatchGoodsOrderVC.h"
#import "DispatchGoodsManager.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLInvoiceManagementVC.h"
#import <Masonry/Masonry.h>
const CGFloat theFirstClassGoodsWidthInPhone6 = 85;
@interface DLDispatchGoodsManageVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsFirstCategaryTableView;
@property (weak, nonatomic) IBOutlet MycommonTableView *goodsListTableView;


@property (nonatomic, copy)NSString *firstLevelGoodsCategaryId;
@property (nonatomic, copy)NSString *secondeLevelGoodsCategaryId;
@property (weak, nonatomic) IBOutlet UILabel *goodsTypeNameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dispatchGoodsCountLabel;

@property (nonatomic, copy)NSString *requestGoodsListComponsedCategaryId;

@property (nonatomic, assign)BOOL trigerSelecteGoodsFirstLevelCategary;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstClassGoodsTableWidthConstraint;

@property (nonatomic, strong)DispatchGoodsManager *dispatchGoodsManager;


@end

@implementation DLDispatchGoodsManageVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _init];
    
    [self _requestGoodsFirstLevelCategaryData];
    
//    [self _requestGoodsData];

}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    [self _initInfo];
    
    [self _initRightItem];
    
    [self _initGoodsFirstLevelCategaryTableView];
    
    [self _initgoodsListTableView];
}

- (void)_initRightItem {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"record" target:self action:@selector(_enterDispatchOrderListPage)];
}

-(void)_initInfo {
    _trigerSelecteGoodsFirstLevelCategary = NO;
    self.pageTitle = @"调货商品管理";
    self.firstClassGoodsTableWidthConstraint.constant = ADAPT_SCREEN_WIDTH(theFirstClassGoodsWidthInPhone6);
    @weakify(self);
    [RACObserve(self.dispatchGoodsManager, shopCartGoodsNumber) subscribeNext:^(NSNumber *selectedShopCartGoodsNumber) {
        @strongify(self);
        NSString *title = [NSString stringWithFormat:@"商品总数：%ld件",        selectedShopCartGoodsNumber.integerValue];
        self.dispatchGoodsCountLabel.text = title;
    }];
}

- (void)_initgoodsListTableView {
    
    WEAK_SELF
    CGFloat cellHeight = DispatchGoodsCellHeight;
//    if (kScreenWidth == iPhone5_width) {//屏幕宽度为32
//        cellHeight = ADAPT_SCREEN_WIDTH(70) + 50;
//    }
    self.goodsListTableView.cellHeight = cellHeight;
    self.goodsListTableView.noDataLogicModule.nodataAlertTitle = @"暂无可调货商品";
    [self.goodsListTableView configurecellNibName:@"DLDispatchGoodsCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLDispatchGoodsCell *goodsCell = (DLDispatchGoodsCell *)cell;
        CGFloat cellImgBgWidthHeight = DispatchGoodsCellImgWidth;
//        if (kScreenWidth ==iPhone5_width ) {
//            cellImgBgWidthHeight = ADAPT_SCREEN_WIDTH(70);
//        }
        goodsCell.imgBgViewWidthConstraint.constant = cellImgBgWidthHeight ;
        goodsCell.imgBgViewHeightConstraint.constant = cellImgBgWidthHeight ;
        GoodsModel *model = (GoodsModel *)cellModel;
        [goodsCell setCellModel:model];
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
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
- (NSArray *)_dealCategaryResultData:(NSDictionary *)result {
    NSArray *resultArr = result[EntityKey];
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
    model1.categaryName = @"香蕉香蕉";
    model1.selected = YES;
    
    CommonCategaryModel *model2 = [[CommonCategaryModel alloc] init];
    model2.categaryName = @"栗子栗子";
    model2.selected = NO;
    
    CommonCategaryModel *model3 = [[CommonCategaryModel alloc] init];
    model3.categaryName = @"蜜桃蜜桃";
    model3.selected = NO;
    
    return @[model1,model2,model3];
}

- (NSArray *)_getGoodsData {
    GoodsModel *model1 = [[GoodsModel alloc] init];
    model1.goodsName = @"水果绿茶";
    model1.goodsId = @"123";
    model1.goodsStock = @(100);
    model1.minuteResposityStock = @(1000);
    model1.basicOrderNumber = @(2);
    model1.goodsSalesVulome = @(50);
    model1.goodsPurchasePrice = @(9.9);
    model1.goodsOriginalPrice = @(10.9);
    model1.goodsVipPrice = @(11.0);
    model1.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model2 = [[GoodsModel alloc] init];
    model2.goodsName = @"水果绿茶";
    model2.goodsId = @"124";
    model2.goodsStock = @(100);
    model2.minuteResposityStock = @(1000);
    model2.basicOrderNumber = @(2);
    model2.goodsSalesVulome = @(50);
    model2.goodsPurchasePrice = @(9.9);
    model2.goodsOriginalPrice = @(10.9);
    model2.goodsVipPrice = @(11.0);
    model2.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model3 = [[GoodsModel alloc] init];
    model3.goodsName = @"水果绿茶";
    model3.goodsId = @"125";
    model3.goodsStock = @(100);
    model3.minuteResposityStock = @(1000);
    model3.basicOrderNumber = @(2);
    model3.goodsSalesVulome = @(50);
    model3.goodsPurchasePrice = @(9.9);
    model3.goodsOriginalPrice = @(10.9);
    model3.goodsVipPrice = @(11.0);
    model3.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";

    return @[model1,model2,model3];
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
//    self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr = [[self _getFirstlevelData] mutableCopy];
//    [self.goodsFirstCategaryTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
//    [self.goodsFirstCategaryTableView reloadData];
}

- (void)_requestGoodsData{
    NSDictionary *requestParam = @{@"classCode":self.requestGoodsListComponsedCategaryId,
                                   kRequestPageNumKey:@(self.goodsListTableView.dataLogicModule.requestFromPage),
                                   kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_SearchDispatchGoodsByGoodsClass block:^(NSDictionary *resultDic, NSError *error) {
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [self.goodsListTableView configureTableAfterRequestPagingData:transferedArr];
        [self.goodsListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    }];
    
//    self.goodsListTableView.dataLogicModule.currentDataModelArr = [[self _getGoodsData] mutableCopy];
//    [self.goodsListTableView reloadData];
    
}

- (void)_requestConfigureDispatchGoods {
    NSArray *dispatchGoodsArr = self.dispatchGoodsManager.allGoodsIdToNumberArr;
    if (!dispatchGoodsArr.count) {
        [self hideHubWithOnlyText:@"你还未添加调货商品"];
        return;
    }
    [self showLoadingHub];
    self.requestParam = @{@"allotInfo":dispatchGoodsArr};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_ConfiureDispatchGoods block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code == 1) {
            if (isEmpty(resultDic[EntityKey])) {
                return ;
            }
            [self _enterDispathShopCartGoodsPageWithResultInfo:resultDic[EntityKey]];
        }else {
            [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        }
    }];
}

#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterDispathShopCartGoodsPageWithResultInfo:(NSDictionary *)resultInfo {
    DLDispatchGoodsOrderVC *dispatchGoodsOrderVC = [[DLDispatchGoodsOrderVC alloc] init];
    dispatchGoodsOrderVC.confiureDispatchGoodsResultInfo = resultInfo;
    [self navigatePushViewController:dispatchGoodsOrderVC animate:YES];
}

- (void)_enterDispatchOrderListPage {
    DLInvoiceManagementVC *dispatchOrderListPage = [[DLInvoiceManagementVC alloc] init];
    [self navigatePushViewController:dispatchOrderListPage animate:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)addTheDispatchGoodsOrderAction:(id)sender {
    [self _requestConfigureDispatchGoods];
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


- (DispatchGoodsManager *)dispatchGoodsManager {
    if (!_dispatchGoodsManager) {
        _dispatchGoodsManager = [DispatchGoodsManager sharedManager];
    }
    return _dispatchGoodsManager;
}



@end
