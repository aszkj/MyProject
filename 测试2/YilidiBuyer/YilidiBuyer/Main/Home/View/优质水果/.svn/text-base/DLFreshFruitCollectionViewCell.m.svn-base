//
//  DLFreshFruitCollectionViewCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLFreshFruitCollectionViewCell.h"
#import "DLHomeGoodsModel.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"
@implementation DLFreshFruitCollectionViewCell

- (void)setGoodsModel:(DLHomeGoodsModel *)goodsModel {
    
    _goodsModel = goodsModel;
    [self _configureCellByModel];
}

- (void)_configureCellByModel {
    [self.goodsImgView sd_SetImgWithUrlStr:self.goodsModel.imgUrl placeHolderImgName:nil];
    self.goodsTitleLabel.text = self.goodsModel.goodsName;
    self.goodsPriceLabel.text = kPriceFloatValueToRMB(self.goodsModel.goodsPrice.doubleValue);
    self.goodsOriginalPriceLabel.text = [Util toStrOfFloatValue:self.goodsModel.oldPrice.doubleValue];
}

- (IBAction)addShopCartClickButtonAction:(id)sender {
    [self addShopCartAction:nil];
}

- (IBAction)addShopCartAction:(id)sender {
    
    NSDictionary *postDic = @{kaddShopCartGoodsModelKey:self.goodsModel,
                              kwillAnimateGoodsViewKey:self.goodsImgView};
    [kNotification postNotificationName:KNotificationShopCartGoodsChange object:nil userInfo:postDic];
}

- (void)awakeFromNib {
    
   
}

@end
