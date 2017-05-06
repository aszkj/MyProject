//
//  DLReturnClauseView.m
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderReturnClauseView.h"
#import "MycommonTableView.h"
#import "DLOrderRefundDetailGoodsCell.h"
#import "ProjectRelativeMaco.h"
#import "ProjectStandardUIDefineConst.h"
@interface DLOrderReturnClauseView()
@property (weak, nonatomic) IBOutlet MycommonTableView *orderRefoundDetailGoodsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderRefundTableHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *goodsSettleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsSettleAmountLabel;

@end

@implementation DLOrderReturnClauseView

- (void)awakeFromNib {
    
    [self _initOrderDetailTableView];
}


- (void)_assignData {
    
    self.orderRefoundDetailGoodsTableView.dataLogicModule.currentDataModelArr = [self.detailModel.orderSettleGoodsArr mutableCopy];
    [self.orderRefoundDetailGoodsTableView reloadData];
    self.orderRefundTableHeightConstraint.constant = self.orderRefoundDetailGoodsTableView.dataLogicModule.currentDataModelArr.count * kOrderRefundDetailGoodsCellHeight;
    NSString *refundGoodsCountStr = jFormat(@"返款商品数：%@件",self.detailModel.orderGoodsTotalCount
                                            );

    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:refundGoodsCountStr];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:KCOLOR_PROJECT_RED
                              range:NSMakeRange(6, refundGoodsCountStr.length-7)];
    self.goodsSettleCountLabel.attributedText = attributedStr;

    self.goodsSettleAmountLabel.attributedText = kDefaultRMBStrWithPrice(self.detailModel.goodsSettleAmount.floatValue);

}

- (void)setDetailModel:(MerchantOrderDetailModel *)detailModel {
    _detailModel = detailModel;
    [self _assignData];
}




-(void)_initOrderDetailTableView {
    self.orderRefoundDetailGoodsTableView.cellHeight = kOrderRefundDetailGoodsCellHeight;
    [self.orderRefoundDetailGoodsTableView configurecellNibName:@"DLOrderRefundDetailGoodsCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLOrderRefundDetailGoodsCell *goodsCell = (DLOrderRefundDetailGoodsCell *)cell;
        GoodsModel *goodsModel = (GoodsModel *)cellModel;
        [goodsCell setCellModel:goodsModel];
        
    }];
}

@end
