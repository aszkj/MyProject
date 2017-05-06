//
//  DLSeckillActivityVC.m
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSeckillActivityVC.h"
#import "SeckillActivitySceneView.h"
#import "SeckillActivityModel.h"
#import "ProjectRelativeKey.h"
#import "GlobleConst.h"
#import "NSDate+Addition.h"
#import "CountDownView.h"
#import "NSArray+extend.h"
#import "MycommonTableView.h"
#import "DLSecondsKillZoneCell.h"
#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"
#import "ProjectRelativeDefineNotification.h"
#import "ShopCartView.h"
#import "DLShopCarVC.h"
#import "DLAnimatePerformer.h"
#import "UIViewController+unLoginHandle.h"
#import "NSObject+setModelIndexPath.h"
#import "DLGoodsdetailVC.h"
#import "DLAnimatePerformer+business.h"

const CGFloat activityViewHeight = 52.0f;
const CGFloat activityLeftTimeViewHeight = 30.0f;

@interface DLSeckillActivityVC ()

@property (weak, nonatomic) IBOutlet SeckillActivitySceneView *seckillActivitySceneView;
@property (nonatomic, copy)NSArray *secKillActivitylist;
@property (nonatomic, strong)SeckillActivityModel *currentSelectedSecKillActivityModel;
@property (weak, nonatomic) IBOutlet UILabel *activityStatusMarkLeftLabel;
@property (weak, nonatomic) IBOutlet MycommonTableView *activityGoodsTableView;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeTypeLabel;
@property (weak, nonatomic) IBOutlet CountDownView *leftTimeView;

@property (weak, nonatomic) IBOutlet ShopCartView *shopCartView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTimeViewHeightConstraint;

@property (nonatomic, strong)NSTimer *activityCountDownTimer;
/**
 *  第一次进入的本地时间
 */
@property (nonatomic, assign)long long firstEnterLocalTimeInterval;
/**
 *  第一次进入的服务器时间,以后每次计算都是以服务器时间为主==>服务器当前时间=（当前时间-第一次进入的本地时间）+ 第一次进入的服务器时间
 */
@property (nonatomic, assign)long long firstEnterServerTimeInterval;


@end

@implementation DLSeckillActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initSeckillActivitySceneView];
    
    [self _initActivityGoodsListTableView];
    
    [self _requestSeckillActivityInfoList];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [kNotification addObserver:self
                      selector:@selector(appEnterForeGround:)
                          name:UIApplicationDidBecomeActiveNotification object:nil];
    [self _refreshSeckillGoodslist];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    [kNotification removeObserver:self];
}



#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.navigationController.view.backgroundColor = self.view.backgroundColor;
    self.pageTitle = @"天天疯抢";
    [self.view bringSubviewToFront:self.shopCartView];
}

-(void)_initActivity {
    
    //确定每个活动的状态
    [self _ensureEachSekillAcitivityStateByCurrentData];
    //确定当前时间所处的活动
    [self _ensureCurrentInWhichSeckillActivityByCurrentDate];
    
    [self _startActivityCountDown];
}

- (void)_initSeckillActivitySceneView {
    WEAK_SELF
    self.seckillActivitySceneView.switchActivityBlock = ^(NSInteger newActivityIndex) {
        weak_self.currentSelectedSecKillActivityModel = weak_self.secKillActivitylist[newActivityIndex];
    };
}

- (void)_initActivityGoodsListTableView {
    
    WEAK_SELF
    self.activityGoodsTableView.cellHeight = kSeckillCellHeight;
    self.activityGoodsTableView.noDataLogicModule.nodataAlertTitle = @"暂无活动商品";
    [self.activityGoodsTableView configurecellNibName:@"DLSecondsKillZoneCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLSecondsKillZoneCell *goodsCell = (DLSecondsKillZoneCell *)cell;
        GoodsModel *model = (GoodsModel *)cellModel;
        [goodsCell configureSeckillGoodsCellWithGoodsModel:model seckillActivityModel:weak_self.currentSelectedSecKillActivityModel];
        WEAK_OBJ(model)
        WEAK_OBJ(goodsCell)
        goodsCell.isAboutToStrachGoodsBlock = ^{
            if (weak_self.currentSelectedSecKillActivityModel.seckillActivityStatus == SeckillActivityStatus_soonBegin) {
                return ;
            }
            [weak_self _addShopCartForGoodsModel:weak_model withGoodsImgView:weak_goodsCell.zomeImageView];
        };
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        GoodsModel *model = (GoodsModel *)cellModel;
        [weak_self _enterGoodsDetailPageWithGoodsId:model.goodsId];

    }];
    self.activityGoodsTableView.dataLogicModule.isRequestByPage = NO;
    [self.activityGoodsTableView headerRreshRequestBlock:^{
        [weak_self _requestActivityGoodsList];
    }];
}


