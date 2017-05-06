//
//  DLSearchNearbyRegionVC.m
//  YilidiBuyer
//
//  Created by yld on 16/6/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSearchNearbyRegionVC.h"
#import "DLGoodsSearchTopView.h"
#import "MycommonTableView.h"
#import "DLSearchAdressKeyWordsListView.h"
#import "DLSearchAdressCell.h"
#import "DLNearbyRegionSearchHistoryView.h"
#import "DLCacheManager.h"
#import "UINavigationController+SUIAdditions.h"
#import "NSArray+extend.h"
#import "ProjectRelativeDefineNotification.h"
#import "GlobleConst.h"
#import "ShopCartGoodsManager.h"
#import "BaseTableView+nodataShow.h"
#import <Masonry/Masonry.h>

@interface DLSearchNearbyRegionVC ()
@property (nonatomic, strong)DLGoodsSearchTopView *goodsSearchTopView;
@property (nonatomic, strong)MycommonTableView *searchedAdressListTableView;
@property (nonatomic, strong)DLSearchAdressKeyWordsListView *adressSearchedKeyWordsListView;
@property (nonatomic, strong)DLNearbyRegionSearchHistoryView *nearbyRegionSearchHistoryView;
@property (nonatomic, copy)NSString *communitySearchKeyWords;

@end

@implementation DLSearchNearbyRegionVC

- (void)viewDidLoad {
    self.doNotNeedBaseBackItem = YES;
    [super viewDidLoad];
    
    [self _initnearbyRegionSearchHistoryView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (!_goodsSearchTopView) {
        [self _initGoodsSearchTopView];
    }else {
        _goodsSearchTopView.hidden = NO;
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [self.goodsSearchTopView removeFromSuperview];
    _goodsSearchTopView.hidden = YES;

}

#pragma mark ------------------------Init---------------------------------
-(void)_initGoodsSearchTopView {
    
    self.goodsSearchTopView = BoundNibView(@"DLGoodsSearchTopView", DLGoodsSearchTopView);
    [self.navigationController.view addSubview:self.goodsSearchTopView];
    WEAK_SELF
    [self.goodsSearchTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.navigationController.view.mas_top).with.offset(20);
        make.left.right.mas_equalTo(weak_self.navigationController.view);
        make.height.mas_equalTo(44);
    }];
    self.goodsSearchTopView.searchType = SearchType_Area;
    @weakify(self);
    [self.goodsSearchTopView.searchTextValidateSignal subscribeNext:^(NSNumber* validate) {
        @strongify(self);
        self.nearbyRegionSearchHistoryView.hidden = validate.integerValue;
        self.adressSearchedKeyWordsListView.hidden = !validate.integerValue;
        self.searchedAdressListTableView.hidden = YES;
    }];

    
    self.goodsSearchTopView.searchBackBlock = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.goodsSearchTopView.cancelSearchBlock = ^(){
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.goodsSearchTopView.beginSearchBlock = ^(NSString *keyWords){
        weak_self.communitySearchKeyWords = keyWords;
    };
}

- (void)_initnearbyRegionSearchHistoryView {
    
    [self.view addSubview:self.nearbyRegionSearchHistoryView];
    [_nearbyRegionSearchHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    WEAK_SELF
    _nearbyRegionSearchHistoryView.selectHistorySearchRegionBlock = ^(CommunityModel *model){
        [weak_self _judgeWhetherIntheShipRangeOfSelectedCommunityModel:model];
    };
}

- (void)_initSearchedAdressTableView {

    WEAK_SELF
    _searchedAdressListTableView.nodataAlertTitle = @"抱歉，没有搜到附近相关小区";
    _searchedAdressListTableView.cellHeight = kSearchedAdressCellHeight;
    [_searchedAdressListTableView configurecellNibName:@"DLSearchAdressCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        CommunityModel *model = (CommunityModel *)cellModel;
        DLSearchAdressCell *nearByCell = (DLSearchAdressCell *)cell;
        [nearByCell setNearbySearchAdressWithNearbyAdressModel:model];
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        CommunityModel *model = (CommunityModel *)cellModel;
        [[DLCacheManager sharedManager] cacheNearbyRegionSearchWithAdressModel:model];
        [weak_self _judgeWhetherIntheShipRangeOfSelectedCommunityModel:model];
        
    }];
    _searchedAdressListTableView.firstSectionHeaderHeight = 50;
    [_searchedAdressListTableView configureFirstSectioHeaderNibName:@"DLSearchedAdressSectionHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionHeaderView) {
      
    }];
}


