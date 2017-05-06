//
//  DLHomeVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeVC.h"
#import "DLHomeFoodCollectionView.h"
#import "GlobleConst.h"
#import "DLHomeGoodsModel.h"
#import "DLHomeHeaderView.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLHomeTopView.h"
#import "ProjectRelativeKey.h"
#import "DLAnimatePerformer.h"
#import "DLDataLoaderGifHub.h"
#import "UIView+BlockGesture.h"
#import "DLGoodsSearchVC.h"
#import "DLGoodsDetailVC.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "GoodsModel.h"
#import "DLSelectSearchShippedCommunityVC.h"
#import "DLHomeGoodsClassModel.h"
#import "DLGoodsdetailVC.h"
#import "DLGoodsAllClassVC.h"
#import "CommunityDataManager.h"
#import "UIViewController+showShopCartPage.h"
#import "DLShopCarVC.h"
#import "BaiduLocationManage.h"
#import "ShopCartGoodsManager+switchCommunity.h"
#import "UIViewController+unLoginHandle.h"
#import "DLHomeSecondSectionHeaderView.h"
#import "HomeGotErrorView.h"
#import "DLMainTabBarController.h"
#import "ProjectRelativeMaco.h"
#import <Masonry/Masonry.h>
#import "DLWeekRecommendedVC.h"
#import "DLGlobleRequestApiManager.h"
#import "UserLocationManager.h"
#import "DLVipAndPennyGoodsVC.h"
#import "DLScanQRViewController.h"
#import "DLClosingAlertView.h"
#import "DLClassificationZoneVC.h"
#import "DLSeckillActivityVC.h"
#import "DLHomeFloorModel.h"
#import "DLInfoMationVC.h"
#import "NSDictionary+SUISafeAccess.h"
#import "DLShowFloorGoodsVC.h"
#import "DLRedPacketEntrancePageVC.h"
#import "DLHomeGotRedPacketView.h"
#import "RedPacketGameManager.h"
#import "DLMyWalletVC.h"
#import "UIViewController+adLinkDataJumpHandler.h"
#import "DLCordovaTestViewController.h"

@interface DLHomeVC ()

@property (weak, nonatomic) IBOutlet DLHomeFoodCollectionView *homeFoodCollectionView;

@property (nonatomic, strong)DLHomeTopView *homeTopView;

@property (nonatomic, strong)HomeGotErrorView *homeGotErrorView;

@property (nonatomic, strong)DLClosingAlertView *storeCloseShowView;

@property (nonatomic, strong)DLHomeGotRedPacketView *homeGotRedPacketView;

@property (nonatomic, strong)DLAnimatePerformer *animatePerformer;

@property (nonatomic, assign)NSInteger communityGoodsRequestPageNum;


@property (nonatomic, assign)BOOL hasLoadedHeaderData;

@property (nonatomic, strong)UserLocationManager *userLocationManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewTobottomGapConstraint;


#pragma mark - refresh data
@property (nonatomic, assign)BOOL hasSuccessLocated;

@property (nonatomic, assign)BOOL hasLoadedStoreData;

@property (nonatomic, assign)BOOL hasLoadedTopAdData;

@property (nonatomic, assign)CGFloat locatedLatitude;
@property (nonatomic, assign)CGFloat locatedLongtitude;


@end

@implementation DLHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    
    [self _initHomeFoodCollectionView];
    
    [self _loadTopBarView];
    
    [self _loadHomeData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _registerNotofication];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.userLocationManager.enterHomePage = YES;
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    /*这里为什么加上这个，是因为我们应用的tabbar是全部自己写的，而非系统的，隐藏tabbar和出现tabbar都是自己的方式在基类的viewWillAppear中实现，导致当时出现了一个问题，再从第一级push到第二级，再返回到第一级self.view向下扩展了tabbar的部分即扩展到了tabbar的底部，而我们需要的是在一级的时候self.view始终应该是在它的顶部的，所以此处做了这个特殊处理，让self.view始终在tabbar上面*/
     self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-49);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.userLocationManager.leaveHomePage = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [kNotification removeObserver:self];
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.pageTitle = @"首页";
    self.communityGoodsRequestPageNum = 1;
}

