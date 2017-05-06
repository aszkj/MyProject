//
//  JYSlideSegmentController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const segmentBarItemID;

@class JYSlideSegmentController;

/**
 *  Need to be implemented this methods for custom UI of segment button
 */
@protocol JYSlideSegmentDataSource <NSObject>
@required

- (NSInteger)slideSegment:(UICollectionView *)segmentBar
   numberOfItemsInSection:(NSInteger)section;

- (UICollectionViewCell *)slideSegment:(UICollectionView *)segmentBar
            cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfSectionsInslideSegment:(UICollectionView *)segmentBar;

@end

@protocol JYSlideSegmentDelegate <NSObject>
@optional
- (void)slideSegment:(UICollectionView *)segmentBar didSelectedViewController:(UIViewController *)viewController;

- (BOOL)slideSegment:(UICollectionView *)segmentBar shouldSelectViewController:(UIViewController *)viewController;
@end

@interface JYSlideSegmentController : UIViewController

/**
 *  Child viewControllers of SlideSegmentController
 */
@property (nonatomic, copy) NSArray *viewControllers;

@property (nonatomic, strong, readonly) UICollectionView *segmentBar;
@property (nonatomic, strong, readonly) UIScrollView *slideView;
@property (nonatomic, strong, readonly) UIView *indicator;

@property (nonatomic, assign) UIEdgeInsets indicatorInsets;

@property (nonatomic, weak, readonly) UIViewController *selectedViewController;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign) NSInteger witch;//监控一共有多少个页面（）

@property (nonatomic,assign) NSInteger indexx;
/**
 *  By default segmentBar use viewController's title for segment's button title
 *  You should implement JYSlideSegmentDataSource & JYSlideSegmentDelegate instead of segmentBar delegate & datasource
 */
@property (nonatomic, assign) id <JYSlideSegmentDelegate> delegate;
@property (nonatomic, assign) id <JYSlideSegmentDataSource> dataSource;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers;

- (void)reset:(NSInteger)tag;

- (void)scrollToViewWithIndex:(NSInteger)index animated:(BOOL)animated;

@end
