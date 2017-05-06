//
//  ShowCaseSecondCollectionCell.m
//  橱窗collectionView测试
//
//  Created by 张康健 on 15/8/13.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import "ShowCaseSecondCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"

@implementation ShowCaseSecondCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
}


-(void)setModel:(GoodsDetailModel *)model {
    
    _model = model;
    NSString *newStr = TwiceImgUrlStr(_model.goodsMainPhotoPath, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    [self.showCaseImgView sd_setImageWithURL:[NSURL URLWithString:newStr]];
    
    CGFloat price = _model.actualPrice;
    //判断有没手机专享价
    if (_model.hasMobilePrice.integerValue) {//有
        self.phoneSpecialShareBgview.hidden = NO;
        self.priceBgView.hidden = YES;
        self.phonePriceLabel.text = [NSString stringWithFormat:@"￥%.2f",price];
    }else{//没有手机专享价，可能有积分兑换价
        self.phoneSpecialShareBgview.hidden = YES;
        self.priceBgView.hidden = NO;
        self.priceLabel.text =[NSString stringWithFormat:@"￥%.2f",price];
        
    }
}

@end
