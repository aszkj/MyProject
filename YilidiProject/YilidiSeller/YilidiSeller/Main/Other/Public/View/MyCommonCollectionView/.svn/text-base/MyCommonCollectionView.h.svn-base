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

typedef NS_ENUM(NSInteger,CollectionGroupType) {
    CollectionGroupType_SingleGroup,
    CollectionGroupType_MultiGroupSameHeader,
    CollectionGroupType_MultiGroupDifferentHeader
};

#pragma mark - single group block
typedef void(^ConfigureCollectionCellBlock)(UICollectionView *collectionView,id collectionModel,UICollectionViewCell *collectionCell,NSIndexPath *indexPath);
typedef void(^ConfigurefirstSectionHeaderBlock)(UICollectionView *collectionView,id collectionModel,UICollectionReusableView *firstSectionHeaderView);
typedef void(^ClickCellBlock)(UICollectionView *collectionView,id collectionModel,UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath);

#pragma mark - multi group block
typedef NSInteger(^GetCollectionSectionCellsCountBlock)(UICollectionView *collectionView,id groupModel,NSInteger section);

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


#pragma mark - multi section
@property (nonatomic,copy)GetCollectionSectionCellsCountBlock getCollectionSectionCellsCountBlock;
@property (nonatomic,copy)NSArray *collectionSectionHeaderIdentifiers;
@property (nonatomic,assign)CollectionGroupType collectionGroupType;


#pragma mark - configure multi group
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


#pragma mark - configure multi group
//配置分组的，每组组头相同，
-(void)configureMultiSetionHeaderNibName:(NSString *)setionHeaderNibName
                   collectionCellNibName:(NSString *)collectionCellNibName
          getCollectionSectionCountBlock:(GetCollectionSectionCellsCountBlock)getCollectionSectionCellsCountBlock
     configureCollectionSectionCellBlock:(ConfigureCollectionCellBlock)configureCollectionSectionCellBlock
   configureCollectionSectionHeaderBlock:(ConfigurefirstSectionHeaderBlock)
configureCollectionSectionHeaderBlock
                          clickCellBlock:(ClickCellBlock)clickCellBlock
;







@end
