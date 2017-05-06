//
//  sunViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface sunViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy)NSString      *name_str;
@property (nonatomic, copy)NSString      *midel_img_name;
@property (nonatomic, assign)NSInteger   btn_tag;//监控点击的是健康界面哪一个按钮
@property (nonatomic, copy)NSString      *goods_img_name;
@property (nonatomic, copy)NSString      *mail_img_name;
@property (nonatomic, retain)NSArray     *name_Array;//存放各个区头标题的
@property (nonatomic, retain)NSArray     *logo_textArr;//存放区头小标题

@property(nonatomic,retain)UIPageControl       *myPageControl;
@property (nonatomic, retain)NSTimer                 *myTimer;//定时器。控制顶部广告位滑动

@property (nonatomic, retain)NSMutableArray    *head_img_array;//顶部广告图片数组

@property (nonatomic, assign)int              witch_vc;//监控更多这个按键要跳转到哪个界面

//精选商品code
@property (nonatomic, copy)NSString *careChoosenCode;
//好店推荐code
@property (nonatomic, copy)NSString *goodStoreRecommendCode;

@end
