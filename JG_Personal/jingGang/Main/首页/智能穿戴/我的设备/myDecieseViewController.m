//
//  myDecieseViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "myDecieseViewController.h"
#import "PublicInfo.h"
#import "mydevieseViewController.h"
#import "JGBlueToothManager.h"
#import "UIButton+Block.h"
#import "AppDelegate.h"
#import "Util.h"
#import "UIButton+Block.h"

@interface myDecieseViewController (){

    JGBlueToothManager *_jgBlueMg;
    UIView *abge_bg;
}

@end

@implementation myDecieseViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
    
    abge_bg =[[UIView alloc]initWithFrame:CGRectMake(0, -30, __MainScreen_Width, 30)];
    
    abge_bg.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    // abge_bg.backgroundColor =[UIColor redColor];
    [self.view addSubview:abge_bg];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    abge_bg.hidden = YES;
    _jgBlueMg = [JGBlueToothManager shareInstances];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.text = @"我的设备";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    RELEASE(titleLabel);
    
    //    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    RELEASE(leftBtn);
    RELEASE(leftButton);
    
    
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 44.0f)];
    //    [rightBtn setBackgroundImage:[UIImage imageNamed:@"home_add"] forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    RELEASE(rightBtn);
    RELEASE(rightButton);
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    
    WEAK_SELF;
    if (_jgBlueMg.bangedPerialUUID) {
        
        [weak_self greatUI];
        
    }else{
    
        [weak_self greatUIwithNo];
    }
    
    
}

- (void)greatUI
{
    UILabel * lab = [[UILabel alloc]init];
    lab.textAlignment = NSTextAlignmentCenter;
    
    if (_jgBlueMg.bangedPerialID) {
        
        lab.text = _jgBlueMg.bangedPerialID;
    }else{
        lab.text = @"还未同步参数";
    }
    
    lab.frame = CGRectMake(0, 10, __MainScreen_Width, 50);
    lab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lab];

    
    UIButton * btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(40, lab.frame.origin.x+lab.frame.size.height+40, __MainScreen_Width-80, 40);
    btn.layer.cornerRadius = 6;
    btn.clipsToBounds = YES;
    btn.backgroundColor = color_registBtn_1;
    [btn setTitle:@"解绑" forState:UIControlStateNormal];
    [btn addActionHandler:^(NSInteger tag) {
        
        [_jgBlueMg clearBanded];
        //标志刚刚解绑
        _jgBlueMg.isJustNowUnbangded = YES;
        
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"解绑之后如需切换设备，请先重启应用"];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [self.view addSubview:btn];

}

- (void)greatUIwithNo
{
    
    
    UIImageView * imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"home_brace"];
    imgView.frame = CGRectMake(0, 0, 60, 60);
    imgView.center = CGPointMake(__MainScreen_Width/2, __MainScreen_Height/3);
    [self.view addSubview:imgView];
    
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.textColor = [UIColor lightGrayColor];
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.text = @"您还未绑定设备，请绑定设备";
    lab1.frame = CGRectMake(0, imgView.frame.size.height+imgView.frame.origin.y+17, __MainScreen_Width, 15);
    [self.view addSubview:lab1];
    
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.textColor = [UIColor lightGrayColor];
    lab2.textAlignment = NSTextAlignmentCenter;
//    lab2.text = @"点击绑定";
    lab2.frame = CGRectMake(0, lab1.frame.size.height+lab1.frame.origin.y+10, __MainScreen_Width, 15);
    [self.view addSubview:lab2];
    
    UIButton * btn = [[UIButton alloc]init];
    btn.frame = lab2.frame;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *unbandedBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    unbandedBtn.alpha = 0.1;
    [self.view addSubview:unbandedBtn];
    [unbandedBtn addActionHandler:^(NSInteger tag) {
        
        [self btnClick];
    }];
    
    RELEASE(imgView);
    RELEASE(lab1);
    RELEASE(lab2);
    RELEASE(btn);
}

- (void)backToMain
{
    if ([self.keyStr isEqualToString:@"individualVC"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
    
    
}

- (void)btnClick
{
    mydevieseViewController * mydevieseVc = [[mydevieseViewController alloc]init];
    if (self.keyStr.length == 0) {
        mydevieseVc.keyStr = @"setting";
    }else{
        mydevieseVc.keyStr = @"individualVC";
    }
    [self.navigationController pushViewController:mydevieseVc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
