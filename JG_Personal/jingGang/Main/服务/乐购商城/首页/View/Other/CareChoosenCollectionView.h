//
//  CareChoosenCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/10/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHKJGuessyouLikeCollectionCell.h"
@class CareChoosenCollectionView;

typedef void(^CareChoosenGoodsBlcok)(CGFloat cellectionHeight, CareChoosenCollectionView *collectionView);

@interface CareChoosenCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

-(UICollectionViewLayout *)getDefaultLayout;
-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, copy)NSArray *dataArr;

//请求推荐位
-(void)requestWithGoodsCode:(NSString *)storeCode result:(CareChoosenGoodsBlcok)resultBlock;


@end
