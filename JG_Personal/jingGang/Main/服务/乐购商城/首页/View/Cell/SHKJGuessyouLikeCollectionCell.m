//
//  KJGuessyouLikeCollectionCell.m
//  商品详情页collectionView测试
//
//  Created by 张康健 on 15/8/8.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import "SHKJGuessyouLikeCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
@implementation SHKJGuessyouLikeCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
//    [self assignData];

}

-(void)assignData {
    NSString *newStr = TwiceImgUrlStr(self.model.goodsMainPhotoPath, kCareChoosenGoodsCellImgWith, kCareChoosenGoodsCellImgWith);
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:newStr]];
    self.goodsNameLabel.text = self.model.goodsName;
    CGFloat price = self.model.actualPrice;
    //判断有没手机专享价
    if (self.model.hasMobilePrice.integerValue) {//有
//        self.phoneSpecialSharePriceView.hidden = NO;
//        self.priceBgView.hidden = YES;
//        self.phoneSpecialSharePriceLabel.text = [NSString stringWithFormat:@"￥%.2f",price];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",price];
        
    }else{//没有手机专享价，可能有积分兑换价
//        self.phoneSpecialSharePriceView.hidden = YES;
//        self.priceBgView.hidden = NO;
        self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",price];
    }
}


-(void)setModel:(GoodsDetailModel *)model {

    _model = model;
    [self assignData];
}


@end