- (void)_loadTopBarView {
    
    [self.view addSubview:self.homeTopView];
    [self.homeTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
}

- (void)_loadHomeData {
    if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
        if ([CommunityDataManager sharedManager].hasLocatedOrSelectedCommunity) {
            [self _configureHomePageData];
        }else {
#if TARGET_IPHONE_SIMULATOR//模拟器
            [self _requestNearbyDefaultShopWithLogintitude:kDefaultlongtitude latitude:kDefaultlatitude];
#elif TARGET_OS_IPHONE//真机
            [self  _startUserLocation];
#endif
        }
    }else if (kCurrentShipWay == ShipWay_SelfTake) {
        [self _configureHomePageData];
    }

}

- (void)_startUserLocation {
    [self showHubWithDefaultStatus];
    WEAK_SELF
    [self.userLocationManager startUserLocationBackBlock:^(CLLocation *location, NSString *city) {
        if (weak_self.hasSuccessLocated) {
            return ;
        }else {
            CGFloat lontitude = location.coordinate.longitude;
            CGFloat latitude = location.coordinate.latitude;
            if (latitude && lontitude) {
                JLog(@"latitude -- %.4f",location.coordinate.latitude);
                JLog(@"longtitude -- %.4f",location.coordinate.longitude);
                weak_self.hasSuccessLocated = YES;
                self.locatedLatitude = latitude;
                self.locatedLongtitude = lontitude;
                [self _requestNearbyDefaultShopWithLogintitude:lontitude latitude:latitude];
            }
        }
    } errorBlock:^(NSError *error) {
//        [Util ShowAlertWithOnlyMessage:@"定位失败"];
        [self dissmiss];

    }];
}


- (void)_initHomeFoodCollectionView {
    self.homeFoodCollectionView.collectionViewLayout = self.homeFoodCollectionView.homeFoodCollectionViewLayout;
    //上下拉刷新
    WEAK_SELF
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self.homeFoodCollectionView.mj_footer   resetNoMoreData];
        weak_self.communityGoodsRequestPageNum = 1;
        [weak_self _requestFloorInfo];
        [weak_self.homeFoodCollectionView.homeFirstSectionView requestSeckillActivityCrazyStratchInfo];
        [weak_self _refreshHomeButNotGoodsData];
    }];
    
    self.homeFoodCollectionView.mj_header = header;
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.0f];

    
    self.homeFoodCollectionView.clickGoodsCellBlock = ^(GoodsModel *goodsModel){
//        [weak_self _enterGoodsDetailWithGoodsId:goodsModel.goodsId];
        [kNotification postNotificationName:KNotificationLookGoodsDetail object:@{kLinkDataKeyGoodsDetail:goodsModel.goodsId}];
    };
    self.homeFoodCollectionView.scrollContentOffsetBlock = ^(CGFloat contentOffset){
        UIColor *barColor = KSelectedBgColor;
         weak_self.homeTopView.bgView.backgroundColor=[barColor colorWithAlphaComponent:contentOffset / 200];
        weak_self.homeTopView.bgView.hidden = contentOffset < 30;
        weak_self.homeTopView.communityNameBgView.hidden = contentOffset > 80;
        weak_self.homeTopView.scanButtonBgView.hidden = contentOffset > 80;
        weak_self.homeTopView.searchButtonBgView.hidden = contentOffset > 80;
        weak_self.homeTopView.topSearchView.alpha = contentOffset / 150;
        if (contentOffset < 0) {
            weak_self.homeTopView.hidden = -contentOffset > 50;
        }else {
            weak_self.homeTopView.hidden = NO;
        }
     };
}

#pragma mark -------------------Private Method----------------------
- (void)_registerNotofication {
    [self registerLinkDataJumpNotification];
    [kNotification addObserver:self selector:@selector(observeShopCartNumberChange:) name:KNotificationShopCartGoodsChange object:nil];
    [kNotification addObserver:self selector:@selector(observeToSelecteNearbyShops:) name:KNotificationSelecteNearbyShops object:nil];
    [kNotification addObserver:self selector:@selector(observeToDifferentGoodsTypeData:) name:KNotificationLookDifferentGoodsTypeData object:nil];
    [kNotification addObserver:self selector:@selector(observeToSearchPage:) name:KNotificationComeToSearchPage object:nil];
    [kNotification addObserver:self selector:@selector(observeSwitchCommunity:) name:KNotificationSwitchCommunity object:nil];
    [kNotification addObserver:self selector:@selector(observeStoreSelfTake:) name:KNotificationSwitchStoreSelfTake object:nil];
     [kNotification addObserver:self selector:@selector(observeToFloorGoodsPage:) name:KNotificationComeToInfoMationPage object:nil];
    [self registerShowShowCartPageNotification];
    [self registerComeToLoginPageFromPerHomePageNotification];

}

