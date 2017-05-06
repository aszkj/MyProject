//
//  DLShopCarVC.h
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSellerBaseController.h"

typedef void(^ComfromPerHomePageBlock)(NSInteger lastHomePageIndex);

@interface DLDispatchGoodsOrderVC : DLSellerBaseController

@property (nonatomic,assign)NSInteger shopCartBadgeNumber;

/**
 *  从登录页进来，返回的时候就得返回到登录页的上一个页面
 */
@property (nonatomic,assign)BOOL cominFromLoginPage;

@property (nonatomic,copy)NSDictionary *confiureDispatchGoodsResultInfo;


/**
 *  登录，点击首页几个tabbar进入购物车
 */
-(void)comFromPerHomePageOfIndex:(NSInteger)lastHomePageIndex
                       backBlock:(ComfromPerHomePageBlock)comfromPerHomePageBlock;

@end
