//
//  JGIntegralItemCell.m
//  jingGang
//
//  Created by dengxf on 15/12/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGIntegralItemCell.h"
#import "UIImageView+WebCache.h"
#import "IntegralListBO.h"

@implementation JGIntegralItemCell

- (void)setListBO:(IntegralListBO *)listBO {
    _listBO = listBO;
    
    // 设置商品展示图片
    [self.integralShopImageView sd_setImageWithURL:[NSURL URLWithString:listBO.igGoodsImg] placeholderImage:nil];
    
    // 设置商品积分价格
    NSString *price = TNSString(listBO.igGoodsIntegral);
    self.integralShopPriceLab.text = [self handlePrice:price];
    
    // 设置商品名字
    self.integralNameLab.text = listBO.igGoodsName;    
}

- (NSString *)handlePrice:(NSString *)price {
    CGFloat floatPrice = [price floatValue];
    if (floatPrice >= 10000) {
        floatPrice = floatPrice / 1000.0;
        return [NSString stringWithFormat:@"%.1fk",floatPrice];
    }else
        return price;
}
@end