- (void)_refreshHomeButNotGoodsData {
    
    if (!self.hasSuccessLocated) {
        [self _startUserLocation];
    }else {
        if (!self.hasLoadedStoreData) {
            [self _requestNearbyDefaultShopWithLogintitude:self.locatedLongtitude latitude:self.locatedLatitude];
        }else {
            if (!self.hasLoadedTopAdData) {
                [self _requetHeaderLoopData];
            }
        }
    }
}

- (void)_switchCommunityWithNewCommunityModel:(CommunityModel *)communityModel {

    [[ShopCartGoodsManager sharedManager] switchCommunityLogic];
    [CommunityDataManager sharedManager].communityModel = communityModel;
    [self _configureHomePageData];
}

- (void)_switchSelfTakeStoreWithNewStoreModel:(StoreModel *)storeModel {
    [[ShopCartGoodsManager sharedManager] switchCommunityLogic];
    [CommunityDataManager sharedManager].currentStore = storeModel;
    [self _configureHomePageData];
}

- (void)_configureHomePageData {
    
    [self _configureTopViewTitle];
    [self _initShopCartNumber];
    if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
        if (![self _dealWhetherRelevanceStoreCondistionOfCommunity:kCurrentCummunity]) {
            return;
        }
    }else if (kCurrentShipWay == ShipWay_SelfTake) {
        self.homeGotErrorView.hidden = YES;
        self.homeFoodCollectionView.scrollEnabled = YES;
    }
    [self _configureStoreStatus];
    [self _checkLastGrabRedPacketGameExceptionCondition];
    [self _requestFloorInfo];
    [self _requestVipPennyGoodsData];
}

- (void)_configureTopViewTitle {
    NSString *homeHeaderDisplayTitle = nil;
    if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
        homeHeaderDisplayTitle = kCurrentCummunity.communityName;
    }else if (kCurrentShipWay == ShipWay_SelfTake){
        homeHeaderDisplayTitle = jFormat(@"自提门店：%@",kCurrentStore.storeName);
    }
    self.homeTopView.communityName = homeHeaderDisplayTitle;
}

- (void)_checkLastGrabRedPacketGameExceptionCondition {
    RedPacketGameManager *redPacketManager = [[RedPacketGameManager alloc] init];
    if ([redPacketManager hasTheExceptionConditionForLastRedPacketGame]) {
        self.homeGotRedPacketView.hidden = NO;
        [redPacketManager resetGrabRedPacketGameFlowStatus];
    }
}

- (void)_initShopCartNumber {
    
    DLMainTabBarController *mainVC = (DLMainTabBarController *)rootController;
    if ([mainVC isMemberOfClass:[DLMainTabBarController class]]) {
        DLMainTabBarController *mainVC = (DLMainTabBarController *)rootController;
        mainVC.shopCartBadgeNumber = [ShopCartGoodsManager sharedManager].shopCartGoodsNumber;
    }
}

- (void)_compareDealLastCommunityModelWithLocatideCommunityModel:(CommunityModel *)locatideCommunityModel {
    
    StoreModel *lastStoreModel = [CommunityDataManager sharedManager].currentStore;
    if (isEmpty(lastStoreModel)) {
        [[ShopCartGoodsManager sharedManager] clearAllShopCartData];
    }else {
        if (![self _judgeRelevanceStoreOfCommunity:locatideCommunityModel]) {
            [[ShopCartGoodsManager sharedManager] clearAllShopCartData];
        }else {
            if (![locatideCommunityModel.communityStore.storeId isEqualToString:lastStoreModel.storeId]) {
                [[ShopCartGoodsManager sharedManager] clearAllShopCartData];
            }
        }
    }
}

