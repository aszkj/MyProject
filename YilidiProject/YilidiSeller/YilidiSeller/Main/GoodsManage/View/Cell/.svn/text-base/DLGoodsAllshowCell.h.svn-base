//
//  DLGoodsAllshowCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

#define GoodsAllshowCellImgWidth ADAPT_SCREEN_WIDTH(68)
#define GoodsAllshowCellImgHeight GoodsAllshowCellImgWidth
#define GoodsAllshowHeight (GoodsAllshowCellImgHeight + 12)

#define DLreshFruitCellImgToSideEdge 8
#define DLreshFruitCellWidth ((kScreenWidth-30)/2)
#define DLreshFruitCellImgWidth (DLreshFruitCellWidth - DLreshFruitCellImgToSideEdge * 2)
#define DLreshFruitCellImgHeight DLreshFruitCellImgWidth/1.0
#define DLreshFruitCellHeight (DLreshFruitCellImgHeight + 56)
#define DLspace 10

typedef void(^SelectGoodsBlock)(UIButton *);

@interface DLGoodsAllshowCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *salesVulomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBgViewWidthConstraint;

@property (nonatomic,copy)SelectGoodsBlock selectGoodsBlock;

@end

@interface DLGoodsAllshowCell (setSNearChannelModel)

-(void)setGoodsAllshowCell:(GoodsModel *)model;

@end
