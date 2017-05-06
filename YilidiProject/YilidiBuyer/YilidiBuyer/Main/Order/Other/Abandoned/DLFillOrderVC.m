//
//  DLMakeSureOrderVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLFillOrderVC.h"
#import "MyCommonCollectionView.h"
#import "DLMakeSureOrderModel.h"
#import "AdressBaseModel.h"
#import "DisplayAdressView.h"
#import "SUIMacro.h"
#import "ProjectRelativeMaco.h"
#import "DLOrderGoodsCell.h"
#import "DLCashierVC.h"
#import "DLOrderGoodsListVC.h"
#import "ActionSheetMultipleStringPicker.h"
#import "DLGlobleRequestApiManager.h"
#import "NSDate+Utilities.h"
#import "SUIUtils.h"
#import "ProjectRelativeKey.h"
#import "AdressModel.h"
#import <Masonry/Masonry.h>

@interface DLFillOrderVC ()
@property (weak, nonatomic) IBOutlet UIView *adressView;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *orderGoodsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *haveYouhuiedMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalYouhuiedMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *purseLeftMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *purseUsedMoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *shippedMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNeedToPayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipTimeLabel;
@property (nonatomic,strong)AdressModel *adressModel;
@property (nonatomic, strong)DLMakeSureOrderModel *makeSureOrderModel;
@property (nonatomic, strong)DisplayAdressView *displayAdressView;
@property (nonatomic, strong)NSNumber *isWalleyPay;
@property (nonatomic, copy)NSArray *dateArr;
@property (nonatomic, copy)NSArray *timeArr;
@property (nonatomic, copy)NSArray *timePikerShowArr;
@property (nonatomic, copy)NSString *selectedDateStr;
@property (nonatomic, copy)NSString *selectedTimeStr;
@property (nonatomic, copy)NSString *lightingShippingTimeIdStr;



@end

@implementation DLFillOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _requestMakeSureOrderData];
    
    [self _requestTheDefaultAdress];
    
    [self _requestCanbeShippedTimeList];
}

#pragma mark ------------------------Init---------------------------------

-(void)_init {
    self.isWalleyPay = @(1);
    [self _initAdressView];
    
    [self _initGoodsCollectionView];
}

-(void)_initAdressView {
    
    self.displayAdressView = BoundNibView(@"DisplayAdressView", DisplayAdressView);
    [self.adressView addSubview:self.displayAdressView];
    WEAK_SELF
    [self.displayAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weak_self.adressView);
    }];
}

-(void)_initGoodsCollectionView {
    
    WEAK_SELF
    [self.orderGoodsCollectionView configureCollectionCellNibName:@"DLOrderGoodsCell" configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        DLOrderGoodsCell *cell = (DLOrderGoodsCell *)collectionCell;
        GoodsModel *model = (GoodsModel *)collectionModel;
        cell.imgWidthConstraint.constant = weak_self.orderGoodsCollectionView.cellCalculateModel.cellImgWidth;
        cell.imgHeightConstraint.constant = weak_self.orderGoodsCollectionView.cellCalculateModel.cellImgHeight;
        [cell setCellModel:model];
    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        
    }];
    
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:4 horizontalDisplayAreaWidth:kScreenWidth-102 cellImgToSideEdge:8 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:16 edgeBetweenCellAndCell:0 edgeBetweenCellAndSide:0];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.orderGoodsCollectionView.cellCalculateModel = cellCaculateModel;
    
    self.orderGoodsCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    self.orderGoodsCollectionView.commonFlowLayout.sectionInset = MakeUIEdgeInset(0, 0, 0, 0);
    self.orderGoodsCollectionView.commonFlowLayout.minimumInteritemSpacing = 0;
    self.orderGoodsCollectionView.commonFlowLayout.minimumLineSpacing = 0;
    self.orderGoodsCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

}



#pragma mark ------------------------Private-------------------------
- (void)_assuiUI {

    self.goodsCountLabel.text = jFormat(@"共%@件", self.makeSureOrderModel.goodsTotalNumber);
    self.haveYouhuiedMoneyLabel.text = jFormat(@"已经优惠¥%.2f元",self.makeSureOrderModel.couponAmount.doubleValue);
    self.purseLeftMoneyLabel.text = jFormat(@"可用金额%.2f元",self.makeSureOrderModel.balance.doubleValue);
    self.shipTimeLabel.text = [self.makeSureOrderModel.receiveTimeModel shipTimeStr];
    self.totalAmountLabel.text = kPriceFloatValueToRMB(self.makeSureOrderModel.totalAmount.doubleValue);
    self.totalYouhuiedMoneyLabel.text = kPriceFloatValueToRMB(self.makeSureOrderModel.couponAmount.doubleValue);
    self.shippedMoneyLabel.text = kPriceFloatValueToRMB(self.makeSureOrderModel.deliveryFee.doubleValue);
    self.purseUsedMoneLabel.text = kPriceFloatValueToRMB(self.makeSureOrderModel.balance.doubleValue);
    self.realNeedToPayMoneyLabel.text = jFormat(@"实付款%.2f",self.makeSureOrderModel.payAmount.doubleValue);
    self.orderGoodsCollectionView.dataLogicModule.currentDataModelArr = [self.makeSureOrderModel.orderGoods mutableCopy];
    [self.orderGoodsCollectionView reloadData];
}

