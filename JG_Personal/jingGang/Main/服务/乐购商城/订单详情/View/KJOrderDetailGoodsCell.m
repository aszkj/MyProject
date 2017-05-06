//
//  KJOrderDetailGoodsCell.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJOrderDetailGoodsCell.h"
#import "GoodsInfoModel.h"
#import "UIImageView+WebCache.h"
#import "Util.h"
#import "ApplySalesReturnVC.h"
#import "UIView+firstResponseController.h"
#import "GlobeObject.h"
@implementation KJOrderDetailGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutSubviews{

    [super layoutSubviews];
#pragma mark - 2*2
    NSString *newStr = TwiceImgUrlStr(self.goodsInfoModel.goodsMainphotoPath, 101, 89);
    [self.od_goodsImgView sd_setImageWithURL:[NSURL URLWithString:newStr]placeholderImage:nil];
    self.od_goodsNameLabel.text = self.goodsInfoModel.goodsName;
    //规格显示，过滤掉html标签
    self.od_goodsCationLabel.text = [Util removeHTML2:self.goodsInfoModel.goodsGspVal];
    self.od_goodsCountLabel.text = [NSString stringWithFormat:@"x%ld",self.goodsInfoModel.goodsCount.integerValue];
    self.od_goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.goodsInfoModel.goodsAllPrice.floatValue];
    if (self.orderStatusNum.integerValue == 40 || self.orderStatusNum.integerValue == 50) {//已收货，待申请退货
        self.applyReturnGoodsButton.hidden = NO;
    }else{
        self.applyReturnGoodsButton.hidden = YES;
    }
}


- (IBAction)applyReturnGoodsAction:(id)sender {
    
    ApplySalesReturnVC *returnVC = [[ApplySalesReturnVC alloc] initWithNibName:@"ApplySalesReturnVC" bundle:nil];
    returnVC.orderID = self.goodsOrderID.longValue;
    returnVC.goodsID = self.goodsInfoModel.goodsId.longLongValue;
    returnVC.goodsGspIds = self.goodsInfoModel.goodsGspIds;
    [self.firstResponseController.navigationController pushViewController:returnVC animated:YES];
    
}


@end
