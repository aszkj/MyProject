//
//  DLOrderGoodsCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderGoodsCell.h"


@implementation DLOrderGoodsCell

- (void)awakeFromNib {
    
}

@end

@implementation DLOrderGoodsCell (setCellModel)

- (void)setCellModel:(GoodsModel *)model {
    [self.goodsImgView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.goodsCountButton.hidden = !model.goodsNumber.integerValue;
    [self.goodsCountButton setTitle:model.goodsNumber.stringValue forState:UIControlStateNormal];
}

@end