- (void)_showTimeSelectePikerWithData:(NSArray *)data origin:(UIView *)sender{
    if (!data.count) {
        return;
    }
    [ActionSheetMultipleStringPicker showPickerWithTitle:@"请选则配送时间" rows:data initialSelection:nil doneBlock:^(ActionSheetMultipleStringPicker *picker, NSArray *selectedIndexes, id selectedValues) {
        NSArray *values = (NSArray *)selectedValues;
        if (values.count >= 2) {
            self.selectedDateStr = [self _findDateNumberWithDateStr:values[0]];
            self.selectedTimeStr = [self _findTimeStrIdWithTimeDateStr:values[1]];
        }
        JLog(@"%@",selectedIndexes);
        JLog(@"%@",selectedValues);
    } cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
        
    } origin:(UIView *)sender];

}

-(NSString *)_findDateNumberWithDateStr:(NSString *)dateStr {
  
    NSString *dateNumberStr = nil;
    for (NSInteger i=0; i<self.dateArr.count; i++) {
        NSString *tempStr = self.dateArr[i];
        if ([tempStr isEqualToString:dateStr]) {
            dateNumberStr = IntToString(i);
            break;
        }
    }
    return dateNumberStr;
}

- (NSString *)_findTimeStrIdWithTimeDateStr:(NSString *)timeStr {
    
    if ([timeStr isEqualToString:KLightingShipping]) {
        return self.lightingShippingTimeIdStr;
    }
    
    NSString *timeIdStr = nil;
    for (DLReceiveTimeModel *model in self.timeArr) {
        if ([timeStr isEqualToString:[model shipTimeStr]]) {
            timeIdStr = model.receiveTimeId.stringValue;
            break;
        }
    }
    return timeIdStr;
}

- (void)_dealtDateAndTimeArrByNowDate {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDate *timeNow = [NSDate date];
        NSInteger nowHour = timeNow.hour;
        NSInteger nowMinute = timeNow.minute;
        DLReceiveTimeModel *lastTimeModel = self.timeArr.lastObject;
        BOOL fromTodayBegin = YES;
        if (nowHour >= [lastTimeModel timeIntegerHourWithTimeStr:lastTimeModel.endTime]) {
            fromTodayBegin = NO;
        }
        
        NSInteger dateFromIndex = (fromTodayBegin ? 0 : 1);
        NSArray *dateShowArr = [self.dateArr subarrayWithRange:NSMakeRange(dateFromIndex, self.dateArr.count-dateFromIndex)];
        self.selectedDateStr = IntToString(dateFromIndex);
        NSArray *timeShowArr = nil;
        if (!fromTodayBegin) {//不从今天开始配送
            NSArray *tempTimeShowArr = [self.timeArr sui_map:^NSString *(DLReceiveTimeModel * model, NSUInteger index) {
                return [model shipTimeStr];
            }];
            timeShowArr = tempTimeShowArr;
        }else {
            //是今天
            //找到在配送时间段内的区间，不在配送时间段内的区间，起始点
            BOOL isInTheShipTimeSection = NO;
            NSInteger timeFromIndex = -1000;
            for (NSInteger i=0; i<self.timeArr.count; i++) {
                DLReceiveTimeModel *currentmodel = self.timeArr[i];
                NSInteger currentModelbeginHour = [currentmodel timeIntegerHourWithTimeStr:currentmodel.startTime];
                NSInteger currentModelendHour = [currentmodel timeIntegerHourWithTimeStr:currentmodel.endTime];
                NSInteger beginTime = currentModelbeginHour * 60;
                NSInteger endTime = currentModelendHour * 60;
                NSInteger nowTime = nowHour * 60 + nowMinute;
                if (nowTime <= endTime && nowTime >= beginTime ) {
                    isInTheShipTimeSection = YES;
                    timeFromIndex = i;
                    break;
                }else{
                    isInTheShipTimeSection = NO;
                    if (nowTime < beginTime) {
                        timeFromIndex = i;
                    }else if (nowTime > endTime){
                        timeFromIndex = i + 1;
                    }
                }
            }
            //如果在配送区间，那就支持闪电配送，
            if (timeFromIndex <= self.timeArr.count-1) {
                NSArray *tempTimeArr = [self.timeArr subarrayWithRange:NSMakeRange(timeFromIndex, self.timeArr.count-timeFromIndex)];
                DLReceiveTimeModel *firstTimeModel = tempTimeArr.firstObject;
                self.selectedTimeStr = firstTimeModel.receiveTimeId.stringValue;
                if (isInTheShipTimeSection) {//是今天，并且在配送区间，肯定支持闪电配送
                    self.lightingShippingTimeIdStr = self.selectedTimeStr;
                }
                timeShowArr = [tempTimeArr sui_map:^NSString *(DLReceiveTimeModel * model, NSUInteger index) {
                    if (index == 0) {
                        if (isInTheShipTimeSection) {//在配送区间，支持闪电配送
                            return KLightingShipping;
                        }else {
                            return [model shipTimeStr];
                        }
                    }else{
                        return [model shipTimeStr];
                    }
                }];
            }
        }
        if (!isEmpty(dateShowArr) && !isEmpty(timeShowArr)) {
            self.timePikerShowArr = @[dateShowArr,timeShowArr];
        }
    });

}

