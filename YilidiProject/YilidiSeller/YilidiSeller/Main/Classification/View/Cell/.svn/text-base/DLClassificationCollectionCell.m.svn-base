//
//  DLClassificationCollectionCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLClassificationCollectionCell.h"
#import "UIImageView+sd_SetImg.h"

@interface DLClassificationCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsImgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsImgViewWidthConstraint;

@end

@implementation DLClassificationCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

@implementation DLClassificationCollectionCell (setCellModel)

- (void)setCellModel:(GoodsClassModel *)model{
    
    self.goodsTitleLabel.text = model.className;
    [self.goodsImgView sd_SetImgWithUrlStr:model.classImageUrl placeHolderImgName:nil];
}

- (void)setImgWidth:(CGFloat)imgWidth
             height:(CGFloat)imgHeight
{
    self.goodsImgViewWidthConstraint.constant = imgWidth;
    self.goodsImgViewHeightConstraint.constant = imgHeight;
}


@end
