//
//  DLDispatchGoodsCell.h
//  YilidiSeller
//
//  Created by yld on 16/6/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "ShopCartGoodsNumberChangeView.h"
#define DispatchGoodsCellImgWidth ADAPT_SCREEN_WIDTH(96)
#define DispatchGoodsCellImgHeight DispatchGoodsCellImgWidth
#define DispatchGoodsCellHeight (DispatchGoodsCellImgHeight + 20)
typedef void(^SelectDispatchGoodsBlock)(UIButton *);
typedef void(^ChangeDispatchGoodsCountBlock)(NSInteger nowCount,BOOL isAdd);

@interface DLDispatchGoodsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchasePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *miniteRepositorystockLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeStockLabel;
@property (weak, nonatomic) IBOutlet UILabel *basicOrderNumberLabel;
@property (weak, nonatomic) IBOutlet ShopCartGoodsNumberChangeView *goodsCountChangeView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBgViewWidthConstraint;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *imgViewToSideEdges;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBgViewToLeftConstraint;
@property (weak, nonatomic) IBOutlet UIButton *selecteButton;
@property (nonatomic,copy)SelectDispatchGoodsBlock selectDispatchGoodsBlock;
@property (nonatomic,copy)ChangeDispatchGoodsCountBlock changeDispatchGoodsCountBlock;


@end

@interface DLDispatchGoodsCell (setGoodsModel)

-(void)setCellModel:(GoodsModel *)model;


@end
