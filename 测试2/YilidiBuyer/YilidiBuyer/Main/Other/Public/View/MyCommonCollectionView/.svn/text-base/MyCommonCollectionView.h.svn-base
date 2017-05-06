//
//  MyCommonCollectionView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionView.h"
#import "CellCalculateModel.h"
typedef void(^ConfigureCollectionCellBlock)(UICollectionView *collectionView,id collectionModel,UICollectionViewCell *collectionCell);
typedef void(^ConfigurefirstSectionHeaderBlock)(UICollectionView *collectionView,id collectionModel,UICollectionReusableView *firstSectionHeaderView);
typedef void(^ClickCellBlock)(UICollectionView *collectionView,id collectionModel,UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath);
typedef void(^ListenCollectionScrollOffsetBlock)(CGFloat contentOffset);
@interface MyCommonCollectionView : BaseCollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)CellCalculateModel *cellCalculateModel;
@property (nonatomic,copy)ConfigureCollectionCellBlock configureCollectionCellBlock;
@property (nonatomic,copy)ConfigurefirstSectionHeaderBlock configurefirstSectionHeaderBlock;
@property (nonatomic,copy)ClickCellBlock clickCellBlock;

@property (nonatomic,copy)ListenCollectionScrollOffsetBlock listenCollectionScrollOffsetBlock;
@property (nonatomic,strong)UICollectionViewFlowLayout *commonFlowLayout;
@property (nonatomic,strong)UICollectionViewFlowLayout *customedFlowLayout;
@property (nonatomic,copy)NSString *firstSectionHeaderNibName;
@property (nonatomic,copy)NSString *firstSectionHeaderIdentifer;

@property (nonatomic,copy)NSString *cellNibName;
@property (nonatomic,copy)NSString *cellIdentifer;

#pragma mark - 配置firstSectionHeader
- (void)configureFirstSectioHeaderNibName:(NSString *)firstSectionHeaderNibName
         configureFirstSectionHeaderBlock:(ConfigurefirstSectionHeaderBlock)configurefirstSectionHeaderBlock;

#warning 这三个方法必须要调用其中一个
-(void)configureCollectionCellNibName:(NSString *)collectionCellNibName
          configureCollectionCellData:(ConfigureCollectionCellBlock)configureCollectionCellBlock;

-(void)configureCollectionCellNibName:(NSString *)collectionCellNibName
          configureCollectionCellData:(ConfigureCollectionCellBlock)configureCollectionCellBlock
                            clickCell:(ClickCellBlock)clickCellBlock;

-(void)configureCollectionCellNibName:(NSString *)collectionCellNibName
                       cellDataSource:(NSArray *)cellDataSource
          configureCollectionCellData:(ConfigureCollectionCellBlock)configureCollectionCellBlock
                            clickCell:(ClickCellBlock)clickCellBlock;


@end
