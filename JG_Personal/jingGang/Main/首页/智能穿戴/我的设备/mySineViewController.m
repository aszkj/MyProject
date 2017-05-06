//
//  mySineViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "mySineViewController.h"
#import "PublicInfo.h"
#import "JGBlueToothManager.h"
#import "GlobeObject.h"

@interface mySineViewController ()
{
    UIScrollView    * _myScrollView;
    NSMutableArray  *_num_lab_array;
    
    JGBlueToothManager *_jgBlueToothManager;
    float spase_x ;
    float spase_y ;
    float width ;
    float height ;
    float x ;
    UIView * midel_view;
    
    int my_sine;
    
    UILabel         *w_lab,*q_lab,*b_lab,*s_lab,*g_lab;
}

@end

@implementation mySineViewController

//static int my_sine;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    int goalStep = [[kUserDefaults objectForKey:kGoalStep] intValue];
////    NSInteger goalStep = _jgBlueToothManager.userBodyModel.goalSteps;
//    
//    
//    my_sine = (int)goalStep;
    
//    self.sine_str = [NSString stringWithFormat:@"%ld",goalStep];
//        [self greatMySine];
}


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
//    NSInteger goalSteps = [self.sine_str integerValue];
    
    _jgBlueToothManager.userBodyModel.goalSteps = my_sine;

    [kUserDefaults setObject:@(my_sine) forKey:kGoalStep];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    spase_x = 5;
    spase_y = 35;
    width = 50;
    height = 70;
    x = (__MainScreen_Width-(width*5+5*4))/2;
    w_lab = [[UILabel alloc]init];
    q_lab = [[UILabel alloc]init];
    b_lab = [[UILabel alloc]init];
    s_lab = [[UILabel alloc]init];
    g_lab = [[UILabel alloc]init];
    _jgBlueToothManager = [JGBlueToothManager shareInstances] ;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.text = @"我的目标";
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
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = self.view.frame;
    _myScrollView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_myScrollView];
    
    int goalStep ;
//    int goalStep = [[kUserDefaults objectForKey:kGoalStep] intValue];
    if (![kUserDefaults objectForKey:kGoalStep]) {
        goalStep = 7000;
    }else{
    
        goalStep = [[kUserDefaults objectForKey:kGoalStep] intValue];
    }
////    int goalStep = (int)_jgBlueToothManager.userBodyModel.goalSteps;
////   NSInteger goalStep = _jgBlueToothManager.userBodyModel.goalSteps;
//    
//    goalStep = 0;
    my_sine = goalStep;
    

    
    [self greatUI];
}