#pragma mark ------------------------Api-----------------------------------
- (void)_requestMakeSureOrderData {
    self.requestParam = @{@"cartId":self.cartIds,
                          @"shippingAddressId":self.shippingAdressId};
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetMakeSureOrderData block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        self.makeSureOrderModel = [[DLMakeSureOrderModel alloc] initWithDefaultDataDic:resultDic[@"data"]];
        [self _assuiUI];
    }];
}

- (void)_requestSubmmitOrder {
    [self showLoadingHubWithText:@"正在提交订单.."];
    NSString *recieveTimeStr = [NSString stringWithFormat:@"%@_%@",self.selectedDateStr,self.selectedTimeStr];
    self.requestParam = @{@"shippingAddressId":self.adressModel.consigneAdressId,
                          @"orderNo":self.makeSureOrderModel.orderNo,
                          @"receiveTime":recieveTimeStr,
                          @"couponId":self.makeSureOrderModel.couponId,
                          @"isWalletPay":self.isWalleyPay};
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_SubmmitOrder block:^(NSDictionary *resultDic, NSError *error) {
        [self hideHubForText:@"订单生成成功"];
        [self performSelector:@selector(_gotoPayPage) withObject:nil afterDelay:0.3
         ];
        NSString *orderNo = resultDic[@"data"][@"data"][@"orderNo"];
        [self _requestOrderDetailWithOrderNumber:orderNo];
    }];
}


- (void)_requestOrderDetailWithOrderNumber:(NSString *)orderNo {
    orderNo = @"fdaed71c037f495685bfe5dc6bbd42c4";
    self.requestParam = @{@"orderNo":orderNo};
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_OrderDetail parameters:self.requestParam block:^(id result, NSError *error) {
        
    }];
}

- (void)_requestTheDefaultAdress {
    
    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_GetDefaultAdress parameters:nil block:^(id result, NSError *error) {
        if (isEmpty(result[@"data"][@"shippingAddressId"])) {
            self.adressModel = nil;
        }else {
            self.adressModel = [[AdressModel alloc] initWithDefaultDataDic:result[@"data"]];
        }
    }];
}

- (void)_requestCanbeShippedTimeList {
    if ([DLGlobleRequestApiManager sharedManager].canbeShippedTimeList.count > 0) {
        self.timeArr = [DLGlobleRequestApiManager sharedManager].canbeShippedTimeList;
    }else {
        [[DLGlobleRequestApiManager sharedManager] requestCanbeShippedTimeListWithBackBlock:^(id result, NSError *error) {
            self.timeArr = (NSArray *)result;
        }];
    }
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)_gotoPayPage {
    DLCashierVC *payVC = [[DLCashierVC alloc] init];
    [self navigatePushViewController:payVC animate:YES];
}

- (void)_gotoMoreGoodsPage {
    DLOrderGoodsListVC *goodsListVC = [[DLOrderGoodsListVC alloc] init];
    goodsListVC.orderNo = self.makeSureOrderModel.orderNo;
    [self navigatePushViewController:goodsListVC animate:YES];
}

#pragma mark ------------------------View Event---------------------------
- (IBAction)selectTimeAction:(id)sender {
    
    [self _showTimeSelectePikerWithData:self.timePikerShowArr origin:sender];
    
}

- (IBAction)selectYouhuiQuanAction:(id)sender {
    
}

- (IBAction)whetherUsePurseAction:(id)sender {
    UIButton *purseButton = (UIButton *)sender;
    purseButton.selected = !purseButton.selected;
    self.isWalleyPay = (purseButton.selected ? @(1):@(0));
    CGFloat purseUseMoney = (self.isWalleyPay.integerValue ? self.makeSureOrderModel.balance.doubleValue : 0.0);
    self.purseUsedMoneLabel.text = kPriceFloatValueToRMB(purseUseMoney);

}

- (IBAction)seeMoreOrderGoodsAction:(id)sender {
    [self _gotoMoreGoodsPage];
}

- (IBAction)submmitOrderAction:(id)sender {
    [self _requestSubmmitOrder];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (void)setAdressModel:(AdressBaseModel *)adressModel {
    _adressModel = adressModel;
    self.displayAdressView.adressModel = _adressModel;
}

- (void)setTimeArr:(NSArray *)timeArr {
    _timeArr = timeArr;
    [self _dealtDateAndTimeArrByNowDate];
}

- (NSArray *)dateArr {
    if (!_dateArr) {
        _dateArr = @[@"今天",@"明天",@"后天"];
    }
    return _dateArr;
}

@end
