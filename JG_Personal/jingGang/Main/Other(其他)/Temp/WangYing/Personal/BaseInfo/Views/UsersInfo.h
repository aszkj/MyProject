//
//  UsersInfo.h
//  jingGang
//
//  Created by wangying on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface UsersInfo : UIView
@property(nonatomic,strong)UIScrollView *scroll_other;

-(void)creatUI;

@property (nonatomic,copy)NSString *emailStr;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *weightStr;
@property (nonatomic,copy)NSString *heightStr;
@property (nonatomic,copy)NSString *birthDayStr;



@property (nonatomic,copy)NSString *allergicHistory;
@property (nonatomic,copy)NSString *transHistory;
@property (nonatomic,copy)NSString *transGentic;


@end