- (void)greatUI
{
    UIButton * top_btn = [[UIButton alloc]init];
    top_btn.tag = 1;
    [top_btn setBackgroundImage:[UIImage imageNamed:@"home_steps_up"] forState:UIControlStateNormal];
    [top_btn setBackgroundImage:[UIImage imageNamed:@"home_steps_up_pressed"] forState:UIControlStateHighlighted];
    top_btn.frame = CGRectMake(0, 0, 30, 30);
    top_btn.center = CGPointMake(__MainScreen_Width/2, 40);
    [top_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_myScrollView addSubview:top_btn];

    
    midel_view = [[UIView alloc]init];
    midel_view.frame = CGRectMake(0, top_btn.frame.origin.y+top_btn.frame.size.height+11, __MainScreen_Width, 140);
    midel_view.backgroundColor = [UIColor whiteColor];
    [_myScrollView addSubview:midel_view];

    UILabel * name_lab = [[UILabel alloc]init];
    name_lab.text = @"设置每天想要实现的目标";
    name_lab.textColor = [UIColor lightGrayColor];
    name_lab.font = [UIFont systemFontOfSize:15];
    name_lab.textAlignment = NSTextAlignmentCenter;
    name_lab.frame = CGRectMake(0, 10, __MainScreen_Width, 15);
    [midel_view addSubview:name_lab];

    
    
    _num_lab_array = [[NSMutableArray alloc]init];
    
    [self greatMySine];
    
    UILabel * down_lab = [[UILabel alloc]init];
    down_lab.frame = CGRectMake(0, midel_view.frame.size.height-25, __MainScreen_Width, 15);
    down_lab.text = @"步";
    down_lab.textAlignment = NSTextAlignmentCenter;
    down_lab.textColor = [UIColor lightGrayColor];
    [midel_view addSubview:down_lab];

    
    UIButton * down_btn = [[UIButton alloc]init];
    down_btn.tag = 2;
    [down_btn setBackgroundImage:[UIImage imageNamed:@"home_steps_down"] forState:UIControlStateNormal];
    [down_btn setBackgroundImage:[UIImage imageNamed:@"home_steps_down_pressed"] forState:UIControlStateHighlighted];
    down_btn.frame = CGRectMake(0, 0, 30, 30);
    down_btn.center = CGPointMake(__MainScreen_Width/2, midel_view.frame.origin.y+midel_view.frame.size.height+31);
    [down_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_myScrollView addSubview:down_btn];

    
    UIView * down_view = [[UIView alloc]init];
    down_view.frame = CGRectMake(0, down_btn.frame.size.height+down_btn.frame.origin.y+60, __MainScreen_Width, 140);
    down_view.backgroundColor = [UIColor whiteColor];
    [_myScrollView addSubview:down_view];

    
    float  btn_width = 60;
    float  btn_y = 19;
    float  btn_x = __MainScreen_Width/4;
    NSArray * btn_name_array = [NSArray arrayWithObjects:@"home_target_01",@"home_target_02",@"home_target_03", nil];
    NSArray * lab_name_array = [NSArray arrayWithObjects:@"活跃分子",@"减肥达人",@"当前情况", nil];
    NSArray * lab_color_array = [NSArray arrayWithObjects:[UIColor colorWithRed:255.0f/255.0f green:179.f/255.0f blue:98.f/255.0f alpha:1.0f],[UIColor colorWithRed:245.f/255.0f green:110.f/255.0f blue:79.f/255.0f alpha:1.0f],[UIColor colorWithRed:90.f/255.0f green:196.f/255.0f blue:241.f/255.0f alpha:1.0f], nil];
    
    NSArray * lab1_name_array = [NSArray arrayWithObjects:@"12000Steps",@"8000Steps",@"5000Steps", nil];
    for (int i = 0; i < 3; i ++) {
        UIButton * btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0, 0, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[btn_name_array objectAtIndex:i]] forState:UIControlStateNormal];
        btn.center = CGPointMake(btn_x*(i+1), btn_y+30);
        if (i == 0) {
             btn.center = CGPointMake(btn_x*(i+1)-20, btn_y+30);
        }else if (i == 2){
             btn.center = CGPointMake(btn_x*(i+1)+20, btn_y+30);
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(sine_btn_click:) forControlEvents:UIControlEventTouchUpInside];
        [down_view addSubview:btn];

        UILabel * lab = [[UILabel alloc]init];
        lab.text = [lab_name_array objectAtIndex:i];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = [lab_color_array objectAtIndex:i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.frame = CGRectMake(__MainScreen_Width/3*i+5, btn.frame.origin.y+btn.frame.size.height+7, __MainScreen_Width/3, 15);
        if (i == 0) {
            lab.frame = CGRectMake(__MainScreen_Width/3*i+10, btn.frame.origin.y+btn.frame.size.height+7, __MainScreen_Width/3, 15);
        }else if (i == 2){
            lab.frame = CGRectMake(__MainScreen_Width/3*i-5, btn.frame.origin.y+btn.frame.size.height+7, __MainScreen_Width/3, 15);
        }
        [down_view addSubview:lab];

        
        UILabel * lab1 = [[UILabel alloc]init];
        lab1.text = [lab1_name_array objectAtIndex:i];
        lab1.font = [UIFont systemFontOfSize:15];
        lab1.textColor = [lab_color_array objectAtIndex:i];
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.frame = CGRectMake(__MainScreen_Width/3*i+5, lab.frame.origin.y+lab.frame.size.height+7, __MainScreen_Width/3, 15);
        if (i == 0) {
            lab1.frame = CGRectMake(__MainScreen_Width/3*i+10, lab.frame.origin.y+lab.frame.size.height+7, __MainScreen_Width/3, 15);
        }else if (i == 2){
            lab1.frame = CGRectMake(__MainScreen_Width/3*i-5, lab.frame.origin.y+lab.frame.size.height+7, __MainScreen_Width/3, 15);
        }
        [down_view addSubview:lab1];

    }
    
    if (__MainScreen_Height == 480) {
        
        down_view.frame = CGRectMake(0, down_btn.frame.size.height+down_btn.frame.origin.y+30, __MainScreen_Width, 140);
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, down_view.frame.origin.y+down_view.frame.size.height+80);
    }
}

