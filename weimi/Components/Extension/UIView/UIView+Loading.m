//
//  UIView+Loading.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "UIView+Loading.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIView (Loading)

static NSInteger loadingTag = 1000;

- (void)showLoading {
    MBProgressHUD *loadingView = [self viewWithTag:loadingTag];
    if (loadingView) {
        // If loading view is already found in current view hierachy, do nothing
        return;
    }
    loadingView = [MBProgressHUD showHUDAddedTo:self animated:YES];
    loadingView.tag = loadingTag;
}

- (void)showWithTitle:(NSString *)title {
    MBProgressHUD *loadingView = [self viewWithTag:loadingTag];
    if (loadingView) {
        loadingView.labelText = title;
        return;
    }
    loadingView = [MBProgressHUD showHUDAddedTo:self animated:YES];
    loadingView.tag = loadingTag;
    loadingView.labelText = title;
}

- (void)hideLoading {
    MBProgressHUD *loadingView = (MBProgressHUD *)[self viewWithTag:loadingTag];
    if (loadingView) {
        [MBProgressHUD hideHUDForView:self animated:YES];
    }
}

@end