#pragma mark ------------------------Private-------------------------
- (void)_selectCommunityBackWithCommunityModel:(CommunityModel *)communityModel {
    
    if (self.comeToNearBySearchPageType == ComeToNearBySearchPage_FromSwicthCommunity) {
        afterSecondsLoadData(1.0, [kNotification postNotificationName:KNotificationSwitchCommunity object:communityModel];)
        [self _backToHomePage];
    }else if (self.comeToNearBySearchPageType == ComeToNearBySearchPage_FromEditAddAdress){
        emptyBlock(self.searchNearbyRegionResultBlock,communityModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)_judgeWhetherIntheShipRangeOfSelectedCommunityModel:(CommunityModel *)communityModel {
    
    if (![self _judgeRelevanceStoreOfCommunity:communityModel]) {
         [self _alertSwitchCommunityWithCommunityModel:communityModel alertStr:kAlertTitleSwitchCommunityNoStoreAndNotInShipRange];
        return;
    }
    
    if (![communityModel.communityStore.storeId isEqualToString:kCommunityStoreId]) {
        if (self.comeToNearBySearchPageType == ComeToNearBySearchPage_FromSwicthCommunity) {
            [self _alertSwitchCommunityWithCommunityModel:communityModel alertStr:kAlertTitleSwitchCommunityNotInShipRange];
        }else {
            [self _selectCommunityBackWithCommunityModel:communityModel];
        }
    }else{
        [self _selectCommunityBackWithCommunityModel:communityModel];
    }
}

- (void)_alertSwitchCommunityWithCommunityModel:(CommunityModel *)communityModel alertStr:(NSString *)alertStr{
    [self showSimplyAlertWithTitle:@"提示" message:alertStr sureAction:^(UIAlertAction *action) {
        [self _selectCommunityBackWithCommunityModel:communityModel];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (BOOL)_judgeRelevanceStoreOfCommunity:(CommunityModel *)communityModel {
    BOOL hasCommunityRelevanceStore = YES;
    if (isEmpty(communityModel)) {
        return NO;
    }
    
    if (isEmpty(communityModel.communityStore)) {
        hasCommunityRelevanceStore = NO;
    }else {
        if (isEmpty(communityModel.communityStore.storeId)) {
            hasCommunityRelevanceStore = NO;
        }else {
            hasCommunityRelevanceStore = YES;
        }
    }
    return hasCommunityRelevanceStore;
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestCommunitySearchData {
    
    self.requestParam = @{@"keywords":self.communitySearchKeyWords};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_CommunitySearch block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transteredArr = [resultArr transferDicArrToModelArrWithModelClass:[CommunityModel class]];
        self.searchedAdressListTableView.dataLogicModule.currentDataModelArr = [transteredArr mutableCopy];
        [self.searchedAdressListTableView reloadData];
        [self.searchedAdressListTableView nodataShowDeal];
        self.adressSearchedKeyWordsListView.hidden = YES;
        self.searchedAdressListTableView.hidden = NO;

    }];
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_backToHomePage {
//    [self.navigationController sui_popToVC:@"DLHomeVC" animated:YES];
    emptyBlock(self.popToLastPageBlock);
    [self goBack];

}


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (void)setCommunitySearchKeyWords:(NSString *)communitySearchKeyWords {
    _communitySearchKeyWords = communitySearchKeyWords;
    [self _requestCommunitySearchData];
}


- (MycommonTableView *)searchedAdressListTableView {
    
    if (!_searchedAdressListTableView) {
        _searchedAdressListTableView = [[MycommonTableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight-kNavBarAndStatusBarHeight-10) style:UITableViewStyleGrouped];
        [self.view addSubview:_searchedAdressListTableView];
        [self _initSearchedAdressTableView];
    }
    return _searchedAdressListTableView;
}

- (DLSearchAdressKeyWordsListView *)adressSearchedKeyWordsListView {
    
    if (!_adressSearchedKeyWordsListView) {
        _adressSearchedKeyWordsListView = [DLSearchAdressKeyWordsListView new];
        [self.view addSubview:_adressSearchedKeyWordsListView];
        [_adressSearchedKeyWordsListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _adressSearchedKeyWordsListView;
}

- (DLNearbyRegionSearchHistoryView *)nearbyRegionSearchHistoryView {
    if (!_nearbyRegionSearchHistoryView) {
        _nearbyRegionSearchHistoryView = [DLNearbyRegionSearchHistoryView new];
    }
    return  _nearbyRegionSearchHistoryView;
}


@end
