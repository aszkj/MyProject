//
//  GoodsManageView.m
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ClassifitionGoodsManageView.h"
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
#import "DLClassfitionGoodsCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIView+Constraints.h"
#import "UIView+Toast.h"

const NSInteger unKnownSortRuleNumber = -1001;
const NSString *goodsClassCodeKey = @"classCode";
const NSString *goodsSortRuleKey = @"goodsSortRuleKey";

@interface ClassifitionGoodsManageView()

@property (weak, nonatomic) IBOutlet MycommonTableView *goodsListTableView;

@property (weak, nonatomic) IBOutlet UIButton *onOffShelfButton;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;

@property (nonatomic,copy) NSString *goodsClassCode;
@property (nonatomic,assign) NSInteger sortRuleNumber;

@property (nonatomic, assign)NSInteger selectGoodsCount;


@property (weak, nonatomic) IBOutlet UIView *bottomOperateOnOffShelfView;


@end

@implementation ClassifitionGoodsManageView

- (void)awakeFromNib {
    
    [self _init];

    [self _registerNotification];
//    [self _requestGoodsData];

}

#pragma mark ---------------------Public Method------------------------------
- (void)setGoodsClassCode:(NSString *)goodsClassCode
           sortRuleNumber:(NSInteger)sortRuleNumber
{

    if (![self _isChangedOfGoodsClassCode:goodsClassCode sortRuleNumber:sortRuleNumber]) {
        return;
    }
    self.goodsClassCode = goodsClassCode;
    self.sortRuleNumber = sortRuleNumber;
    [self _requestGoodsDataConfigure];
}



#pragma mark ------------------------Init---------------------------------
-(void)_init {
    
    [self _initInfo];
    
    [self _initgoodsListTableView];
}

-(void)_initInfo {
 
    self.sortRuleNumber = unKnownSortRuleNumber;
    self.bottomOperateOnOffShelfView.hidden = IsShareStock;
    self.bottomOperateOnOffShelfView.heightConstraint.constant = IsShareStock ? 0 : self.bottomOperateOnOffShelfView.heightConstraint.constant;
}

- (void)_registerNotification {
    [kNotification addObserver:self selector:@selector(observeGoodsOnOffShelfSuccess:) name:KNotificationGoodsOnOffShelfSuccess object:nil];
}

