//
//  DLHomeGoodsVerticalCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeGoodsVerticalCell.h"
#import "GoodsModel.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"

@interface DLHomeGoodsVerticalCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addSubCountViewToRightConstraint;

@end

@implementation DLHomeGoodsVerticalCell

- (void)awakeFromNib {
    // Initialization code
    if (kScreenWidth == iPhone5_width) {
        self.goodsNameLabel.font = kSystemFontSize(12);
        self.addSubCountViewToRightConstraint.constant = 0;
    }
}

@end

@implementation DLHomeGoodsVerticalCell (setCellModel)

-(void)setCellModel:(GoodsModel *)model {
    
   [self.goodsImgView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:@"noImageDetails"];
   self.goodsNameLabel.text = model.goodsName;
    
    CGFloat priceFont = 14;
    if (kScreenWidth == iPhone5_width) {
        priceFont = 13;
    }
    self.goodsVipPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsVipPrice.floatValue,priceFont,priceFont);
    self.goodsOriginalPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsOriginalPrice.floatValue,priceFont-2,priceFont-2);

//   self.goodsOriginalPriceLabel.attributedText = kDefaultRMBStrWithPrice(model.goodsOriginalPrice.floatValue);
//   self.goodsVipPriceLabel.attributedText = kDefaultRMBStrWithPrice(model.goodsVipPrice.floatValue);
    self.goodsStandlabel.text = model.goodsStand;
    self.goodsCountChangeView.goodsModel = model;
    [self.goodsCountChangeView initUiFromShopCartGoodsId:model.goodsId];
    self.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
             NSDictionary *postDic = @{kaddShopCartGoodsModelKey:model,
                                      kwillAnimateGoodsViewKey:self.goodsImgView,
                                       KGoodsChangeIsAddKey:@(isAdd)};
             [kNotification postNotificationName:KNotificationShopCartGoodsChange object:nil userInfo:postDic];
    };
}
@end
