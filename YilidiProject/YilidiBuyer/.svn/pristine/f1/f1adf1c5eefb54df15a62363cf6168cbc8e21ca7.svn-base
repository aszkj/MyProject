//
//  DLBrandCollectionCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLBrandCollectionCell.h"
#import "UIImageView+sd_SetImg.h"
#import "DLBrandModel.h"
@implementation DLBrandCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (kScreenWidth==iPhone5_width) {
        self.brandTitle.font = [UIFont systemFontOfSize:13];
    }
}

- (void)setModel:(DLBrandModel *)model{

    [self.brandImage sd_SetImgWithUrlStr:model.brandUrl placeHolderImgName:nil];
    self.brandTitle.text = model.brandName;
    
}

@end
