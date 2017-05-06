//
//  UIViewController+JGShowHubExtension.m
//  jingGang
//
//  Created by dengxf on 15/12/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "UIViewController+JGShowHubExtension.h"

@implementation UIViewController (JGShowHubExtension)
- (void)showHudAltert:(UIView *)view message:(NSString *)message {
    if (view == nil) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.margin = 10.f;
    hud.yOffset = 5.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

@end
