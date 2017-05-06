//
//  DLMakeSureOrderGoodsCell.h
//  YilidiBuyer
//
//  Created by yld on 16/4/23.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "DLCouponModel.h"
#define kGotoSetAcountGoodsCellHeight 35

@interface DLGotoSetAcountGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleToEdgeGapConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tileToGiftGoosMarkButtonGapConstrait;
@property (weak, nonatomic) IBOutlet UIButton *giftGoodsMarkButton;
@end

@interface DLGotoSetAcountGoodsCell (setCellModel)

- (void)setCellModel:(GoodsModel *)model;

- (void)setCellGiftTicketModel:(DLCouponModel *)model;


@end
