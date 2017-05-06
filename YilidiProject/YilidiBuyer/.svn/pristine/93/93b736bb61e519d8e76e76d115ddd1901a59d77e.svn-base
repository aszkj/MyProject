//
//  DLNearByAdressSearchVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLLocationNearByRegionListVC.h"
#import "MycommonTableView.h"
#import "DLSearchAdressCell.h"
#import "BaiduLocationManage.h"
#import "SUIUtils.h"
#import "GlobleConst.h"
#import "NSArray+extend.h"
#import "UINavigationController+SUIAdditions.h"
#import "UIViewController+hub.h"
#import "ProjectRelativeDefineNotification.h"
#import "BaseTableView+nodataShow.h"
@interface DLLocationNearByRegionListVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet MycommonTableView *nearBySearchTableView;
@property (nonatomic, copy)NSString *cityCode;
@property (nonatomic, assign)CGFloat latitude;
@property (nonatomic, assign)CGFloat longtitude;
@property (nonatomic, copy)NSString *city;



@end

@implementation DLLocationNearByRegionListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _startLocation];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [self _reuqestLocationNearbyAdressData];
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.cityCode = @"440300";
    self.latitude = kDefaultlatitude;
    self.longtitude = kDefaultlongtitude;
    self.pageTitle = @"你当前地址列表";
    [self _initAdressNearByTableView];
}

- (void)_startLocation {
    [self showHubWithStatus:@"正在获取定位小区列表.."];
//    WEAK_SELF
//    [[BaiduLocationManage shareManage] startLocationBackBlock:^(CLLocation *location, NSString *city) {
//        weak_self.latitude = location.coordinate.latitude;
//        weak_self.longtitude = location.coordinate.longitude;
//        weak_self.city = city;
//        [weak_self _reuqestLocationNearbyAdressData];
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
    BaiduLocationManage *baiduLocationManager = [BaiduLocationManage shareManage];
    self.latitude = baiduLocationManager.latitude;
    self.longtitude = baiduLocationManager.longtitude;
    [self _reuqestLocationNearbyAdressData];
    

}


-(void)_initAdressNearByTableView {
    self.nearBySearchTableView.cellHeight = kSearchedAdressCellHeight;
    self.nearBySearchTableView.noDataLogicModule.nodataAlertTitle = @"抱歉，没有定位到相关小区";
    WEAK_SELF
    [self.nearBySearchTableView configurecellNibName:@"DLSearchAdressCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        CommunityModel *nearBymodel = (CommunityModel *)cellModel;
        DLSearchAdressCell *nearbyCell = (DLSearchAdressCell *)cell;
        [nearbyCell setNearbySearchAdressWithNearbyAdressModel:nearBymodel];
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        CommunityModel *nearBymodel = (CommunityModel *)cellModel;
        if (weak_self.selecteOneCanbeShipedRegionAdressBlock) {
            weak_self.selecteOneCanbeShipedRegionAdressBlock(nearBymodel);
            [weak_self.navigationController popViewControllerAnimated:YES];
        }else {
            [weak_self _judgeWhetherIntheShipRangeOfSelectedCommunityModel:nearBymodel];
        }
    }];
}


#pragma mark ------------------------Private-------------------------
- (void)_dealSearchResultData:(NSDictionary *)result {
    NSArray *responseArr = result[EntityKey][@"list"];
    NSArray *transteredArr = [responseArr transferDicArrToModelArrWithModelClass:[CommunityModel class]];
    self.nearBySearchTableView.dataLogicModule.currentDataModelArr = [transteredArr mutableCopy];
    [self.nearBySearchTableView nodataShowDeal];
    [self.nearBySearchTableView reloadData];
}

- (void)_selectCommunityBackWithCommunityModel:(CommunityModel *)communityModel {
    
    afterSecondsLoadData(1.0, [kNotification postNotificationName:KNotificationSwitchCommunity object:communityModel];)
//    [self.navigationController sui_popToVC:@"DLHomeVC" animated:YES];
    emptyBlock(self.popToLastPageBlock);
    [self goBack];
    
}

- (void)_judgeWhetherIntheShipRangeOfSelectedCommunityModel:(CommunityModel *)communityModel {
    
    if (isEmpty(communityModel.communityStore.storeId) && isEmpty(kCommunityStoreId)){
        [self _selectCommunityBackWithCommunityModel:communityModel];
        return;
    }
    
    if (![communityModel.communityStore.storeId isEqualToString:kCommunityStoreId]) {
        [self showSimplyAlertWithTitle:@"提示" message:kAlertTitleSwitchCommunityNotInShipRange sureAction:^(UIAlertAction *action) {
            [self _selectCommunityBackWithCommunityModel:communityModel];
        } cancelAction:^(UIAlertAction *action) {
            
        }];
        
    }else{
        [self _selectCommunityBackWithCommunityModel:communityModel];
    }
}



#pragma mark ------------------------Api----------------------------------
- (void)_reuqestLocationNearbyAdressData {
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [mutableDic setObject:@(self.latitude) forKey:@"latitude"];
    [mutableDic setObject:@(self.longtitude) forKey:@"longitude"];
    [AFNHttpRequestOPManager postWithParameters:mutableDic subUrl:kUrl_LocateNearbyRegion block:^(NSDictionary *resultDic, NSError *error) {
        [self dissmiss];
        [self _dealSearchResultData:resultDic];
    }];
}

#pragma mark ------------------------View Event---------------------------
#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
