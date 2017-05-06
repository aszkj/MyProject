//
//  ShopCartGoodsNumberChangeView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectRelativeConst.h"

@class GoodsModel;
typedef void (^CountChangedBlk)(NSInteger,BOOL isAdd);

@interface ShopCartGoodsNumberChangeView : UIView

@property (nonatomic,strong)GoodsModel *goodsModel;

@property (nonatomic,assign)BOOL isSelfOperateAddOrSub;

//购买数量
@property (nonatomic, assign)NSInteger buyGoodsCount;

//库存
@property (nonatomic, assign)NSInteger goodsStockCount;


@property (copy, nonatomic) CountChangedBlk countChangedBlk;

@property (nonatomic,copy)DeleteShopCartGoodsBlock deleteShopCartGoodsBlock;

@property (nonatomic,assign)BOOL hasSubToZeroAnimation;

@property (nonatomic,copy)NSString *subImgName;

@property (nonatomic,copy)NSString *addImgName;

@property (nonatomic,copy)NSString *addEabledImgName;


- (void)initUiFromShopCartGoodsId:(NSString *)goodsId;

@end
