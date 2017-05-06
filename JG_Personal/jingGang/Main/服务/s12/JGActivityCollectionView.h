//
//  JGActivityCollectionController.h
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGActivityHotSaleApiBO.h"
#import "ActHotSaleGoodsInfoApiBO1.h"
#import "ActivityHotSaleApiBO.h"
#import "IntegralListBO.h"

typedef void(^SelectedItemShopBlock)(IntegralListBO *apiBO);

typedef void(^ShowFilterView)(UIButton *btn);

@interface JGActivityCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

-(void)setupLayout;

@property (strong,nonatomic) NSArray *shops;

@property (strong,nonatomic) JGActivityHotSaleApiBO *apiBO;

@property (copy , nonatomic) SelectedItemShopBlock selectedItemShopBlock;

@property (strong,nonatomic) ActivityHotSaleApiBO *activityApiBO;

/**
 *  用户积分
 */
@property (assign, nonatomic) CGFloat integarlCount;


@property (copy , nonatomic) ShowFilterView showFilterView;



@end
