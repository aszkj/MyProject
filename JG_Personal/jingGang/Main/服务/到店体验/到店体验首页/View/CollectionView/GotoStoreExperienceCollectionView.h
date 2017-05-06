//
//  GotoStoreExperienceCollectionView.h
//  jingGang
//
//  Created by 张康健 on 15/9/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCircleItemBlock)(NSNumber *circleNumber);

@interface GotoStoreExperienceCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, copy)NSArray *gotoStoreCircleDataArr;
@property (nonatomic, copy)ClickCircleItemBlock clickCircleItemBlock;

//是否是每个首页圈子
@property (nonatomic, assign)BOOL isCircle;

@end
