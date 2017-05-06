//
//  JGangBaseNavController.m
//  jingGang
//
//  Created by 张康健 on 15/11/23.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGangBaseNavController.h"

@interface JGangBaseNavController ()

@end

@implementation JGangBaseNavController

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
    self.navigationBar.barTintColor = COMMONTOPICCOLOR;
    
//    self.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:36.0/255.0 blue:39.0/255.0 alpha:1];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionaryWithCapacity:0];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [self.tabBarItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBar.barTintColor = COMMONTOPICCOLOR;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
