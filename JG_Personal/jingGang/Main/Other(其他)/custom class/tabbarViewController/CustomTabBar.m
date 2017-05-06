//
//  CustomTabBar.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CustomTabBar.h"
#import "PublicInfo.h"
#import "userDefaultManager.h"
#import "AppDelegate.h"
#import "GlobeObject.h"
#define MAX_BUTTON_NUM          5
#import "UIButton+WebCache.h"
#import <ReactiveCocoa.h>
#import "mainViewController.h"
#import "healthViewController.h"
#import "userTestViewController.h"
#import "communityViewController.h"
#import "ShoppingHomeController.h"
#import "JGangBaseNavController.h"
#import "JGActivityTools.h"
#import "JGActivityHelper.h"
#import "GoToStoreExperiseController.h"

#define kUserHeadImgChangedNotification @"kUserHeadImgChangedNotification"

@interface CustomTabBar ()

@property (nonatomic) UIButton *leftUserButton;
@property (nonatomic) UIView *leftView;

@end

@implementation CustomTabBar

static CustomTabBar* s_pCustomTabBar = nil;

+ (CustomTabBar *) instance
{
    if (nil == s_pCustomTabBar) {
        s_pCustomTabBar = [[CustomTabBar alloc] init];
        s_pCustomTabBar.selectedIndex = UXinTabIndex_Dial;
    }
    
    return s_pCustomTabBar;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserHeadImgChangedNotification object:nil];
}

- (id) init
{
    self = [super init];
    if (self) {
        s_pCustomTabBar = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userHeadImgChanged:) name:kUserHeadImgChangedNotification object:nil];
        [self setCustomTabBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftView];
    self.delegate = self;

    [self setHideOrShowViews];
}

- (void)setHideOrShowViews
{
    @weakify(self)
    RAC(self.leftView, hidden) = RACObserve(self.tabBar, hidden);
    [[self rac_signalForSelector:@selector(setViewControllers:)] subscribeNext:^(id x) {
        [self.viewControllers enumerateObjectsUsingBlock:^(__kindof JGangBaseNavController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[obj.topViewController rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(id x) {
                @strongify(self)
                if (obj.viewControllers.count > 1) {
                    [self.leftView setHidden:YES];
                    [self.tabBar setHidden:YES];
                    [self closeDrawerGesture];
                }
            }];
            [[obj rac_signalForSelector:@selector(popViewControllerAnimated:)] subscribeNext:^(id x) {
                @strongify(self)
                if (obj.viewControllers.count == 1) {
                    [self.leftView setHidden:NO];
                    [self.tabBar setHidden:NO];
                    [self openDrawerGesture];
                }
            }];
        }];
    }];
    
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(self)
        if (IsEmpty(GetToken)) {
            [self setUnloginButton];
        } else {
            [self setLoginButton];
            [self openDrawerGesture];
        }
    }];
}

