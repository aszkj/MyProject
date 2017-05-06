//
//  DLGoodsSearchShowView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MycommonTableView.h"
#import "MyCommonCollectionView.h"

typedef void(^GotoShopCartPageBlock)(void);
typedef void(^GotoGoodsDetailPageBlock)(NSString *goodsId);

@interface DLGoodsSearchShowView : UIView
@property (weak, nonatomic) IBOutlet MycommonTableView *searchGoodsTableView;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *searchGoodsResultCollectionView;

@property (nonatomic,copy)NSString *keyWords;

@property (nonatomic,copy)GotoShopCartPageBlock gotoShopCartPageBlock;

@property (nonatomic,copy)GotoGoodsDetailPageBlock gotoGoodsDetailPageBlock;



@end
