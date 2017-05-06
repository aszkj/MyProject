//
//  ShopCartView.h
//  jingGang
//
//  Created by 张康健 on 15/8/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CominToShopCartBlock)(void);

@interface ShopCartView : UIView

+ (id)showOnNavgationView:(UIView *)navigationView;

//请求设置购物车数量
-(void)requestAndSetShopCartNumber;


@property (nonatomic ,assign)NSInteger shopCartNumber;


@property (nonatomic, copy)CominToShopCartBlock cominToShopCartBlock;

@end