- (void)_dealFloorRequestInfo:(NSArray *)floorInfos {
    if (isEmpty(floorInfos)) {
        return;
    }
    NSMutableArray *floorList = [NSMutableArray arrayWithCapacity:floorInfos.count];
    for (NSDictionary *floorInfo in floorInfos) {
        DLHomeFloorModel *floorModel = [[DLHomeFloorModel alloc] init];
        if (!isEmpty(floorInfo[@"floorInfo"])) {
            DLHomeFloorBaseInfoModel *floorBasicInfoModel = [[DLHomeFloorBaseInfoModel alloc] initWithDefaultDataDic:floorInfo[@"floorInfo"]];
            floorModel.floorBaseInfoModel = floorBasicInfoModel;
        }
        
        if (!isEmpty(floorInfo[@"advertisementInfo"])) {
            DLHomeFloorAdInfoModel *floorAdInfoModel = [[DLHomeFloorAdInfoModel alloc] initWithDefaultDataDic:floorInfo[@"advertisementInfo"]];
            floorModel.floorAdInfoModel = floorAdInfoModel;
        }
        
        floorModel.floodHeaderAndAdPartHeight = [self _floorHeaderAndAdPartHeightOfFloorModel:floorModel];
        [floorList addObject:floorModel];
    }
    self.homeFoodCollectionView.floorList = [floorList copy];
    [self.homeFoodCollectionView reloadData];
    if (self.communityGoodsRequestPageNum == 1) {
        [self.homeFoodCollectionView.mj_header endRefreshing];
    }else {
    
    }
}

