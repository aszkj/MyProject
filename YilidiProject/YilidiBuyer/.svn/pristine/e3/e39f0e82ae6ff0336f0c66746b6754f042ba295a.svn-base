//
//  DLShopCartCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "GoodsStatusView.h"
#import "ProjectRelativeConst.h"
#import "ShopCartGoodsNumberChangeView.h"
#define kDLFavoriteCellHeight 104

typedef void(^SelectFavoriteGoodsBlock)(UIButton *);
typedef void(^ChangeShopCartGoodsCountBlock)(NSInteger nowCount,BOOL isAdd);

@interface DLFavoriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNowPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet ShopCartGoodsNumberChangeView *goodsCountChangeView;
@property (weak, nonatomic) IBOutlet GoodsStatusView *goodsStatusView;

@property (nonatomic,copy)DeleteShopCartGoodsBlock deleteShopCartGoodsBlock;
@property (nonatomic,copy)DeleteShopCartGoodsBlock deleteShopCartGoodsFromSubBlock;
@property (nonatomic,copy)SelectFavoriteGoodsBlock selectFavoriteGoodsBlock;
@property (nonatomic,copy)ChangeShopCartGoodsCountBlock changeShopCartGoodsCountBlock;


@end

@interface DLFavoriteCell (setShopCartCellModel)

-(void)setFavoriteCellModel:(GoodsModel *)model;

- (void)favoriteCellIsEdit:(BOOL)isEdit cellModel:(GoodsModel *)model;

@end
