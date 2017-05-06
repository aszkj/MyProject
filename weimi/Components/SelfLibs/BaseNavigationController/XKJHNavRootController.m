//
//  CWNavRootController.m
//  Xixin
//
//  Created by mac_ming on 14-4-9.
//  Copyright (c) 2014年 ciwang. All rights reserved.
//

#import "XKJHNavRootController.h"

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
    self.tabBarItem.enabled = NO;
    self.tabBarItem.title = @"";
    //定制返回按钮,这两个要一起用,为啥这么用，苹果言语不详
//    self.viewControllers[0].navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigation_back"];
//    self.viewControllers[0].navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigation_back"];
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigation_back"];
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigation_back"];
//    [self.view setBackgroundColor:[UIColor colorWithRed:37/255 green:45/255 blue:59/255 alpha:1]];
//    
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
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end