-(void)setLabelWithlabel:(UILabel *)label andIntNum:(int)num{

    label.text = [NSString stringWithFormat:@"%d",num];

}

- (void)greatMySine
{
    
    NSString * num_str = [NSString stringWithFormat:@"%d",my_sine];
//    if (my_sine>=10000) {
//        int w = my_sine/10000;my_sine -= 10000*w;
//        w_lab.text = [NSString stringWithFormat:@"%d",w];
//    }else if (my_sine>=1000){
//        int q = my_sine/1000;my_sine -= 1000*q;
//        q_lab.text = [NSString stringWithFormat:@"%d",q];
//    }else if (my_sine>=100){
//        int b = my_sine/100;my_sine -= 100*b;
//        b_lab.text = [NSString stringWithFormat:@"%d",b];
//    }else if (my_sine>=10){
//        int s = my_sine/10;my_sine -= 10*s;
//        s_lab.text = [NSString stringWithFormat:@"%d",s];
//    }else {
//        int g = my_sine;
//        g_lab.text = [NSString stringWithFormat:@"%d",g];
//    }
    int w,q,b,s,g;
    
    if (my_sine >= 10000) {
        w = my_sine / 10000;
        q = (my_sine - w * 10000) / 1000;
    }else if (my_sine >= 1000){
        w = 0;
        q = my_sine / 1000;
    }
    b = s = g = 0;
    [self setLabelWithlabel:w_lab andIntNum:w];
    [self setLabelWithlabel:q_lab andIntNum:q];
    [self setLabelWithlabel:b_lab andIntNum:b];
    [self setLabelWithlabel:s_lab andIntNum:s];
    [self setLabelWithlabel:g_lab andIntNum:g];
    
    
    NSLog(@"w-%@,q-%@,b-%@,s-%@,g-%@",w_lab.text,q_lab.text,b_lab.text,s_lab.text,g_lab.text);
    int num_str_length = num_str.length;
    
    NSArray * array = [NSArray arrayWithObjects:w_lab,q_lab,b_lab,s_lab,g_lab, nil];
    
    for (int i =0; i < 5; i++) {
        UIImageView * img_view = [[UIImageView alloc]init];
        img_view.image = [UIImage imageNamed:@"home_bg_word"];
        img_view.frame = CGRectMake(x+i*(spase_x+width), spase_y, width, height);
        [midel_view addSubview:img_view];

        UILabel * num_lab = [array objectAtIndex:i];
        
        num_lab.frame = img_view.frame;
        num_lab.backgroundColor = [UIColor clearColor];
        num_lab.font = [UIFont systemFontOfSize:36];
        num_lab.textColor = [UIColor whiteColor];
        if (i == 0) {
            if (w_lab.text.length!=0) {
                num_lab.text = w_lab.text;
            }else{
                num_lab.text = @"0";
            }
        }else if (i==1){
            if (q_lab.text.length!=0) {
                num_lab.text = q_lab.text;
            }else{
                num_lab.text = @"0";
            }
        }else if (i==2){
            if (b_lab.text.length!=0) {
                num_lab.text = b_lab.text;
            }else{
                num_lab.text = @"0";
            }
        }else if (i==3){
            if (s_lab.text.length!=0) {
                num_lab.text = s_lab.text;
            }else{
                num_lab.text = @"0";
            }
        }else if (i==4){
            if (g_lab.text.length!=0) {
                num_lab.text = g_lab.text;
            }else{
                num_lab.text = @"0";
            }
        }
        //        num_lab.text = @"0";
        num_lab.textAlignment = NSTextAlignmentCenter;
        [_num_lab_array addObject:num_lab];
        [midel_view addSubview:num_lab];
    }
}

