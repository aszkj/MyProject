//
//  DLClassificationCollectionCell.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsClassModel.h"

@interface DLClassificationCollectionCell : UICollectionViewCell

@end

@interface DLClassificationCollectionCell (setCellModel)

- (void)setCellModel:(GoodsClassModel *)model;

- (void)setImgWidth:(CGFloat)imgWidth
             height:(CGFloat)imgHeight;

@end
