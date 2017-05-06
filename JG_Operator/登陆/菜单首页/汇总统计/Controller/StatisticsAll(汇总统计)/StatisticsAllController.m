//
//  StatisticsAllController.m
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/10/30.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "StatisticsAllController.h"
#import "ConnectionStatisticsViewController.h"
#import "IncomeStatisticsViewController.h"
@interface StatisticsAllController ()<DLTabedSlideViewDelegate>

@end

@implementation StatisticsAllController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private
- (void)loadUI
{
    
    self.navigationItem.title = @"汇总统计";
    self.tabedSlideView.delegate = self;
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = KColorText59C4F0;
    self.tabedSlideView.tabbarTrackColor = KColorText59C4F0;
    self.tabedSlideView.tabbarBottomSpacing = -7;
    self.tabedSlideView.tabbarHeight = 40.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"收益统计" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"关系统计" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
}

#pragma mark - Delegate
#pragma mark - DLTabedSlideViewDelegate
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 2;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            
            IncomeStatisticsViewController *ctrl = [[IncomeStatisticsViewController alloc] init];
            return ctrl;
        }
        case 1:
        {
            ConnectionStatisticsViewController *ctrl = [[ConnectionStatisticsViewController alloc] init];
            return ctrl;
        }

            
        default:
            return nil;
    }
}
- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index
{
    NSLog(@"点击了%ld",(long)index);

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