- (CGFloat)_floorHeaderAndAdPartHeightOfFloorModel:(DLHomeFloorModel *)floorModel {

    if (!isEmpty(floorModel.floorBaseInfoModel) && !isEmpty(floorModel.floorAdInfoModel)) {
        if (floorModel.floorBaseInfoModel.floorProductList.count) {
            return kCommunityWellSelectSectionHeaderHeight;
        }else {
            return kCommunityWellSelectImgHeight;
        }
    }else if (!isEmpty(floorModel.floorBaseInfoModel) && isEmpty(floorModel.floorAdInfoModel)){
        if (floorModel.floorBaseInfoModel.floorProductList.count) {
            return kOtherPartHeightBesidesImg;
        }else {
            return 0;
        }
    }else if (isEmpty(floorModel.floorBaseInfoModel) && !isEmpty(floorModel.floorAdInfoModel)){
        return kCommunityWellSelectImgHeight;
    }
    return 0;
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

- (BOOL)_dealWhetherRelevanceStoreCondistionOfCommunity:(CommunityModel *)communityModel {
    BOOL hasRelevanceStore = [self _judgeRelevanceStoreOfCommunity:communityModel];
    self.homeGotErrorView.hidden = hasRelevanceStore;
    self.homeFoodCollectionView.scrollEnabled = hasRelevanceStore;
    return hasRelevanceStore;
}

- (void)_performAddShopCartAnimationUsingImgView:(UIImageView *)animationImageView isAdd:(BOOL)isAdd{
    
    if (!isAdd) {
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
        return;
    }
    self.homeFoodCollectionView.scrollEnabled = NO;
    WEAK_SELF
    [self.animatePerformer performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:animationImageView animateEndPoint: CGPointMake((kScreenWidth/4.0)*2-(kScreenWidth/4.0)/2, kScreenHeight-20) animateDidEndBlock:^{
        weak_self.homeFoodCollectionView.scrollEnabled = YES;
        [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(isAdd)];
    }];
}

- (void)_switchToCommunityWithNewCommunityModel:(CommunityModel *)communityModel{
    self.homeFoodCollectionView.contentOffset = CGPointMake(0, 0);
    [self _switchCommunityWithNewCommunityModel:communityModel];
}

- (void)_switchToSelfTakeWithNewStoreModel:(StoreModel *)storeModel {
    self.homeFoodCollectionView.contentOffset = CGPointMake(0, 0);
    [self _switchSelfTakeStoreWithNewStoreModel:storeModel];
}

- (void)_alertLocatedNewCommunity:(CommunityModel *)locatedNewCommunityModel {
    [self showSimplyAlertWithTitle:@"提示" message:kAlertUserLocationHasChanged sureAction:^(UIAlertAction *action) {
        [self _switchToCommunityWithNewCommunityModel:locatedNewCommunityModel];
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}

- (void)_configureStoreStatus {
    NSString *storeIsNotInBussinessTimeAlert = nil;
    if (!kCurrentCummunityStoreBusinessStatus) {
        storeIsNotInBussinessTimeAlert = kAlertStoreIsClosed;
    }else if (kCurrentStoreOnbusinessTimeNumber == 1) {
        storeIsNotInBussinessTimeAlert = kAlertStoreNotOnBusinessTime;
    }else if (kCurrentStoreOnbusinessTimeNumber == -1) {
        storeIsNotInBussinessTimeAlert = kAlertStoreFrontOfTheBusinessTime;
    }
    if (storeIsNotInBussinessTimeAlert) {
        self.storeCloseShowView.hidden = NO;
        self.storeCloseShowView.alertTitle = storeIsNotInBussinessTimeAlert;
    }

}

- (void)_configureUIWhenStoreOnNotInBussinessTime {
    

}

- (void)_addShopCartAction:(NSNotification *)info{
    UIImageView *willAnimateImgView = (UIImageView *)info.userInfo[kwillAnimateGoodsViewKey];
    BOOL isAdd = [info.userInfo[KGoodsChangeIsAddKey] boolValue];
    [self _performAddShopCartAnimationUsingImgView:willAnimateImgView isAdd:isAdd];
    
}



#pragma mark -------------------PageNavigate----------------------
- (void)_enterFloorGoodsPage:(NSDictionary *)info {
    
    DLShowFloorGoodsVC *floorVC = [[DLShowFloorGoodsVC alloc]init];
    floorVC.infoDic = info;
    [self navigatePushViewController:floorVC animate:YES];
}

- (void)_enterShopListPage{
    
    DLSelectSearchShippedCommunityVC *selectShopVC= [[DLSelectSearchShippedCommunityVC alloc]init];
    [self navigatePushViewController:selectShopVC animate:YES];
    
}

- (void)_enterScanGoodsPage {
//    DLScanQRViewController *scanQRVC = [[DLScanQRViewController alloc] init];
//    [self navigatePushViewController:scanQRVC animate:YES];
    DLCordovaTestViewController *cordavaTestVC = [[DLCordovaTestViewController alloc] init];
    [self navigatePushViewController:cordavaTestVC animate:YES];
}

- (void)_enterAllGoodsShowPageWithGoodsTypeNumber:(NSInteger)goodsTypeNumber {
   
    DLWeekRecommendedVC *weekVC = [[DLWeekRecommendedVC alloc]init];
    [self navigatePushViewController:weekVC animate:YES];
 }

- (void)_enterSearchPage {
    DLGoodsSearchVC *searchVC = [[DLGoodsSearchVC alloc] init];
    [self navigatePushViewController:searchVC animate:YES];
}

- (void)_enterMyWalletPage {
    DLMyWalletVC *myWalletVC = [[DLMyWalletVC alloc] init];
    myWalletVC.index = 0;
    [self navigatePushViewController:myWalletVC animate:YES];
}

#pragma mark ------------------------Api----------------------------------
- (void)_requestHeaderData {
    [self _requetHeaderLoopData];
}

- (void)_requetHeaderLoopData {
    self.requestParam = @{@"type":ADVERTISEMENTTYPE_HOMEBANNER};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_HomeHeaderLoopPlayUrl block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *resultArr = resultDic[EntityKey];
        if (isEmpty(resultArr)) {
            resultArr = @[];
        }
        if (resultArr.count > 0) {
            self.hasLoadedTopAdData = YES;
        }
        self.homeFoodCollectionView.homeFirstSectionView.headerLoopArr = resultArr;
        [self _requestHomeSeckillActivityAdData];
    }];
}

- (void)_requestHomeSpecialSubjectAdData {
    self.requestParam = @{@"type":ADVERTISEMENTTYPE_SEMINAR};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_HomeHeaderLoopPlayUrl block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *resultArr = [resultDic sui_arrayForKey:EntityKey];
        if (resultArr.count >= 3) {
            self.homeFoodCollectionView.headerHeight = kDlhomeHeaderViewTotalHeight;
        }else{
            self.homeFoodCollectionView.headerHeight = kDlhomeHeaderViewTotalHeight-kSpecaiSubjectSecondlPartHeight-5;
        }
        self.homeFoodCollectionView.homeFirstSectionView.headerSpecialSubjectAdArr = resultArr;
//        [self.homeFoodCollectionView reloadData];
//        self.hasLoadedHeaderData = YES;
        [self _requestHolidayAdData];
    }];
}