#pragma mark ------------------------Private-------------------------
- (void)_startActivityCountDown {
    self.activityCountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(seckillActivityCountDown) userInfo:nil repeats:YES];
    //滑动模式下让定时器继续工作
    [[NSRunLoop currentRunLoop] addTimer:self.activityCountDownTimer forMode:UITrackingRunLoopMode];
}

- (void)seckillActivityCountDown {
    
    [self.secKillActivitylist enumerateObjectsUsingBlock:^(SeckillActivityModel* model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.seckillActivityStatus == SeckillActivityStatus_crazySaling || model.seckillActivityStatus == SeckillActivityStatus_soonBegin) {
            model.leftCount -- ;
            if (model.leftCount == 0) {
                [self _activityCountDownReachedAtIndex:idx activityModel:model];
            }
        }
    }];
    
    if (self.currentSelectedSecKillActivityModel.seckillActivityStatus == SeckillActivityStatus_crazySaling || self.currentSelectedSecKillActivityModel.seckillActivityStatus == SeckillActivityStatus_soonBegin) {
        if (self.currentSelectedSecKillActivityModel.leftCount != crazySaleNoLeftCount) {
            self.leftTimeView.countDownNumber = self.currentSelectedSecKillActivityModel.leftCount;
        }
    }
}

- (void)_activityCountDownReachedAtIndex:(NSInteger)activityIndex activityModel:(SeckillActivityModel *)activityModel{
    BOOL isLastActivity = activityIndex == self.secKillActivitylist.count - 1;
    if (activityIndex == [self selectedActivityIndex]) {//时间到的正好是当前选中的活动
        if (activityModel.seckillActivityStatus == SeckillActivityStatus_soonBegin) {
            //改变当前模型的状态以及leftCount
            [self _soonBeginActivityTimeReachedUpdateModel:activityModel atIndex:activityIndex];
            //刷新当前活动模型，时间视图的显示,刷新活动商品列表
            [self _reloadActivityViewAtIndex:activityIndex activityModel:activityModel];
            [self _configureLeftTimeView];
            [self _refreshSeckillGoodslist];
        }else if (activityModel.seckillActivityStatus == SeckillActivityStatus_crazySaling){
            //改变当前模型状态以及leftCount
            [self _crazyActivityTimeReachedUpdateModel:activityModel atIndex:activityIndex];
            //刷新当前活动视图
            [self _reloadActivityViewAtIndex:activityIndex activityModel:activityModel];
            if (!isLastActivity) {//不是最后一个，

            }else {//本身选中的就是最后一个
                [self _configureLeftTimeView];
                [self _refreshSeckillGoodslist];
            }
        }
    }else {
        if (activityModel.seckillActivityStatus == SeckillActivityStatus_soonBegin) {
            //改变当前模型的状态以及leftCount
            [self _soonBeginActivityTimeReachedUpdateModel:activityModel atIndex:activityIndex];
            [self _reloadActivityViewAtIndex:activityIndex activityModel:activityModel];
            self.currentSelectedSecKillActivityModel = activityModel;
        
        }else if (activityModel.seckillActivityStatus == SeckillActivityStatus_crazySaling){
            //改变当前模型的状态以及leftCount
            [self _crazyActivityTimeReachedUpdateModel:activityModel atIndex:activityIndex];
            //刷新活动视图
            [self _reloadActivityViewAtIndex:activityIndex activityModel:activityModel];
            if (!isLastActivity) {

            }else {
                
            }
        }

    }
}

