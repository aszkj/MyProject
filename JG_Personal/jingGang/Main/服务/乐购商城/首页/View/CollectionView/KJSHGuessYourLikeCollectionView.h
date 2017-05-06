//
//  KJSHGuessYourLikeCollectionView.h
//  商品详情页collectionView测试
//
//  Created by 张康健 on 15/8/14.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark 这个collectionView三个部分共用，商城圈子，猜您喜欢，有你喜欢
typedef enum : NSUInteger {
    CirCleCollectionViewType, //商城圈子
    GuessYoulikeCollectionViewType,//猜您喜欢
    HasYourLikeCollectionViewType //有你喜欢
}ShoppingMainCollectionViewType;
@class GoodsDetailModel;
@class AdRecommendModel;
//圈子点击回调block
typedef void(^CircleClickBlock)(NSNumber *circleID);
//猜您喜欢回调block
typedef void(^GuessyouLikeClickBlock)(GoodsDetailModel *model);
//有您喜欢回调block
typedef void(^HasyouLikeClickBlock)(AdRecommendModel *model);

@interface KJSHGuessYourLikeCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,assign)ShoppingMainCollectionViewType collectionViewType;

@property (nonatomic,copy)NSArray *circleDataArr;
@property (nonatomic,copy)NSArray *guessYouLikeDataArr;
@property (nonatomic,copy)NSArray *hasYouLikeDataArr;


//回调block
@property (nonatomic, copy)CircleClickBlock circleClickBlock;
@property (nonatomic, copy)GuessyouLikeClickBlock guessyouLikeClickBlock;
@property (nonatomic, copy)HasyouLikeClickBlock hasyouLikeClickBlock;

@end