- (void)btnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
//            UILabel * lab = [_num_lab_array objectAtIndex:2];
//            int a = [lab.text intValue];
//            lab.text = [NSString stringWithFormat:@"%d",a+1];
//            if (a>8) {
//                lab.text = @"0";
            NSLog(@"btn=====111");
                UILabel *lab2 = [_num_lab_array objectAtIndex:1];
                int b = [lab2.text intValue];
            b += 1;
//            if (b>9) {
//                b = 0;
//            }
//                lab2.text = [NSString stringWithFormat:@"%d",b];
            UILabel * lab3 = [_num_lab_array objectAtIndex:0];
            int c = [lab3.text intValue];
                if (b>9) {
//                    lab2.text = @"0";
                    b = 0;
//                    UILabel * lab3 = [_num_lab_array objectAtIndex:0];
//                    int c = [lab3.text intValue];
                    c += 1;
                    lab3.text = [NSString stringWithFormat:@"%d",c];
                    if (c>9) {
                        [self showAlertViewWithStr:@"一口吃不了大胖子哦，锻炼要适度"];
                    }
                }
            lab2.text = [NSString stringWithFormat:@"%d",b];
            self.sine_str = [NSString stringWithFormat:@"%d%d000",c,b];
            my_sine = [self.sine_str intValue];
            
            _jgBlueToothManager.userBodyModel.goalSteps = [self.sine_str integerValue];
            
            NSLog(@"最终目标－－－－%@",self.sine_str);
//            }
//            NSLog(@"1---1 lab.text == %@",lab.text);
        }
            break;
        case 2:
        {
//            UILabel * lab = [_num_lab_array objectAtIndex:2];
//            int a = [lab.text intValue];
//            lab.text = [NSString stringWithFormat:@"%d",a-1];
//            if (a<1) {
//                lab.text = @"9";
////                [self showAlertViewWithStr:@"锻炼要有毅力哦，不能再少啦"];
                UILabel *lab2 = [_num_lab_array objectAtIndex:1];
                int b = [lab2.text intValue];
                b -= 1;
//                lab2.text = [NSString stringWithFormat:@"%d",b];
            UILabel * lab3 = [_num_lab_array objectAtIndex:0];
            int c = [lab3.text intValue];
                if (b<1) {
//                    lab2.text = @"9";
                    b = 9;
                    c -= 1;
                    
                    lab3.text = [NSString stringWithFormat:@"%d",c];
                    if (c<0 || b<0) {
                        [self showAlertViewWithStr:@"不要逗小E，负增长的锻炼可不允许"];
                    }
                }
//            }
            lab2.text = [NSString stringWithFormat:@"%d",b];
            self.sine_str = [NSString stringWithFormat:@"%d%d000",c,b];
            my_sine = [self.sine_str intValue];
//            _jgBlueToothManager.userBodySyncModel. = self.sine_str.integerValue;
            _jgBlueToothManager.userBodyModel.goalSteps = self.sine_str.integerValue;
            
            NSLog(@"最终目标－－－－%@",self.sine_str);

        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}




- (void)backToMain
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)showAlertViewWithStr:(NSString *)string
{
    UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertVc show];

}

- (void)sine_btn_click:(UIButton*)btn
{
    if (btn.tag == 0) {
        my_sine = 12000;
        w_lab.text = @"1";
        q_lab.text = @"2";
    }else if (btn.tag == 1){
        my_sine = 8000;
        w_lab.text = @"0";
        q_lab.text = @"8";
    }else if (btn.tag == 2){
        my_sine = 5000;
        w_lab.text = @"0";
        q_lab.text = @"5";
    }
//    [self greatMySine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
