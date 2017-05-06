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
#define kSpecialSecondPartImgAspatio 2.07
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
//第二部分专题高度
#define kSpecaiSubjectSecondlPartHeight (kScreenWidth / 2) / kSpecialSecondPartImgAspatio
//秒杀部分总高度
#define KSeckillPartViewHeight ((kScreenWidth - ADAPT_SCREEN_WIDTH(144))/2.08) * 2
//#define KSeckillAndSpecialSubjectPartHeight 280+4
/**
 *  不变部分高度
*/
//101
#define kDlhomeHeaderFixedHeight 97
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


@end
