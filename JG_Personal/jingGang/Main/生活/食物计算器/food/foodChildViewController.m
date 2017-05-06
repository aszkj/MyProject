//
//  foodChildViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "foodChildViewController.h"
#import "PublicInfo.h"

@interface foodChildViewController ()
{
    UIScrollView    *_myScrollView;
}

@end

@implementation foodChildViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"测试结果";
    self.navigationItem.titleView = titleLabel;

    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;


    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    //    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;


    
    [self greatUI];
}

-(void)greatUI
{
    float h1 = 17;
    float w1 = 21;
    float h2 = 5;
    float w2 = 5;
    float top_img_y = 60;
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    _myScrollView.frame = self.view.frame;
    [self.view addSubview:_myScrollView];
    
    UIView * bg_view = [[UIView alloc]init];
    bg_view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
    bg_view.frame = CGRectMake(w1, h1, __MainScreen_Width-2*w1, __MainScreen_Height-2*h1);
    [_myScrollView addSubview:bg_view];

    UIView * top_view = [[UIView alloc]init];
    top_view.frame = CGRectMake(w2, h2, bg_view.frame.size.width-2*w2, bg_view.frame.size.height-2*h2);
    top_view.backgroundColor = [UIColor whiteColor];
    [bg_view addSubview:top_view];

    
    UIImageView * top_img = [[UIImageView alloc]init];
    top_img.image = [UIImage imageNamed:@"life_data"];
    top_img.frame = CGRectMake(0, 0, 55, 55);
    top_img.center = CGPointMake(self.view.center.x-24, top_img_y);
    [top_view addSubview:top_img];

    
    UILabel * kaluli_lab = [[UILabel alloc]init];
    kaluli_lab.frame = CGRectMake(24, top_img.frame.origin.y+top_img.frame.size.height+18, top_view.frame.size.width-2*24, 20);
    kaluli_lab.textAlignment = NSTextAlignmentCenter;
    kaluli_lab.font = [UIFont boldSystemFontOfSize:25];
    kaluli_lab.text = _kaluliStr;
    [top_view addSubview:kaluli_lab];

    
    UILabel * first_lab = [[UILabel alloc]init];
    first_lab.frame = CGRectMake(24, kaluli_lab.frame.origin.y+kaluli_lab.frame.size.height+26, top_view.frame.size.width-2*24, 100);
    first_lab.textColor = [UIColor lightGrayColor];
    first_lab.numberOfLines = 0;
    first_lab.text = @"     以上数值是根据您的标准体重，和您的单位体重所需热量我们为您算出您一天的能量摄入量。";
    [top_view addSubview:first_lab];

    
    UILabel * line_lab = [[UILabel alloc]init];
    line_lab.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    line_lab.frame = CGRectMake(24, first_lab.frame.origin.y+first_lab.frame.size.height+16, top_view.frame.size.width-2*24, 0.5);
    [top_view addSubview:line_lab];


    
    UILabel * last_lab = [[UILabel alloc]init];
    last_lab.frame = CGRectMake(24, line_lab.frame.origin.y+line_lab.frame.size.height+26, top_view.frame.size.width-2*24, 140);
    last_lab.textColor = [UIColor lightGrayColor];
    last_lab.numberOfLines = 0;
    last_lab.text = @"     我们为您估算出的每日所需能量，作为合理安排您的膳食摄入的科学依据，足以保证您的机体正常代谢和日常的学习、工作和生活等活动所需。";
    [top_view addSubview:last_lab];

    
    if (__MainScreen_Height == 480) {
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height+50);
    }
}

- (void)backToMain
{
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
