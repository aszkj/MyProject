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
#import "ShopCartGoodsNumberChangeView.h"
#define kShopCartCellHeight 109

typedef void(^DeleteShopCartGoodsBlock)(void);
typedef void(^SelectShopCartGoodsBlock)(UIButton *);
typedef void(^ChangeShopCartGoodsCountBlock)(NSInteger nowCount,BOOL isAdd);

@interface DLShopCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStandLabel;
@property (weak, nonatomic) IBOutlet UIButton *allSelectedButton;
@property (weak, nonatomic) IBOutlet ShopCartGoodsNumberChangeView *goodsCountChangeView;
@property (weak, nonatomic) IBOutlet GoodsStatusView *goodsStatusView;

@property (nonatomic,copy)DeleteShopCartGoodsBlock deleteShopCartGoodsBlock;
@property (nonatomic,copy)SelectShopCartGoodsBlock selectShopCartGoodsBlock;
@property (nonatomic,copy)ChangeShopCartGoodsCountBlock changeShopCartGoodsCountBlock;


@end

@interface DLShopCartCell (setShopCartCellModel)

-(void)setShopCartCellModel:(GoodsModel *)model;

@end