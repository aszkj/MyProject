//
//  WSJSearchListSiftViewController.h
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJSearchListSiftViewController : UIViewController

@property (nonatomic, strong) NSArray *data;

//筛选结果返回
@property (nonatomic, copy) void (^siftBlock)(NSString *str,BOOL free,BOOL Inventory,NSArray *data);

@end
