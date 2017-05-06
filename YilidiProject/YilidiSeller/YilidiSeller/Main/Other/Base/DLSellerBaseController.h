//
//  XKJHBaseController.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "AlertViewManager.h"


@interface DLSellerBaseController : UIViewController

/**
 *  统一设置界面UI，如颜色,字体，圆角等
 */
- (void)setUIAppearance;
/**
 *  统一绑定UI数据及逻辑判断
 *  控制器处理错误
 *  @param error 错误信息
 */
- (void)errorHandle:(NSError *)error;

@property (nonatomic,assign)BOOL doNotNeedBaseBackItem;
@property (nonatomic,assign)BOOL showNavbarBottomLine;


@property (nonatomic,copy)NSString *pageTitle;
@property (nonatomic,strong)UIColor *titleColor;
@property (nonatomic,strong)UIColor *navBarColor;
@property (nonatomic,strong)NSString *backIconName;



@property (nonatomic,copy)NSDictionary *requestParam;


- (MBProgressHUD *)showLoadingHub;
- (MBProgressHUD *)showLoadingHubWithText:(NSString *)loadingText;
- (void)hideHubForText:(NSString *)hideText;
- (void)hideLoadingHub;
- (void)hideHubWithOnlyText:(NSString *)hideText;



- (UIView *)getHeaderView;

- (void)goBack;
- (void)goBackAfter:(NSInteger)seconds;
- (void)delayGoBack;

- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction
                    cancelAction:(AlertViewOtherAction)cancelAction;

- (void)showSimplyAlertWithTitle:(NSString *)alertTitle
                         message:(NSString *)alertMessage
                      sureAction:(AlertViewAction)sureAction;

- (void)navigatePushViewController:(UIViewController *)viewController
                           animate:(BOOL)animate;

@end
