//
//  JGBaseViewController.h
//  jingGang
//
//  Created by 张康健 on 15/7/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "GotoStoreExperienceCollectionView.h"
#import "CustomTabBar.h"
#import "TMCache.h"
#import "VApiManager.h"
@interface JGBaseViewController : UIViewController
{
    UIScrollView                                    *_myScrollView;
    SDCycleScrollView                               *_topScrollView;
    GotoStoreExperienceCollectionView               *_midleView;
    UIView                                          *_lit_midel_view;
    UIImageView                                     *_lit_midel_img;
}

//基类base滑动视图
@property (nonatomic, strong) UIScrollView    *myScrollView;

//基类头部滑动视图
@property (nonatomic, strong) SDCycleScrollView   *topScrollView;

@property (nonatomic, strong) GotoStoreExperienceCollectionView          *midleView;

//中间视图下面的视图，以及子视图,靖港项目,
@property (nonatomic, strong) UIView          *lit_midel_view;
@property (nonatomic, strong) UIImageView     *lit_midel_img;

//顶部广告数据数组
@property (nonatomic, strong) NSArray  *headDataArr;

//中间view上的数据
@property (nonatomic, strong) NSArray  *middleDataArr;

//公用标题
@property (nonatomic, copy)NSString *jtitle;

//tabbarController
@property (nonatomic, strong)CustomTabBar *customTabBar;

//缓存类
@property (nonatomic, copy)TMCache *baseCache;

//网络请求类
@property (nonatomic, strong)VApiManager *vapManager;



#pragma mark --------------供子类调用-------------------------
-(void)initMyScrollView;
-(void)initHeadScrollView;
//初始化父控制器需要的一般视图
-(void)initBaseVCInfo;

//有的子类有靖港广告view需要调用
-(void)initJingGangView;
//子类调用
-(void)initMainView;
//请求头部数据，根据头部推荐位code
-(void)requestHeadDataWithHeadRecommendCode:(NSString *)recommendCode;


//根据头部缓存的key得到头部数据数组
-(void)initHeadDataWithHeadCacheKey:(NSString *)headCacheKey;


#pragma mark --------------供子类重载-------------------------
//点击头部图片，子类做相应处理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

#pragma mark - 点击圈子
-(void)clickCircleAtIndex:(NSInteger)circleIndex;

#pragma mark - 点击靖港项目图片
-(void)lit_btnClick:(UIButton *)middleBtn;

#pragma mark - 点击返回按钮
-(void)back;



@end
