//
//  DLCommunityWellSelecteCollectionViewCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/10.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLHomeGoodsModel;
@interface DLCommunityWellSelecteCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriginalPriceLabel;
@end

@interface DLCommunityWellSelecteCollectionViewCell (setCellModel)

- (void)setCellModel:(DLHomeGoodsModel *)model;

@end