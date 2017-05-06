//
//  DLOrderListCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderListCell.h"
#import "MyCommonCollectionView.h"
#import "ProjectRelativeMaco.h"
#import "DLOrderGoodsCell.h"
#import "OrderListModel.h"

const NSInteger goodsDisplayMaxCount = 4;
const CGFloat storeImgViewToLeftNormalGap = 10;
const CGFloat storeImgViewToLeftBigGap = 20;

@interface DLOrderListCell()
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIImageView *displayStoreImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeImgViewToLeftConstraint;
@property (weak, nonatomic) IBOutlet UIButton *displaySelfTakeButton;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *goodsCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsViewHeightConstraint;
@end

@implementation DLOrderListCell
- (void)awakeFromNib {
    [self _initGoodsCollectionView];
    self.goodsViewHeightConstraint.constant = kGoodsViewHeight;
}

-(void)_initGoodsCollectionView {
    
    WEAK_SELF
    [self.goodsCollectionView configureCollectionCellNibName:@"DLOrderGoodsCell" configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        DLOrderGoodsCell *cell = (DLOrderGoodsCell *)collectionCell;
        GoodsModel *model = (GoodsModel *)collectionModel;
        cell.imgWidthConstraint.constant = weak_self.goodsCollectionView.cellCalculateModel.cellImgWidth;
        cell.imgHeightConstraint.constant = weak_self.goodsCollectionView.cellCalculateModel.cellImgHeight;
        [cell setCellModel:model];
    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        
    }];
  
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:goodsDisplayMaxCount horizontalDisplayAreaWidth:kScreenWidth-70 cellImgToSideEdge:10 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:16 edgeBetweenCellAndCell:0 edgeBetweenCellAndSide:0];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.goodsCollectionView.cellCalculateModel = cellCaculateModel;
    
    self.goodsCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, 70);
    self.goodsCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}


- (void)setOrderListModel:(OrderListModel *)orderListModel {
    _orderListModel = orderListModel;
    [self _configureCellByModel];
}

- (void)_configureCellByModel {

    self.storeNameLabel.text = self.orderListModel.orderStoreName;
//    self.totalAmountLabel.text = kPriceFloatValueToRMB(self.orderListModel.totalAmount.floatValue/1000);
     self.totalAmountLabel.text = jFormat(@"%.2f元",self.orderListModel.totalAmount.floatValue/1000);
    self.totalAmountLabel.textColor = KCOLOR_PROJECT_RED;
    self.goodsCollectionView.dataLogicModule.currentDataModelArr = [self.orderListModel.orderGoods mutableCopy];
    [self.goodsCollectionView reloadData];
    [self _configreSelfTakeMarkUi];
    self.moreButton.hidden = self.orderListModel.orderGoods.count <= goodsDisplayMaxCount;
    [self configureViewRelatedOrderStatusWithOrderListModel:self.orderListModel];
}

- (void)_configreSelfTakeMarkUi {
    CGFloat storeImgViewToLeftGap = 0;
    if (self.orderListModel.orderShipWay == ShipWay_DeliveryGoodsHome) {
        storeImgViewToLeftGap = storeImgViewToLeftNormalGap;
        self.displaySelfTakeButton.hidden = YES;
        self.displayStoreImgView.hidden = NO;
    }else if (self.orderListModel.orderShipWay == ShipWay_SelfTake) {
        storeImgViewToLeftGap = storeImgViewToLeftBigGap;
        self.displaySelfTakeButton.hidden = NO;
        self.displayStoreImgView.hidden = YES;
    }
    self.storeImgViewToLeftConstraint.constant = storeImgViewToLeftGap;
}

- (void)configureViewRelatedOrderStatusWithOrderListModel:(OrderListModel *)orderListModel {
    self.statusLabel.text = orderListModel.orderStatusStr;
    NSString *firstButtonTitle = nil;
    BOOL firstButtonHidden = NO;
    switch (orderListModel.orderStatus) {
        case OrderStatus_ReadyToPay:
        {
            firstButtonTitle = @"去支付";
            firstButtonHidden = NO;
        }
            break;
        case OrderStatus_HasFinished:
        {
            firstButtonTitle = @"去评价";
//            firstButtonHidden = NO;
            firstButtonHidden = orderListModel.isOrderEvaluated;
        }
            break;
        case OrderStatus_HasPayedWaitMerchantToTakeOrder:
        {
            firstButtonTitle = @"取消订单";
            firstButtonHidden = NO;
        }
            break;
        case OrderStatus_MerchantHasDeliveredGoodsConfiureRecieveGoods:
        {
            firstButtonHidden = NO;
            firstButtonTitle = self.orderListModel.orderShipWay == ShipWay_DeliveryGoodsHome ? @"确认收货":@"确认提货";
            break;
        }
        default:
        {
            firstButtonHidden = YES;
        }
            break;
    }
    self.firstButton.hidden = firstButtonHidden;
    if (firstButtonTitle) {
        jSetButtonNormalStateTile(self.firstButton, firstButtonTitle);
    }
}

- (void)_oneOrderAgain {
    emptyBlock(self.oneceOrderAgainBlock,self.orderListModel.orderNo);
}

- (void)_gotoPay {
    emptyBlock(self.gotoPayBlock,self.orderListModel.orderNo);
}

- (void)_gotoComment {
    emptyBlock(self.gotoCommentBlock,self.orderListModel.orderNo);
}

- (void)_cancelOrder {
    emptyBlock(self.cancelOrderGoodsBlock,self.orderListModel.orderNo);
}

- (void)_confiureRecieveGoods {
    emptyBlock(self.confiureRecieveGoodsBlock,self.orderListModel.orderNo);
}



- (IBAction)firstButtonAction:(id)sender {
    if (self.orderListModel.orderStatus == OrderStatus_HasPayedWaitMerchantToTakeOrder) {
        [self _cancelOrder];
    }else if (self.orderListModel.orderStatus == OrderStatus_ReadyToPay) {
        [self _gotoPay];
    }else if (self.orderListModel.orderStatus == OrderStatus_MerchantHasDeliveredGoodsConfiureRecieveGoods) {
        [self _confiureRecieveGoods];
    }else if (self.orderListModel.orderStatus == OrderStatus_HasFinished) {
        [self _gotoComment];
    }

}

- (IBAction)clickToOrderDetailAction:(id)sender {
    emptyBlock(self.gotoLookOrderDetailBlock,self.orderListModel.orderNo);
}


@end
