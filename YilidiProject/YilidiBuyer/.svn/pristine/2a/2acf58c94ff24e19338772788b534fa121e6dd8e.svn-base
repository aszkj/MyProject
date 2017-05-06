//
//  DLHomeHeaderView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
//专题部分图片宽高比
#define kSpecialFirstPartImgAspatio 2.08
#define kSpecialSecondPartImgAspatio 1.606
//顶部轮播图宽高比
#define kTopLoopAdImgAspatio 2.25
//节日广告图宽高比
#define kHolidayAdImgAspatio 3.6
/**
 *  变化部分高度
 */
//顶部轮播图高度
#define kDLhomeHeaderCycleViewHeight (kScreenWidth / kTopLoopAdImgAspatio)
//节日广告图高度
#define kHolidayAdPartHeight (kScreenWidth / kHolidayAdImgAspatio)
//第二部分专题宽度、高度
#define kSpecaiSubjectSecondlPartWidth (kScreenWidth) / 3
#define kSpecaiSubjectSecondlPartHeight  kSpecaiSubjectSecondlPartWidth/ kSpecialSecondPartImgAspatio
//秒杀部分总高度
#define KSeckillPartViewWidth ADAPT_SCREEN_WIDTH(174)
#define KSeckillPartViewHeight (kScreenWidth-KSeckillPartViewWidth)/2/0.601
//#define KSeckillAndSpecialSubjectPartHeight 280+4
/**
 *  不变部分高度
*/
//101
#define kDlhomeHeaderFixedHeight (70 + 7 + 7)
//头部视图总高度
#define kDlhomeHeaderViewTotalHeight (kDLhomeHeaderCycleViewHeight + kHolidayAdPartHeight + kDlhomeHeaderFixedHeight + KSeckillPartViewHeight + kSpecaiSubjectSecondlPartHeight)
//首页固定不变部分高度
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface DLHomeHeaderView : UICollectionReusableView


@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerCycleView;


@property (nonatomic,assign)CGFloat homeFirstSectionHeaderHeight;

/**
 *  头部轮播广告
 */
@property (nonatomic,copy)NSArray *headerLoopArr;

/**
 首页四个item数据
 */
@property (nonatomic,copy)NSArray *homeIconArr;

/**
 *  头部节假日活动广告
 */
@property (nonatomic,copy)NSArray *headerHolidayAdArr;
/**
 *  头部多专题广告
 */
@property (nonatomic,copy)NSArray *headerSpecialSubjectAdArr;
/**
 *  头部秒杀活动广告
 */
@property (nonatomic,copy)NSArray *headerSeckillAdArr;

/**
 *  请求秒杀活动信息
 */
- (void)requestSeckillActivityCrazyStratchInfo;

- (void)setHeaderHolidayAdArr:(NSArray *)headerHolidayAdArr
      getHolidayAdHeightBlock:(void(^)(CGFloat holidayAdHeight))getHolidayAdHeightBlock;


@end
