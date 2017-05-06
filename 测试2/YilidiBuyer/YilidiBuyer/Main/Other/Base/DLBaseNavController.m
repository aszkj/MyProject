//
//  JGangBaseNavController.m
//  jingGang
//
//  Created by 张康健 on 15/11/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "DLBaseNavController.h"
#import "GlobleConst.h"
#import "DLMainTabBarController.h"
#import "ProjectRelativeMaco.h"
@interface DLBaseNavController ()

@end

@implementation DLBaseNavController

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
  
//    self.navigationBar.barTintColor = COMMONTOPICCOLOR;
//    self.navigationBar.barTintColor = UIColorFromRGB(0xFFFFFF);
    
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionaryWithCapacity:0];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [self.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationBar.barTintColor = COMMONTOPICCOLOR;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
