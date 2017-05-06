//
//  expertsViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VApiManager.h"
#import "AccessToken.h"

@interface expertsViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, copy)NSString      *img_str;
@property (nonatomic, copy)NSString      *name_str;
@property (nonatomic, copy)NSString      *sex_str;
@property (nonatomic, copy)NSString      *phone_num;
@property (nonatomic, copy)NSString      *dis_Str;//医生介绍
@property (nonatomic, copy)NSString      *uId;//医生id

@end
