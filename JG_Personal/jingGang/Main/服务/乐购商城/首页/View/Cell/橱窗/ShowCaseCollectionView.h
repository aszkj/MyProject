//
//  ShowCaseCollectionView.h
//  橱窗collectionView测试
//
//  Created by 张康健 on 15/8/13.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark 这个collectionView两个部分共用，商城首页一级橱窗列表，二级橱窗列表
typedef enum : NSUInteger {
    FirstLevelCollectionViewType, //一级
    SecondLevelCollectionViewType,//二级
}ShowCaseCollectionViewType;
@class GoodsDetailModel;

//当前二级橱窗位于第几页的回调block
typedef void(^CurrentSecondCasePageBlock)(NSInteger currentPageIndex);

//点击橱窗列表
typedef void(^ClickCaseCellBlock)(NSDictionary *cellDic);
//点击橱窗商品列表
typedef void(^ClickCaseGoodsCellBlock)(GoodsDetailModel *model);

@interface ShowCaseCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,assign)ShowCaseCollectionViewType collectionViewType;

//橱窗列表
@property (nonatomic,copy)NSArray *showCaseData;

//橱窗商品列表
@property (nonatomic,copy)NSArray *showCaseGoodsData;


@property (nonatomic,copy)ClickCaseCellBlock clickCaseCellBlock;
@property (nonatomic,copy)ClickCaseGoodsCellBlock clickCaseGoodsCellBlock;


//当前二级橱窗位于第几页的回调block
@property (nonatomic,copy)CurrentSecondCasePageBlock currentSecondCasePageBlock;


@end
