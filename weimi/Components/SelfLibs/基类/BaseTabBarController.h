//
//  BaseViewController.h
//  weimi
//
//  Created by thinker on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^TabBarNewMessageBlock)(void);

@interface BaseTabBarController : UITabBarController

@property (nonatomic, strong) UIView *tabBarCustomView;
@property (nonatomic, strong) TabBarNewMessageBlock tabBarNewMessageBlock;

//唯秘红点
@property (nonatomic, assign) BOOL hiddenWeimiRed;
//发现红点
@property (nonatomic, assign) BOOL hiddenFindRed;

@end
