//
//  NoticeManagerController.m
//  Merchants_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "NoticeManagerController.h"
#import "SliderViewManageHelper.h"
#import "OperatorController.h"
#import "PlatformController.h"
#import "DLTabedSlideView.h"

@interface NoticeManagerController ()<DLTabedSlideViewDelegate>
@property (strong,nonatomic) DLTabedSlideView *slideView;
@end

@implementation NoticeManagerController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContent];
}


- (void)setupContent {
    [Util setNavTitleWithTitle:@"公告" ofVC:self];
    [self setDefaultAttribute];
    self.view.backgroundColor = background_Color;
        
    DLTabedSlideView * slideView = [[DLTabedSlideView alloc] initWithFrame:self.view.bounds];
    slideView.delegate = self;
    slideView.baseViewController = self;
    slideView.tabItemNormalColor = [UIColor blackColor];
    slideView.tabItemSelectedColor = status_color;
    slideView.tabbarTrackColor = status_color;
    slideView.tabbarBackgroundImage = [UIImage imageWithCustomColor:[UIColor whiteColor]];
    slideView.tabbarBottomSpacing = 0;
    // 运营商公告
    DLTabedbarItem *operateItem = [DLTabedbarItem itemWithTitle:@"运营商公告" image:nil selectedImage:nil];

    // 云E生平台公告
    DLTabedbarItem *platformItem = [DLTabedbarItem itemWithTitle:@"云E生公告" image:nil selectedImage:nil];

    slideView.tabbarItems = @[operateItem, platformItem];
    self.slideView = slideView;
    [self.slideView buildTabbar];
    self.slideView.selectedIndex = 0;
    [self.view addSubview:slideView];
}


#pragma mark -- DLTabedSlideViewDelegate ----
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return self.slideView.tabbarItems.count;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            OperatorController *operatorController = [[OperatorController alloc] init];
            return operatorController;
        }
            break;
        case 1:
        {
            PlatformController *platformController = [[PlatformController alloc] init];
            return platformController;
        }
            break;
        default:
            return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