- (void)_requestHolidayAdData {
    self.requestParam = @{@"type":ADVERTISEMENTTYPE_FESTIVALACT};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_HomeHeaderLoopPlayUrl block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *resultArr = [resultDic sui_arrayForKey:EntityKey];
        if (!resultArr.count) {
            self.homeFoodCollectionView.headerHeight -= kHolidayAdPartHeight;
        }
        self.homeFoodCollectionView.homeFirstSectionView.headerHolidayAdArr = resultArr;
        [self.homeFoodCollectionView reloadData];
    }];
}






- (void)_requestHomeSeckillActivityAdData {
    self.requestParam = @{@"type":ADVERTISEMENTTYPE_SECKILL};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_HomeHeaderLoopPlayUrl block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *resultArr = resultDic[EntityKey];
        self.homeFoodCollectionView.homeFirstSectionView.headerSeckillAdArr = resultArr;
        [self _requestHomeSpecialSubjectAdData];
    }];

}

- (void)_requestNearbyDefaultShopWithLogintitude:(CGFloat)longtitude latitude:(CGFloat)latitude {
    
    [AFNHttpRequestOPManager requestNearbyShopWithlongtitude:longtitude latitude:latitude block:^(id result, NSError *error) {
        if (error.code == RequestFailedServiceErrorCode) {
            [self dissmiss];
            return ;
        }
        
        CommunityModel *communityModel = [[CommunityModel alloc] initWithDefaultDataDic:result[EntityKey]];
        [self _compareDealLastCommunityModelWithLocatideCommunityModel:communityModel];
        [CommunityDataManager sharedManager].communityModel = communityModel;
        
        if (![self _judgeRelevanceStoreOfCommunity:communityModel]) {
            [self dissmiss];
        }else {
            self.hasLoadedStoreData = YES;
        }
        [self _configureHomePageData];
        
    }];
}

- (void)_requestVipPennyGoodsData {
    
    [[DLGlobleRequestApiManager sharedManager] requestPennyGoodsWithBackBlock:^(id result, NSError *error) {
        
        [[DLGlobleRequestApiManager sharedManager] requestVipGoodsWithBackBlock:^(id result, NSError *error) {
            
        }];
    }];
}

- (void)_requestFloorInfo {
    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    self.requestParam = @{KStoreIdKey:kCommunityStoreId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetHomeFloorInfo block:^(NSDictionary *resultDic, NSError *error) {
        [self _dealFloorRequestInfo:resultDic[EntityKey]];
        [self dissmiss];
        [self _configureUIWhenStoreOnNotInBussinessTime];
        if (!self.hasLoadedHeaderData) {
            [self.homeFoodCollectionView.homeFirstSectionView requestSeckillActivityCrazyStratchInfo];
            [self _requestHeaderData];
        }
    }];

}

#pragma mark ------------------------View Event---------------------------
#pragma mark ------------------------Delegate-----------------------------
#pragma mark ------------------------Notification-------------------------
- (void)observeToFloorGoodsPage:(NSNotification *)info {
    [self _enterFloorGoodsPage:info.object];
}

- (void)observeShopCartNumberChange:(NSNotification *)info {
    [self _addShopCartAction:info];
}

- (void)observeToSelecteNearbyShops:(NSNotification *)info {
    [self _enterShopListPage];
}

- (void)observeToDifferentGoodsTypeData:(NSNotification *)info {
    NSInteger goodsTypeNumber = [(NSNumber *)info.object integerValue];
    [self _enterAllGoodsShowPageWithGoodsTypeNumber:goodsTypeNumber];
}

- (void)observeToSearchPage:(NSNotification *)info {
    [self _enterSearchPage];
}