- (void)_soonBeginActivityTimeReachedUpdateModel:(SeckillActivityModel *)activityModel atIndex:(NSInteger)activityIndex{
    long long currentTimeInterVal = [self currentServerTime];
    //改变当前模型的状态以及leftCount
    activityModel.seckillActivityStatus = SeckillActivityStatus_crazySaling;
    if (activityIndex != self.secKillActivitylist.count-1) {
        SeckillActivityModel* nextModel = self.secKillActivitylist[activityIndex+1];
        long long nextActivityBeginTime = [nextModel beginTimeInterval];
        activityModel.leftCount = nextActivityBeginTime - currentTimeInterVal;
    }else {
//        activityModel.leftCount = crazySaleNoLeftCount;
        activityModel.leftCount = [activityModel endTimeInterval] - currentTimeInterVal;

    }
}

- (void)_crazyActivityTimeReachedUpdateModel:(SeckillActivityModel *)activityModel atIndex:(NSInteger)activityIndex{
    //改变当前模型状态以及leftCount
    activityModel.seckillActivityStatus = SeckillActivityStatus_hasBegan;
    activityModel.leftCount = hasGoneLeftCount;
}



- (void)_reloadActivityViewAtIndex:(NSInteger)activityIndex activityModel:(SeckillActivityModel *)activityModel{
    [self.seckillActivitySceneView refreshActivityWithNewActivityModel:activityModel atIndex:activityIndex];
}

- (void)_ensureCurrentInWhichSeckillActivityByCurrentDate {
    long long currentTimeInterVal = [self currentServerTime];
    __block NSInteger currentDateInWhichActivityIndex = self.secKillActivitylist.count;
    [self.secKillActivitylist enumerateObjectsUsingBlock:^(SeckillActivityModel* model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (currentTimeInterVal < [model beginTimeInterval]) {
            currentDateInWhichActivityIndex = idx-1;
            * stop = YES;
        }
    }];
    if (currentDateInWhichActivityIndex == -1) {//第一场为即将开始
        currentDateInWhichActivityIndex = 0;
    }else if (currentDateInWhichActivityIndex == self.secKillActivitylist.count){//最后一场为疯抢中
        currentDateInWhichActivityIndex = self.secKillActivitylist.count - 1;
    }
    if (isEmpty(self.currentSelectedSecKillActivityModel)) {
        self.currentSelectedSecKillActivityModel = self.secKillActivitylist[currentDateInWhichActivityIndex];
    }else {
        if (currentDateInWhichActivityIndex != [self selectedActivityIndex]) {
            self.currentSelectedSecKillActivityModel = self.secKillActivitylist[currentDateInWhichActivityIndex];
        }
    }
}

- (void)_ensureEachSekillAcitivityStateByCurrentData {
    long long currentTimeInterVal = [self currentServerTime];
    NSInteger activityCount = self.secKillActivitylist.count;
    [self.secKillActivitylist enumerateObjectsUsingBlock:^(SeckillActivityModel* model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        long long currentActivityBeginTime = [model beginTimeInterval];
        if (idx != activityCount-1) {
            SeckillActivityModel* nextModel = self.secKillActivitylist[idx+1];
            long long nextActivityBeginTime = [nextModel beginTimeInterval];
            if (currentTimeInterVal < currentActivityBeginTime) {
                model.seckillActivityStatus = SeckillActivityStatus_soonBegin;
                model.leftCount = (currentActivityBeginTime - currentTimeInterVal);
            }else if (currentTimeInterVal <= nextActivityBeginTime) {
                model.seckillActivityStatus = SeckillActivityStatus_crazySaling;
                model.leftCount = (nextActivityBeginTime - currentTimeInterVal);
            }else {
                model.seckillActivityStatus = SeckillActivityStatus_hasBegan;
                model.leftCount = hasGoneLeftCount;
            }
        }else {
            if (currentTimeInterVal < currentActivityBeginTime) {
                model.seckillActivityStatus = SeckillActivityStatus_soonBegin;
                model.leftCount = (currentActivityBeginTime - currentTimeInterVal);
            }else {
                long long lastActivityEndTime = [model endTimeInterval];
                if (currentTimeInterVal >= lastActivityEndTime) {
                    model.seckillActivityStatus = SeckillActivityStatus_hasBegan;
                    model.leftCount = hasGoneLeftCount;
                }else {
                    model.seckillActivityStatus = SeckillActivityStatus_crazySaling;
                    model.leftCount = lastActivityEndTime - currentTimeInterVal;
                }
            }
        }
    }];
    self.seckillActivitySceneView.secKillActivitys = self.secKillActivitylist;
}

