//
//  SliderViewManageHelper.m
//  Merchants_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "SliderViewManageHelper.h"
#import "DLTabedSlideView.h"
#import "OperatorController.h"
#import "PlatformController.h"


@interface SliderViewManageHelper ()<DLTabedSlideViewDelegate>

@property (strong,nonatomic) NSArray *itemTitles;

@end

@implementation SliderViewManageHelper


- (instancetype)initWithController:(UIViewController *)controller itemTitles:(NSArray *)itemTitles selectedIndex:(NSInteger)selectedIndex {
    if (self = [super init]) {
        DLTabedSlideView *slideView = [[DLTabedSlideView alloc] initWithFrame:controller.view.bounds];
        slideView.baseViewController = controller;
        slideView.delegate = self;
        slideView.tabItemNormalColor = [UIColor blackColor];
        slideView.tabItemSelectedColor = status_color;
        slideView.tabbarTrackColor = status_color;
        slideView.tabbarBackgroundImage = [UIImage imageWithCustomColor:[UIColor whiteColor]];
        slideView.tabbarBottomSpacing = 3;
        NSMutableArray *mutableItems = [NSMutableArray array];
        
        for (NSString *itemTitle in itemTitles) {
            DLTabedbarItem *barItem = [DLTabedbarItem itemWithTitle:itemTitle image:nil selectedImage:nil];
            [mutableItems addObject:barItem];            
        }
        slideView.tabbarItems = [NSArray arrayWithArray:mutableItems];
        slideView.selectedIndex = selectedIndex;
        [slideView buildTabbar];

        self.itemTitles = itemTitles;
        [controller.view addSubview:slideView];
    }
    return self;
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return self.itemTitles.count;
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

@end
