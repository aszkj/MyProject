//
//  XKJHBaseController.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHBaseController : UIViewController

@property(nonatomic,strong) VApiManager *vapManager;
@property(nonatomic,strong) NSString *token;

- (UIView *)getHeaderView;


@end
