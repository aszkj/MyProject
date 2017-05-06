//
//  IntegralShopCell.m
//  jingGang
//
//  Created by 张康健 on 15/10/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralShopCell.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
#import "IntegralListBO.h"

@implementation IntegralShopCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(IntegralListBO *)model {
    
    _model = model;
    NSString *twiceUrl = TwiceImgUrlStr(model.igGoodsImg, KCellWith, KCellHeight);
    [self.integralGoodsImgView sd_setImageWithURL:[NSURL URLWithString:twiceUrl] placeholderImage:nil];
    self.integralGoodsNameLabel.text = model.igGoodsName;
    self.integralLabel.text = [NSString stringWithFormat:@"%@积分",model.igGoodsIntegral];

}


@end
