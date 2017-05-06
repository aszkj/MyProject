//
//  UIViewController+hub.h
//  YilidiBuyer
//
//  Created by yld on 16/6/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (hub)

- (void)showHub;

- (void)showHubWithStatus:(NSString *)status;

- (void)showHubWithDefaultStatus;

- (void)showInfoWithStatus:(NSString *)string;

- (void)showSuccessInfoWithStatus:(NSString*)string;

- (void)showErrorInfoWithStatus:(NSString *)string;

- (void)dissmiss;


@end

@interface UIViewController (loadingHub)
- (MBProgressHUD *)MB_showLoadingHubWithText:(NSString *)loadingText;
- (void)MB_hideLoadingHub;
- (void)MB_hideHubForText:(NSString *)hideText;
@end
