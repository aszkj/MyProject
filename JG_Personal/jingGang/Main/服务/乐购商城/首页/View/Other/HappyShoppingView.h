//
//  HappyShoppingView.h
//  jingGang
//
//  Created by 张康健 on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJSHGuessYourLikeCollectionView.h"
#import "ShowCaseCollectionView.h"
#import "SDCycleScrollView.h"
#import "KJShopHomeHasyouLikeCollectionView.h"
#import "KJShopHomeGuessYoulikeCollectionView.h"
@class ShoppingHomeController;
@interface HappyShoppingView : UIView
//商城首页圈子collectionView
@property (weak, nonatomic) IBOutlet KJSHGuessYourLikeCollectionView *shCircleCollectionViiew;
//商城首页猜您喜欢collectionview
@property (weak, nonatomic) IBOutlet KJShopHomeGuessYoulikeCollectionView *guessYouLikeCollecionView;
//@property (weak, nonatomic) IBOutlet KJSHGuessYourLikeCollectionView *shGuessYouLikeCollectionView;
//商城首页有您喜欢collectionview
//@property (weak, nonatomic) IBOutlet KJSHGuessYourLikeCollectionView *hasYourLikeCollectionView;
@property (weak, nonatomic) IBOutlet KJShopHomeHasyouLikeCollectionView *haveYouLikeCollectionView;

//持有的控制器，跳转用
@property (nonatomic, strong)ShoppingHomeController *shoppingHomeController;


@property (weak, nonatomic) IBOutlet ShowCaseCollectionView *showCasefirstLevelCollectionView;
@property (weak, nonatomic) IBOutlet ShowCaseCollectionView *showCaseSecondLevelCollectionView;

//头部scrollView
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerScrollView;



@end
