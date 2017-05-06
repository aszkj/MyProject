//
//  WEMEProgressHUD.h
//  WeimiSP
//
//  Created by thinker on 16/3/3.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WEMEProgressHUD : UIView

+ (instancetype)showHUDAddedTo:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;

@end
