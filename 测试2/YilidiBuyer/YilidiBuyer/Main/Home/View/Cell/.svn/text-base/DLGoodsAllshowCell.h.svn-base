//
//  DLGoodsAllshowCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "ShopCartGoodsNumberChangeView.h"
#define GoodsAllshowCellImgWidth  ADAPT_SCREEN_WIDTH(77)
#define GoodsAllshowCellImgHeight GoodsAllshowCellImgWidth
#define GoodsAllshowHeight (GoodsAllshowCellImgHeight + 20)

#define DLreshFruitCellImgToSideEdge 8
#define DLreshFruitCellWidth ((kScreenWidth-30)/2)
#define DLreshFruitCellImgWidth (DLreshFruitCellWidth - DLreshFruitCellImgToSideEdge * 2)
#define DLreshFruitCellImgHeight DLreshFruitCellImgWidth/1.0
#define DLreshFruitCellHeight (DLreshFruitCellImgHeight + 56)
#define DLspace 10

@interface DLGoodsAllshowCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidthConstraint;

@property (weak, nonatomic) IBOutlet ShopCartGoodsNumberChangeView *goodsCountChangeView;
@end

@interface DLGoodsAllshowCell (setSNearChannelModel)

-(void)setGoodsAllshowCell:(GoodsModel *)model;

@end