- (void)_switchActivitySelectedBgViewPosition{
    self.seckillActivitySceneView.currentActivityIndex = [self selectedActivityIndex];
}

- (void)_configureLeftTimeView {
    switch (self.currentSelectedSecKillActivityModel.seckillActivityStatus) {
            
        case SeckillActivityStatus_hasBegan:
        {
            //已经开始
            self.activityStatusMarkLeftLabel.text = @"本轮秒杀已结束";
            self.leftTimeTypeLabel.hidden = YES;
            self.leftTimeView.hidden = YES;
        }
            break;
        case SeckillActivityStatus_crazySaling:
        {
            self.leftTimeTypeLabel.text = @"仅剩";
            self.activityStatusMarkLeftLabel.text = @"限时限量疯抢中";
            if (self.currentSelectedSecKillActivityModel.leftCount != crazySaleNoLeftCount) {
                self.leftTimeView.countDownNumber = self.currentSelectedSecKillActivityModel.leftCount;
                self.leftTimeTypeLabel.hidden = NO;
                self.leftTimeView.hidden = NO;
            }else {//最后一个疯抢中
                self.leftTimeTypeLabel.hidden = YES;
                self.leftTimeView.hidden = YES;
            }
        }
            break;
        case SeckillActivityStatus_soonBegin:
        {
            self.leftTimeTypeLabel.hidden = NO;
            self.leftTimeView.hidden = NO;
            self.leftTimeTypeLabel.text = @"距开始";
            self.activityStatusMarkLeftLabel.text = @"即将开始";
            self.leftTimeView.countDownNumber = self.currentSelectedSecKillActivityModel.leftCount;
        }
            break;
        default:
            break;
    }
}

- (void)_refreshSeckillGoodslist {
    WEAK_SELF
    [self.activityGoodsTableView headerAutoRreshRequestBlock:^{
        [weak_self _requestActivityGoodsList];
    }];
}

- (void)_selectSeckillActivityConfigure {
    //活动选择视图切换，
    [self _switchActivitySelectedBgViewPosition];
    
    //剩余时间的显示
    [self _configureLeftTimeView];
    
    //商品列表的刷新
    [self _refreshSeckillGoodslist];
}

#pragma mark -------------------Private-AddShopCart Method----------------------
- (void)_addShopCartForGoodsModel:(GoodsModel *)goodsModel withGoodsImgView:(UIImageView *)goodsImageView{
    
    NSString *addShopCartCheckStr = [[ShopCartGoodsManager sharedManager] canbeAddedToShopCartOfGoodsModel:goodsModel];
    if (!isEmpty(addShopCartCheckStr)) {
        [Util ShowAlertWithOnlyMessage:addShopCartCheckStr];
        return;
    }
    
    if (![[ShopCartGoodsManager sharedManager] isAddingTheSameTypeGoodsOfGoodsModel:goodsModel]) {
        [self _alertAddDifferentTypeOfGoodsModel:goodsModel withGoodsImgView:goodsImageView];
        return;
    }
    
    [self _addGoodsLogicWithGoodsModel:goodsModel];
    [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:goodsImageView contentListView:self.activityGoodsTableView shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:YES];
}

- (void)_addGoodsLogicWithGoodsModel:(GoodsModel *)goodsModel {
    
    [[ShopCartGoodsManager sharedManager] addShopCartGoodsWithGoodsModel:goodsModel isInShopCartPage:NO];
    DLSecondsKillZoneCell *addShopCartCell = [self.activityGoodsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:goodsModel.modelAtIndexPath.row inSection:0]];
    if (addShopCartCell) {
        [addShopCartCell checkAddingShopCartOfGoodsModel:goodsModel];
    }
}

