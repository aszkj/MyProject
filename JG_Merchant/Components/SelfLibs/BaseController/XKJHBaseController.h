//
//  XKJHBaseController.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DebugSet.h"
#import "UIView+Loading.h"
#import "XKO_ViewModel.h"

@interface XKJHBaseController : UIViewController

@property(nonatomic,strong) VApiManager *vapManager;
@property(nonatomic,strong) NSString *token;

/**
 *  统一设置界面UI，如颜色,字体，圆角等
 */
- (void)setUIAppearance;
/**
 *  统一绑定UI数据及逻辑判断等
 */
- (void)bindViewModel;
/**
 *  控制器处理错误
 *
 *  @param error 错误信息
 */
- (void)errorHandle:(NSError *)error;

- (UIView *)getHeaderView;

- (void)hideHubWithOnlyText:(NSString *)hideText;


@end
