//
//  mainViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "VApiManager.h"
#import "AccessToken.h"
#import "JGBaseViewController.h"

@interface mainViewController : JGBaseViewController<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CLLocationManager      *_myLocation;
//    BOOL                   _headYorN;//控制头像按钮点击
}

@property (nonatomic, assign)BOOL     headYorN;
@property (nonatomic, copy)NSString   *advert_img;//中间广告图
@property (nonatomic, retain)NSMutableArray * head_arr;//顶部图片数组

+ (mainViewController *) instance;


@end