- (void)_alertAddDifferentTypeOfGoodsModel:(GoodsModel *)goodsModel withGoodsImgView:(UIImageView *)goodsImageView{
    
    AlertViewManager *alertManager =  [[AlertViewManager alloc] init];
    
    NSString *alertStr = [[ShopCartGoodsManager sharedManager] addingDifferentGoodsTypeAlert];
    
    WEAK_SELF
    //两个action
    [alertManager showAlertViewWithControllerTitle:@"提示" message:alertStr controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        [[ShopCartGoodsManager sharedManager] clearShopCartDataWhenAddingDifferentTypeGoods];
        [weak_self _addGoodsLogicWithGoodsModel:goodsModel];
        [DLAnimatePerformer excuteAddShopCartAnimationUsingAnimateImageView:goodsImageView contentListView:weak_self.activityGoodsTableView shopCartViewPoint:ListPageShopCartIconPoint isAddShopCart:YES];

        
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
        
    }];
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestSeckillActivityInfoList {
    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    self.requestParam = @{KStoreIdKey:kCommunityStoreId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetSeckillActivityInfoList block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *activityList = resultDic[EntityKey];
        if (isEmpty(activityList)) {
            activityList = @[];
        }else {
        }
        self.secKillActivitylist = [activityList transferDicArrToModelArrWithModelClass:[SeckillActivityModel class]];
        if (self.secKillActivitylist.count > 0) {
            SeckillActivityModel *firstActivitiModel = self.secKillActivitylist.firstObject;
            self.firstEnterServerTimeInterval = (long long)[NSDate subCurrentDateWithDateString:firstActivitiModel.serverSystemTime];
            self.firstEnterLocalTimeInterval = [self currentTimeInterval];
        }
        [self _initActivity];
    }];
}

- (void)_requestActivityGoodsList {
    if (isEmpty(kCommunityStoreId)) {
        return;
    }
    if (isEmpty(self.currentSelectedSecKillActivityModel.activityId)) {
        return;
    }
    self.requestParam = @{KStoreIdKey:kCommunityStoreId,
                          @"actId":self.currentSelectedSecKillActivityModel.activityId};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetSekillGoodsList block:^(NSDictionary *resultDic, NSError *error) {
        NSArray *activityGoodsList = resultDic[EntityKey];
        if (isEmpty(activityGoodsList)) {
            activityGoodsList = @[];
        }
        activityGoodsList = [GoodsModel objectSecKillGoodsModelWithGoodsArr:activityGoodsList];
        [self.activityGoodsTableView configureTableAfterRequestPagingData:activityGoodsList];
        [self.activityGoodsTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
    }];
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterGoodsDetailPageWithGoodsId:(NSString *)goodsId {
    DLGoodsdetailVC *goodsDetailVC = [[DLGoodsdetailVC alloc] init];
    goodsDetailVC.goodsId = goodsId;
    [self navigatePushViewController:goodsDetailVC animate:YES];
}


#pragma mark ------------------------View Event---------------------------

- (void)goBack {
    [super goBack];
    [self.activityCountDownTimer invalidate];
    self.activityCountDownTimer = nil;
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------
- (void)appEnterForeGround:(NSNotification *)info {
    //重新确定每个活动的状态
    [self _ensureEachSekillAcitivityStateByCurrentData];
    //重新确定当前时间所处的活动
    [self _ensureCurrentInWhichSeckillActivityByCurrentDate];
}

#pragma mark ------------------------Getter / Setter----------------------
- (void)setCurrentSelectedSecKillActivityModel:(SeckillActivityModel *)currentSelectedSecKillActivityModel {
    _currentSelectedSecKillActivityModel = currentSelectedSecKillActivityModel;
    [self _selectSeckillActivityConfigure];
}

- (NSInteger)selectedActivityIndex {
    return [self.secKillActivitylist indexOfObject:self.currentSelectedSecKillActivityModel];
}

- (long long)currentServerTime {
    long long goneTimeFromFirstEnter = [self currentTimeInterval] - self.firstEnterLocalTimeInterval;
    return self.firstEnterServerTimeInterval + goneTimeFromFirstEnter;
}

- (long long)currentTimeInterval {
    return (long long)[NSDate currentTimeInterval];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