- (void)closeDrawerGesture {
    AppDelegate *appDelegate = kAppDelegate;
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [appDelegate.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)openDrawerGesture {
    if (!IsEmpty(GetToken)) {
        AppDelegate *appDelegate = kAppDelegate;
        [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [appDelegate.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    }
}

- (void)jumpLoginAction {
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [JGActivityHelper notTargetControllerShowImage];
    [app beGinLogin];
}

- (void)leftDrawerAction {
    AppDelegate *appDelegate = kAppDelegate;
    [JGActivityHelper notTargetControllerShowImage];
    MMDrawerController *drawerController = appDelegate.drawerController;
    if (drawerController.openSide != MMDrawerSideLeft) {
        if ([JGActivityTools sharedInstance].isServiceModule) {
            [JGActivityTools sharedInstance].shouldShowActivity = NO;
        }
        
        [drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    } else {
        [drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {}];
        if ([JGActivityTools sharedInstance].isServiceModule) {
            [JGActivityTools sharedInstance].shouldShowActivity = YES;
        }
    }
    
}

- (UIView *)leftView {
    if (_leftView == nil) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10, __StatusScreen_Height+5, 45, 35)];
        [leftView addSubview:self.leftUserButton];
        float left_lab_spase = 8;
        for (int i = 0; i < 3; i ++) {
            UILabel * head_left_lab = [[UILabel alloc]init];
            head_left_lab.frame = CGRectMake(3, 7+left_lab_spase*i, 3, 3);
            head_left_lab.backgroundColor = [UIColor whiteColor];
            head_left_lab.layer.cornerRadius = 1.5;
            head_left_lab.clipsToBounds = YES;
            [leftView addSubview:head_left_lab];
        }
        _leftView = leftView;
    }
    return _leftView;
}

- (void)setUnloginButton {
    _leftUserButton.frame = CGRectMake(10, 0, 45, 35);
    [_leftUserButton setTitle:@"未登录" forState:UIControlStateNormal];
    [_leftUserButton setImage:nil forState:UIControlStateNormal];
    [[_leftUserButton titleLabel] setFont:[UIFont systemFontOfSize:12.0]];
    [_leftUserButton removeTarget:self action:@selector(leftDrawerAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftUserButton addTarget:self action:@selector(jumpLoginAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setLoginButton {
    _leftUserButton.frame = CGRectMake(10, 0, 35, 35);
    NSDictionary *userInfoDic = [kUserDefaults objectForKey:userInfoKey];
    NSString *headUrl = userInfoDic[@"headImgPath"];
    
    _leftUserButton.layer.cornerRadius = 35/2;
    _leftUserButton.clipsToBounds = YES;
    [_leftUserButton removeTarget:self action:@selector(jumpLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftUserButton addTarget:self action:@selector(leftDrawerAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftUserButton sd_setImageWithURL:[NSURL URLWithString:headUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_head"]];
}

- (UIButton *)leftUserButton {
    if (_leftUserButton == nil) {
        _leftUserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftUserButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (IsEmpty(GetToken)) {
            [self setUnloginButton];
        } else {
            [self setLoginButton];
        }
    }
    return _leftUserButton;
}

#pragma mark - 头像改变监听通知
-(void)userHeadImgChanged:(NSNotification *)info{
    
    NSLog(@"class:%@",[[kUserDefaults objectForKey:userInfoKey] class]);
    
    NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionaryWithDictionary:[kUserDefaults objectForKey:userInfoKey]];
    userInfoDic[@"headImgPath"] = info.object;
    [kUserDefaults setObject:userInfoDic forKey:userInfoKey];
    [self setLoginButton];
}

- (void)setCustomTabBar
{
//    [self.tabBar setSelectedImageTintColor:UIColorFromRGB(0x4ab6ec )];
    UIColor *titleHighlightedColor = COMMONTOPICCOLOR;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor,UITextAttributeTextColor,nil] forState:UIControlStateSelected];
    mainViewController * mainVc = [[mainViewController alloc]init];
    JGangBaseNavController * nav = [[JGangBaseNavController alloc]initWithRootViewController:mainVc];
    nav.title = @"健康管理";
//    nav.tabBarItem.image = [UIImage imageNamed:@"tab_0_nor"];
//    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_0_sel"];
    nav.tabBarItem.image = [[UIImage imageNamed:@"one"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"oneSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    healthViewController * healthVc = [[healthViewController alloc]init];
//    JGangBaseNavController * nav1 = [[JGangBaseNavController alloc]initWithRootViewController:healthVc];
//    healthVc.title = @"生活";
//    nav1.tabBarItem.image = [UIImage imageNamed:@"tab_1_nor"];
//    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_1_sel"];
    ShoppingHomeController *serverVc = [[ShoppingHomeController alloc] init];
    
    GoToStoreExperiseController *gotoStore = [[GoToStoreExperiseController alloc] init];
    JGangBaseNavController * nav3 = [[JGangBaseNavController alloc]initWithRootViewController:gotoStore];
    JGangBaseNavController * nav2 = [[JGangBaseNavController alloc]initWithRootViewController:serverVc];
//    userTestViewController * testVc = [[userTestViewController alloc]init];
//    JGangBaseNavController * nav2 = [[JGangBaseNavController alloc]initWithRootViewController:testVc];
    gotoStore.title = @"健康商城";
//    nav2.tabBarItem.image = [UIImage imageNamed:@"tab_2_nor"];
//    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_2_sel"];
    nav2.tabBarItem.image = [[UIImage imageNamed:@"three"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"threeSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    serverVc.title = @"周边";
//    nav3.tabBarItem.image = [UIImage imageNamed:@"tab_3_nor"];
//    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_3_sel"];
    
    nav3.tabBarItem.image = [[UIImage imageNamed:@"four"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"fourSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    communityViewController * communityVc = [[communityViewController alloc]init];
    JGangBaseNavController * nav4 = [[JGangBaseNavController alloc]initWithRootViewController:communityVc];
    communityVc.title = @"健康圈";
//    nav4.tabBarItem.image = [UIImage imageNamed:@"tab_4_nor"];
//    nav4.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_4_sel"];
    nav4.tabBarItem.image = [[UIImage imageNamed:@"two"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem.selectedImage = [[UIImage imageNamed:@"twoSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

//    [self setViewControllers:@[nav,nav1,nav2,nav3,nav4]];
    [self setViewControllers:@[nav,nav4,nav2,nav3]];

    [self setSelectedIndex:0];
    self.view.backgroundColor = background_Color;
}

// 设置Tab选择项
- (void) setSelectedTab:(int) nIndex
{
    self.selectedIndex = nIndex;
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)obj;
            [nav popToRootViewControllerAnimated:NO];
        }
    }];
}

#pragma mark -  UITabBarControllerDelegate methods
- (void) tabBarController:(UITabBarController *) tabBarController didSelectViewController:(UIViewController *) viewController {
    NSInteger selectedIndex = self.selectedIndex;
   //广播出去切换了tabBar操作
    if (selectedIndex == 0) {
        [userDefaultManager SetLocalDataString:@"58" key:@"innerRadius"];
        [userDefaultManager SetLocalDataString:@"78" key:@"outerRadius"];
    }else{
        [userDefaultManager SetLocalDataString:@"20" key:@"innerRadius"];
        [userDefaultManager SetLocalDataString:@"25" key:@"outerRadius"];
    }
}


- (BOOL) tabBarController:(UITabBarController *) tabBarController shouldSelectViewController:(UIViewController *) viewController {
    
    UIViewController *tbSelectedController = tabBarController.selectedViewController;
    
    //1.计算即将切换的tab
    int tempIndex = -1;
    NSArray *arrayVC = self.viewControllers;
    
    
    if (self.viewControllers.count) {
        if ([self.viewControllers indexOfObject:viewController] == 3) {
            // 选择了服务
            [JGActivityTools sharedInstance].isServiceModule = YES;
            
        }else {
            // 切换到其他四个模块
            [JGActivityTools sharedInstance].isServiceModule = NO;

            [JGActivityTools switchTabBarAction];
        }
    }
    
    for (int i = 0; i < [arrayVC count]; ++i) {
        if ([viewController isEqual:[arrayVC objectAtIndex:i]]) {
            tempIndex = i;
            break;
        }
    }
    
    if ([tbSelectedController isEqual:viewController]) {
        NSLog(@"tb Select");
        [userDefaultManager SetLocalDataString:@"58" key:@"innerRadius"];
        [userDefaultManager SetLocalDataString:@"78" key:@"outerRadius"];
        
        return NO;
    }
    return YES;
}

@end