- (void)_initgoodsListTableView {
    
    WEAK_SELF
    self.goodsListTableView.cellHeight = kDLClassfitionGoodsCellHeight;
    JLog(@"cellHeight ---- %.2f",GoodsAllshowHeight);
    self.goodsListTableView.noDataLogicModule.nodataAlertTitle = @"暂无商品";
    [self.goodsListTableView configurecellNibName:@"DLClassfitionGoodsCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLClassfitionGoodsCell *goodsCell = (DLClassfitionGoodsCell *)cell;
        GoodsModel *model = (GoodsModel *)cellModel;
        WEAK_OBJ(model)
        [goodsCell setGoodsCellModel:model];
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


#pragma mark ------------------------Private-------------------------
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

- (void)_requestGoodsDataConfigure {
    self.goodsListTableView.dataLogicModule.requestFromPage = 1;
    self.selectGoodsCount = 0;
    [self _requestGoodsData];
}

- (BOOL)_isChangedOfGoodsClassCode:(NSString *)goodsClassCode sortRuleNumber:(NSInteger)sortRuleNumber{
    
    if (isEmpty(self.goodsClassCode) || self.sortRuleNumber == unKnownSortRuleNumber) {
        return YES;
    }
    
    if (![goodsClassCode isEqualToString:self.goodsClassCode] || sortRuleNumber != self.sortRuleNumber) {
        return YES;
    }
    
    return NO;
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
    NSMutableDictionary *postDic = [NSMutableDictionary dictionaryWithCapacity:5];
    [postDic setObject:self.shelfNumber forKey:kGoodsOnOffShelfNumberKey];
    if (!self.updateDataJustByShelfNumber) {
        [self _setClassCodeAndSortRuleNumberToParam:postDic];
    }
    [kNotification postNotificationName:KNotificationGoodsOnOffShelfSuccess object:postDic];

}

- (void)_setClassCodeAndSortRuleNumberToParam:(NSMutableDictionary *)param {
    if (self.goodsClassCode) {
        [param setObject:self.goodsClassCode forKey:goodsClassCodeKey];
    }
    if (self.sortRuleNumber != unKnownSortRuleNumber) {
        [param setObject:@(self.sortRuleNumber) forKey:goodsSortRuleKey];
    }
}

- (BOOL)_hasSelectGoods {
    return !isEmpty([self _getSelectedGoodsIdStr]);
}

- (void)_alertOnOffShelf {
    
    AlertViewManager *alertManager = [[AlertViewManager alloc] init];
    
    if (![self _hasSelectGoods]) {
        [self makeToast:@"请选中要上架或下架的商品" duration:3.0f position:CSToastPositionCenter];
        return ;
    }
    
    NSString *alertTitle = nil;
    if (self.shelfNumber.integerValue == kShelfNumberOffShelf) {
        alertTitle = @"确认要上架选中商品吗？";
    }else if (self.shelfNumber.integerValue == kShelfNumberOnShelf) {
        alertTitle = @"确认要下架选中商品吗？";
    }
    
    //两个action
    [alertManager showAlertViewWithControllerTitle:alertTitle message:alertTitle controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        
        [self _requestSetGoodsOnOffShelf];
        
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
    
    }];
}

- (void)_handleResultDic:(NSDictionary *) resultDic{
    NSArray *resultArr = resultDic[EntityKey][ListKey];
    NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
    self.goodsListTableView.dataLogicModule.totalPage = [resultDic[EntityKey][kTotalPages] integerValue];
    [self.goodsListTableView configureTableAfterRequestPagingData:transferedArr];
    [self.goodsListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    self.allSelectButton.selected = NO;
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestGoodsData{
    
    if (self.updateDataJustByShelfNumber) {
        [self _requestBrandGoodsData];
    }else {
        [self _requestClassGoodsData];
    }
}

- (void)_requestBrandGoodsData {
    
    NSDictionary *requestParam = @{@"brandCode":self.brandCode,
                                   @"enabledFlag":self.shelfNumber,
                                   kRequestPageNumKey:@(self.goodsListTableView.dataLogicModule.requestFromPage),
                                   kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetBrandGoodsList block:^(NSDictionary *resultDic, NSError *error) {
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        [self _handleResultDic:resultDic];
    }];
}

- (void)_requestClassGoodsData {
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:5];
    [requestParam setObject:self.shelfNumber forKey:@"enabledFlag"];
    [requestParam setObject:@(self.goodsListTableView.dataLogicModule.requestFromPage) forKey:kRequestPageNumKey];
    [requestParam setObject:@(kRequestDefaultPageSize) forKey:kRequestPageSizeKey];
    
    if (!self.updateDataJustByShelfNumber) {
        if (self.goodsClassCode) {
            [requestParam setObject:self.goodsClassCode forKey:goodsClassCodeKey];
        }
        if (self.sortRuleNumber != unKnownSortRuleNumber) {
            NSInteger orderByNumber = self.sortRuleNumber / 10;
            NSInteger sortByNumber = self.sortRuleNumber - orderByNumber * 10;
            [requestParam setObject:@(orderByNumber) forKey:@"orderBy"];
            [requestParam setObject:@(sortByNumber) forKey:@"sortBy"];
        }
    }
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GoodsSearch block:^(NSDictionary *resultDic, NSError *error) {
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        [self _handleResultDic:resultDic];
    }];

}

- (void)_setTestData {
    GoodsModel *model1 = [[GoodsModel alloc] init];
    model1.goodsName = @"测试";
    model1.goodsId = @"123";
    
    GoodsModel *model2 = [[GoodsModel alloc] init];
    model2.goodsName = @"测试";
    model2.goodsId = @"124";
    
    GoodsModel *model3 = [[GoodsModel alloc] init];
    model3.goodsName = @"测试";
    model3.goodsId = @"125";

    self.goodsListTableView.dataLogicModule.currentDataModelArr = [@[model1,model2,model3] mutableCopy];
    [self.goodsListTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    [self.goodsListTableView reloadData];
    self.allSelectButton.selected = NO;
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

#pragma mark ------------------------View Event---------------------------
- (IBAction)onOffShelfAction:(id)sender {
    [self _alertOnOffShelf];
}

- (IBAction)selectDeselectAllAction:(id)sender {
    UIButton *allSelectedButton = (UIButton *)sender;
    allSelectedButton.selected = !allSelectedButton.selected;
    [self _selecteAllGoods:allSelectedButton.selected];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------
- (void)observeGoodsOnOffShelfSuccess:(NSNotification *)info {
    
    NSDictionary *postDic = (NSDictionary *)info.object;
    
    NSNumber *onOffShelfNumber = postDic[kGoodsOnOffShelfNumberKey];
    if (onOffShelfNumber.integerValue == self.shelfNumber.integerValue) {
        return;
    }
    
    if (self.updateDataJustByShelfNumber) {
        [self _requestGoodsDataConfigure];
    }else {
        NSString *onOffShelfGoodsClassCode = postDic[goodsClassCodeKey];
        NSInteger onOffShelfGoodsSortRuleNumber = [postDic[goodsSortRuleKey] integerValue];
        if (![self _isChangedOfGoodsClassCode:onOffShelfGoodsClassCode sortRuleNumber:onOffShelfGoodsSortRuleNumber]) {
            [self _requestGoodsDataConfigure];
        }
    }
}

#pragma mark ------------------------Getter / Setter----------------------
- (void)setShelfNumber:(NSNumber *)shelfNumber {
    _shelfNumber = shelfNumber;
    [self _configureShelfButton];
    if (self.updateDataJustByShelfNumber) {
        [self _requestGoodsDataConfigure];
//        [self performSelector:@selector(_requestGoodsDataConfigure) withObject:nil afterDelay:0.3];
    }
    
}

@end
