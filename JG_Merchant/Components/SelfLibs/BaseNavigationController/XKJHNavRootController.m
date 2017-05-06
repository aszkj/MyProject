//
//  CWNavRootController.m
//  Xixin
//
//  Created by mac_ming on 14-4-9.
//  Copyright (c) 2014年 ciwang. All rights reserved.
//

#import "XKJHNavRootController.h"
//#import "Controller.h"
//#import "UserController.h"

@interface XKJHNavRootController ()

@end

@implementation XKJHNavRootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor colorWithRed:37/255 green:45/255 blue:59/255 alpha:1]];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end


