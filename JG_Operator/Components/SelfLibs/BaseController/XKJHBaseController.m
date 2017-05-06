//
//  XKJHBaseController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHBaseController.h"

@interface XKJHBaseController ()

@end

@implementation XKJHBaseController

- (void)dealloc
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(goBack) target:self];
    self.view.backgroundColor = VCBackgroundColor;
}

#pragma mark - private Method

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)getHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return headerView;
}

@end
