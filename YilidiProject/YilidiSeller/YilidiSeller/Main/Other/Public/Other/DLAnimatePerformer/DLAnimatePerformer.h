//
//  DLAnimatePerformer.h
//  YilidiSeller
//
//  Created by yld on 16/4/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AnimateDidEndBlock)(void);

@interface DLAnimatePerformer : NSObject
/**
 *  动画执行时间
 */

@property (nonatomic,assign)CGFloat animateDuration;
/**
 *  动画视图执行完是否移除
 */

@property (nonatomic,assign)BOOL animateCompledRemoved;

/**
 *  动画起始点
 */

@property (nonatomic,assign)CGPoint animateStartPoint;

/**
 *  动画视图从起始点到结束点的中间一个斜率点，算坡度的
 */

@property (nonatomic,assign)CGPoint animateBezialMiddelPoint;

/**
 *  动画结束点
 */
@property (nonatomic,assign)CGPoint animateEndPoint;

/**
 *  动画执行视图
 */
@property (nonatomic,strong)UIImageView *animateImgView;

/**
 *  动画执行视图执行动画时大小，
 */
@property (nonatomic,assign)CGRect animateViewFrame;

/**
 *  动画在那个视图上展示，默认window
 */

@property (nonatomic,strong)UIView *animateShowContainerView;

/**
 * 动画组数组
 */
@property (nonatomic,strong)NSArray *animateGroups;

/**
 *  动画结束回调块
 */
@property (nonatomic,copy)AnimateDidEndBlock animateDidEndBlock;
/**
 *  展示项目中默认加入购物车动画 默认起始点动画视图终点，默认animateShowContainerView=window

 *
 *  @param animateGoodsImgView 展示动画的图片
 *  @param animatiEndPoint     展示动画结束点
 *  @param animateDidEndBlock  动画结束回调块
 */
- (void)performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:(UIImageView *)animateGoodsImgView
                                                          animateEndPoint:(CGPoint)animatiEndPoint
                                                       animateDidEndBlock:(AnimateDidEndBlock)animateDidEndBlock;
/**
 *  展示项目中默认加入购物车动画 只不过参数可以定制
 *
 *  @param animateGoodsImgView      展示动画的图片视图
 *  @param animateViewFrame         展示动画图片视图的起始大小
 *  @param animateShowContainerView 展示动画的容器视图，
 *  @param animatiEndPoint          展示动画结束点
 *  @param animateDidEndBlock       动画结束回调块
 */
- (void)performProjectDefaultAddShopCartAnimationForAnimationGoodsImgView:(UIImageView *)animateGoodsImgView
                                                         animateViewFrame:(CGRect)animateViewFrame
                                                 animateShowContainerView:(UIView *)animateShowContainerView
                                                          animateEndPoint:(CGPoint)animatiEndPoint
                                                       animateDidEndBlock:(AnimateDidEndBlock)animateDidEndBlock;
/**
 *  一般组动画
 *
 *  @param groupAnimations          组动画数组
 *  @param showAnimateImgView        展示动画的图片视图
 *  @param showAnimateContainerView 展示动画的容器视图，
 *  @param animateDidEndBlock       动画结束回调块
 */
- (void)performCommmonGroupAimations:(NSArray *)groupAnimations
                  showAnimateImgView:(UIImageView *)showAnimateImgView
            showAnimateContainerView:(UIView *)showAnimateContainerView
 animateDidEndBlock:(AnimateDidEndBlock)animateDidEndBlock;
@end
