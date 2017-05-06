//
//  devicesViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "devicesViewController.h"
#import "PublicInfo.h"
#import "AppDelegate.h"
#import "devicesChildViewController.h"
#import "historyViewController.h"
#import "clockViewController.h"
#import "deviecesSetViewController.h"
#import "JGBlueToothManager.h"
#import "GlobeObject.h"

@interface devicesViewController (){


}
@property (nonatomic, retain)UINavigationController *navi;


@end

@implementation devicesViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);

#if TARGET_IPHONE_SIMULATOR
    
#else
    //启动蓝牙模块
    [[qBleClient sharedInstance] pubControlSetup];
#endif

    
    
    [self greatUI];
}


- (void)greatUI
{
    NSArray * top_btn_name = [NSArray arrayWithObjects:@"步数",@"睡眠时间",@"闹钟", nil];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        if (i<2) {
            devicesChildViewController *vc = [[devicesChildViewController alloc] init];
            if (i==0) {
                __weak devicesViewController *sel = self;
                vc.backBlock = ^{
                
                    [sel backToMain];
                };
            }
            if (i == 1) {
                vc.view_tag = 1;
                vc.img_name = @"home_sleep";
                vc.midel_name_array = [NSArray arrayWithObjects:@"睡眠时长", @"深睡时长",@"浅睡时长", nil];
                vc.midel_array = [NSArray arrayWithObjects:@"07:01:55", @"04:20:30",@"02:41:26", nil];
            }
            [vcs addObject:vc];
            vc.title = [top_btn_name objectAtIndex:i];

        }else{
            clockViewController *vc = [[clockViewController alloc]init];
            [vcs addObject:vc];
            vc.title = [top_btn_name objectAtIndex:i];

        }
    }
    JYSlideSegmentController *jssc = [[JYSlideSegmentController alloc] initWithViewControllers:vcs];
    self.slideSegmentController = jssc;


    self.slideSegmentController.witch = 3;
    self.slideSegmentController.indicatorInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    self.slideSegmentController.indicator.backgroundColor = status_color;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self.slideSegmentController];
    navi.view.frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height);
    
    [self.slideSegmentController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"智能穿戴";
    self.slideSegmentController.navigationItem.titleView = titleLabel;

    
    //    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.slideSegmentController.navigationItem.leftBarButtonItem = leftButton;
       UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 44.0f)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"home_more_wear"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.slideSegmentController.navigationItem.rightBarButtonItem = rightButton;


    
    self.navi = navi;
    [self.navigationController.view addSubview:self.navi.view];
    
    RELEASE(navi);
}

- (void)backToMain
{
    AppDelegate * app  = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (self.commInFromTest) {//如果从自测页面进入，返回自测页面
        [app gogogoWithTag:2];
        return;
    }
    
    [app gogogoWithTag:0];

//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBtnClick
{
    deviecesSetViewController * setVc = [[deviecesSetViewController alloc]init];
//    setVc.isPopBlock = ^{
//    
//        for (UIViewController *vc in self.slideSegmentController.viewControllers) {
//            if ([vc isMemberOfClass:[devicesChildViewController class]]) {
//                devicesChildViewController *vcChild = (devicesChildViewController *)vc;
//                //标志它是被pop的
//                vcChild.selfIsPopPresented = YES;
//            }
//        }
//    };
    [self.slideSegmentController.navigationController pushViewController:setVc animated:YES];
    
    for (UIViewController *vc in self.slideSegmentController.viewControllers) {
        if ([vc isMemberOfClass:[devicesChildViewController class]]) {
            devicesChildViewController *vcChild = (devicesChildViewController *)vc;
            //标志它是被pop的
            vcChild.selfIsPopPresented = YES;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
