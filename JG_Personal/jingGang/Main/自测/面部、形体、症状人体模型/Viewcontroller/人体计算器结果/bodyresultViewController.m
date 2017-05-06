//
//  bodyresultViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "bodyresultViewController.h"
#import "PublicInfo.h"

@interface bodyresultViewController ()
{
    UIScrollView     *_myscrollView;
}

@end

@implementation bodyresultViewController

- (void)dealloc
{


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.barTintColor = kGetColor(232, 36, 39);
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"检测结果";
    self.navigationItem.titleView = titleLabel;
    //    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
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

- (void)greatUI
{
    _myscrollView = [[UIScrollView alloc]init];
    _myscrollView.frame = self.view.frame;
    _myscrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myscrollView];
    
    float h1 = 17;
    float w1 = 21;
    float h2 = 5;
    float w2 = 5;
    float top_img_y = 80;
    _myscrollView = [[UIScrollView alloc]init];
    _myscrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    _myscrollView.frame = self.view.frame;
    [self.view addSubview:_myscrollView];
    
    UIView * bg_view = [[UIView alloc]init];
    bg_view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
    bg_view.frame = CGRectMake(w1, h1, __MainScreen_Width-2*w1, __MainScreen_Height-2*h1);
    [_myscrollView addSubview:bg_view];

    UIView * top_view = [[UIView alloc]init];
    top_view.frame = CGRectMake(w2, h2, bg_view.frame.size.width-2*w2, bg_view.frame.size.height-2*h2);
    top_view.backgroundColor = [UIColor whiteColor];
    [bg_view addSubview:top_view];

    
    NSArray * img_array = [NSArray arrayWithObjects:@"test_cry",@"test_smile", nil];
    
    UIImageView * top_img = [[UIImageView alloc]init];
    top_img.frame = CGRectMake(0, 0, 62, 62);
    NSLog(@"self.result = %.2f sex = %@",_bodyResult,_sex);
    top_img.center = CGPointMake(self.view.center.x-24, top_img_y);
    [top_view addSubview:top_img];

    
    UILabel * body_result = [[UILabel alloc]init];
    body_result.frame = CGRectMake(0, top_img.frame.origin.y+top_img.frame.size.height+10, top_view.frame.size.width, 20);
    body_result.text = [NSString stringWithFormat:@"%.2f",self.bodyResult];
    body_result.font = [UIFont boldSystemFontOfSize:25];
    body_result.textColor = [UIColor colorWithRed:252.0/255 green:53.0/255 blue:0.0/255 alpha:1];
    body_result.textAlignment = NSTextAlignmentCenter;
    [top_view addSubview:body_result];

    
    UILabel * dic_lab = [[UILabel alloc]init];
    dic_lab.frame = CGRectMake(0, body_result.frame.origin.y+body_result.frame.size.height, top_view.frame.size.width, 20);
    dic_lab.text = @"体重指数";
    dic_lab.font = [UIFont boldSystemFontOfSize:15];
    dic_lab.textColor = [UIColor colorWithRed:252.0/255 green:53.0/255 blue:0.0/255 alpha:1];
    dic_lab.textAlignment = NSTextAlignmentCenter;
    [top_view addSubview:dic_lab];

    
    NSArray * result_array = [NSArray arrayWithObjects:@"您偏瘦，需要更多营养",@"您偏瘦，需要更多营养",@"体重指数正常，继续保持",@"您偏胖，注意锻炼身体",@"您轻度肥胖，要注意饮食了",@"您重度肥胖，赶紧减肥吧", nil];
    UILabel * result_lab = [[UILabel alloc]init];
    result_lab.frame = CGRectMake(0, dic_lab.frame.origin.y+dic_lab.frame.size.height+10, top_view.frame.size.width, 20);
//    result_lab.text = @"合格";
    result_lab.font = [UIFont boldSystemFontOfSize:15];
    result_lab.textColor = [UIColor lightGrayColor];
    result_lab.textAlignment = NSTextAlignmentCenter;
    [top_view addSubview:result_lab];

    if ([self.sex isEqualToString:@"man"] && self.bodyResult>=20 &&self.bodyResult<=25) {
        top_img.image = [UIImage imageNamed:[img_array objectAtIndex:1]];
        result_lab.text = [result_array objectAtIndex:2];
    }else{
        top_img.image = [UIImage imageNamed:[img_array objectAtIndex:0]];
        if (self.bodyResult<20) {
            result_lab.text = [result_array objectAtIndex:0];
        }else if (self.bodyResult >25 && self.bodyResult<=30){
            result_lab.text = [result_array objectAtIndex:3];
        }else if (self.bodyResult>30&&self.bodyResult<35){
            result_lab.text = [result_array objectAtIndex:4];
        }else{
            result_lab.text = [result_array objectAtIndex:5];
        }
    }
    
    UILabel * line_lab = [[UILabel alloc]init];
    line_lab.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    line_lab.frame = CGRectMake(24, result_lab.frame.origin.y+result_lab.frame.size.height+18, top_view.frame.size.width-2*24, 0.5);
    [top_view addSubview:line_lab];

    
    UILabel * last_lab = [[UILabel alloc]init];
    last_lab.frame = CGRectMake(24, line_lab.frame.origin.y+line_lab.frame.size.height+18, top_view.frame.size.width-2*24, 10);
    last_lab.textColor = [UIColor lightGrayColor];
    last_lab.font = [UIFont systemFontOfSize:15];
    last_lab.text = @"男女成人体重指数（BMI）标准";
    [top_view addSubview:last_lab];

    
    UIImageView * last_img = [[UIImageView alloc]init];
    last_img.frame = CGRectMake(0, 0, 211, 146);
    last_img.image = [UIImage imageNamed:@"test_form"];
    last_img.center = CGPointMake(top_view.center.x-10, last_lab.frame.origin.y+last_lab.frame.size.height+90);
    [top_view addSubview:last_img];

}

- (void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
