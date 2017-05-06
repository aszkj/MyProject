//
//  CWNavRootController.m
//  Xixin
//
//  Created by mac_ming on 14-4-9.
//  Copyright (c) 2014年 ciwang. All rights reserved.
//

#import "XKJHNavRootController.h"

@interface XKJHNavRootController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *customBackBtn;

@end

@interface XKJHNavRootController ()

@end

@implementation XKJHNavRootController

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(UIButton *)customBackBtn{
    if (!_customBackBtn) {
        _customBackBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _customBackBtn.bounds = CGRectMake(0, 0, 50, 44);
        [_customBackBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_customBackBtn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
        [_customBackBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 36)];
    }
    return _customBackBtn;
}
- (void)backAction
{
    [self popViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarItem.enabled = NO;
    self.tabBarItem.title = @"";
    self.navigationBar.barTintColor = kGetColor(18, 183, 245);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.customBackBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.interactivePopGestureRecognizer.delegate = self;
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
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.customBackBtn];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    [super pushViewController:viewController animated:animated];
}

@end


