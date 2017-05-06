//
//  DLHomeFoodCollectionView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLHomeHeaderView.h"
#import "ProjectRelativeConst.h"

typedef void(^ScrollContentOffsetBlock)(CGFloat contentOffset);

@interface DLHomeFoodCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)UICollectionViewFlowLayout *homeFoodCollectionViewLayout;

@property (nonatomic,copy)NSArray *floorList;

@property (nonatomic,assign)CGFloat headerHeight;

@property (nonatomic,strong)DLHomeHeaderView *homeFirstSectionView;

@property (nonatomic,copy)ClickCollectionViewCellBlock clickGoodsCellBlock;

@property (nonatomic,copy)ScrollContentOffsetBlock scrollContentOffsetBlock;


@end