- (void)observeSwitchCommunity:(NSNotification *)notification {
    CommunityModel *newCommunityModel = notification.object;
    if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
        if ([newCommunityModel.communityId isEqualToString:kCommunityId]) {
            return;
        }
    }else if (kCurrentShipWay == ShipWay_SelfTake) {
        if (!isEmpty(newCommunityModel.communityStore.storeId)) {
            if ([newCommunityModel.communityStore.storeId isEqualToString:kCommunityStoreId]) {
                kCurrentShipWay = ShipWay_DeliveryGoodsHome;
                [CommunityDataManager sharedManager].communityModel = newCommunityModel;
                [self _configureTopViewTitle];
                return;
            }
        }
    }
    self.userLocationManager.userSwitchedCommuntiByHand = YES;
    [self _switchToCommunityWithNewCommunityModel:newCommunityModel];

}

- (void)observeStoreSelfTake:(NSNotification *)info {
    StoreModel *newStoreModel = info.object;
    if ([newStoreModel.storeId isEqualToString:kCommunityStoreId]) {
        if (kCurrentShipWay == ShipWay_DeliveryGoodsHome) {
            kCurrentShipWay = ShipWay_SelfTake;
            [self _configureTopViewTitle];
        }
        return;
    }
    self.userLocationManager.userSwitchedCommuntiByHand = YES;
    [self _switchToSelfTakeWithNewStoreModel:newStoreModel];
}


#pragma mark ------------------------Getter / Setter----------------------
- (DLAnimatePerformer *)animatePerformer {

    if (!_animatePerformer) {
        _animatePerformer = [[DLAnimatePerformer alloc] init];
    }
    return _animatePerformer;
}

- (HomeGotErrorView *)homeGotErrorView {
    if (!_homeGotErrorView) {
        _homeGotErrorView = BoundNibView(@"HomeGotErrorView", HomeGotErrorView);
        [self.view addSubview:_homeGotErrorView];
        [_homeGotErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kDLhomeHeaderCycleViewHeight);
            make.left.right.bottom.mas_equalTo(self.view);
        }];
    }
    return _homeGotErrorView;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (DLClosingAlertView *)storeCloseShowView {
    if (!_storeCloseShowView) {
        _storeCloseShowView = BoundNibView(@"DLClosingAlertView", DLClosingAlertView);
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_storeCloseShowView];
        [_storeCloseShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(keyWindow);
        }];
    }
    return _storeCloseShowView;
}

- (DLHomeGotRedPacketView *)homeGotRedPacketView{
    if (!_homeGotRedPacketView) {
        WEAK_SELF
        _homeGotRedPacketView = BoundNibView(@"DLHomeGotRedPacketView", DLHomeGotRedPacketView);
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:_homeGotRedPacketView];
        [_homeGotRedPacketView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.bottom.mas_equalTo(keyWindow);
        }];
        __weak DLClosingAlertView *storeCloseView = _storeCloseShowView;
        _homeGotRedPacketView.lookMyRedPacketBlock = ^{
            [weak_self _enterMyWalletPage];
            if (storeCloseView) {
                weak_self.storeCloseShowView.hidden = YES;
            }
        };
    }
    return _homeGotRedPacketView;
}


- (DLHomeTopView *)homeTopView {
    
    if (!_homeTopView) {
        WEAK_SELF
        _homeTopView = BoundNibView(@"DLHomeTopView", DLHomeTopView);
        _homeTopView.selectdShopBlock = ^{
            [weak_self _enterShopListPage];
        };
        
        _homeTopView.beginSearchBlock = ^{
            [weak_self _enterSearchPage];
        };
        
        _homeTopView.scanGoodsBlock = ^{
            [weak_self _enterScanGoodsPage];
        };

        
    }
    return _homeTopView;
}

- (UserLocationManager *)userLocationManager {
    
    if (!_userLocationManager) {
        WEAK_SELF
        _userLocationManager = [UserLocationManager sharedManager];
        _userLocationManager.userLocationCommunityChangeBlcok = ^(CommunityModel *locatiedNewModel){
            [weak_self _alertLocatedNewCommunity:locatiedNewModel];
        };
    }
    return _userLocationManager;
}

- (void)dealloc
{
    [kNotification removeObserver:self name:KNotificationLoginPageWasDissmissed object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
