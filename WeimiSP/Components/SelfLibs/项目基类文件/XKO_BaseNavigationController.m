//
//  XKO_BaseNavigationController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseNavigationController.h"

@interface XKO_BaseNavigationController ()

@end

@implementation XKO_BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
}

- (void)setNavigationBar {
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = status_color;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    if (sysVersion > 7.0)
    {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
}

@end
