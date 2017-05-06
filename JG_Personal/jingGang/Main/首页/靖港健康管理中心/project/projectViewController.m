//
//  projectViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "projectViewController.h"
#import "PublicInfo.h"
#import "AppDelegate.h"
#import "sunViewController.h"
#import "ZhengZhuangListVC.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
@interface projectViewController ()
{
    VApiManager  * _vapiManager;
    UIView * topView;
}

@end

@implementation projectViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    topView.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    topView.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, -__StatusScreen_Height, __MainScreen_Width, __Other_Height)];
    topView.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    topView.frame = CGRectMake(0, -__StatusScreen_Height, __MainScreen_Width, __Other_Height+1);
    [self.navigationController.navigationBar addSubview:topView];


    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(15.0f, 21.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.leftBarButtonItem = leftButton;
    [topView addSubview:leftBtn];


    
    [self greatUI];
  
    
    
}

- (void)greatUI
{
    UIImageView * topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 236/2, 116/2)];
    topImg.image = [UIImage imageNamed:@"logoeee"];
    topImg.center = CGPointMake(__MainScreen_Width/2, 60+__Other_Height);
    [self.view addSubview:topImg];

    UILabel * dis_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, topImg.frame.origin.y+topImg.frame.size.height+8, __MainScreen_Width, 15)];
    dis_lab.font = [UIFont systemFontOfSize:16];
    dis_lab.textAlignment = NSTextAlignmentCenter;
    dis_lab.text = @"静港健康管理中心";
    dis_lab.textColor = [UIColor whiteColor];
    [self.view addSubview:dis_lab];

    UILabel * dis_lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, dis_lab.frame.origin.y+dis_lab.frame.size.height+8, __MainScreen_Width, 15)];
    dis_lab2.textColor = [UIColor whiteColor];
    dis_lab2.font = [UIFont systemFontOfSize:16];
    dis_lab2.textAlignment = NSTextAlignmentCenter;
    dis_lab2.text = @"项目检索";
    [self.view addSubview:dis_lab2];

    
    float btn_spase = 11;
    float btn_x_spase = 60;
    float btn_F_y = dis_lab2.frame.origin.y+dis_lab2.frame.size.height+20;
    float btn_width = __MainScreen_Width-2*btn_x_spase;
    float btn_height = 35;
    
    NSArray * name_arr = [NSArray arrayWithObjects:@"健康检测评估体系",@"诊疗体系",@"健康管理服务体系", nil];
    for (int i = 0; i<3; i ++) {
        UIButton * btn = [[UIButton alloc]init];
        btn.tag = i + 40;
        btn.frame = CGRectMake(btn_x_spase, btn_F_y+i*(btn_height+btn_spase), btn_width, btn_height);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_bgbg"] forState:UIControlStateNormal];
        [btn setTitle:[name_arr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:122.0/255 green:157.0/255 blue:173.0/255 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:btn];

        if (i == 2) {
            UIImageView * down_img = [[UIImageView alloc]init];
            down_img.image = [UIImage imageNamed:@"iconfont-iconyezi"];
            down_img.frame = CGRectMake(25, btn.frame.size.height+btn.frame.origin.y+40, __MainScreen_Width-25, 150);
            [self.view addSubview:down_img];

        }
    }
    
}

static int num_id ;
- (void)btnClick:(UIButton *)btn
{
    NSLog(@"btn.tag = %ld",(long)btn.tag);
    //40/41/42
    num_id = (int)btn.tag;
    long  ID = 0 ;
    switch (num_id) {
        case 40:
            ID  = num_id;
            break;
        case 41:
           ID  = num_id;
            break;
        case 42:
            ID  = num_id;
            break;
            
        default:
            break;
    }
    
    ZhengZhuangListVC *zhengZhuangListVC = [[ZhengZhuangListVC alloc] init];
    zhengZhuangListVC.fen_lie_ID = ID ;
    zhengZhuangListVC.isJingGang = YES;
    zhengZhuangListVC.isOKCLick = 1;
    zhengZhuangListVC.comminType  = FACE_CLICK_COMIN;
    [self.navigationController pushViewController:zhengZhuangListVC animated:YES];
  
    
    
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
