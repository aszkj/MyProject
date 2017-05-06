//
//  testchildViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "testchildViewController.h"
#import "PublicInfo.h"
#import "AppDelegate.h"
#import "bodyresultViewController.h"
#import "GlobeObject.h"
#import "JGBlueToothManager.h"
#import "UIViewExt.h"
#import "Util.h"


@interface testchildViewController ()
{
    UIScrollView    *_myScrollView;
    UITextField     *_height_tf,*_weight_tf;
    BOOL            btn_touch;//检测性别按钮点击状态
    float           content_x,content_y;//scrollView的滑动范围
    
    NSDictionary    *userDic;//用户信息字典
    
    JGBlueToothManager *_jgManager;
}


@end

@implementation testchildViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userDic = [kUserDefaults objectForKey:userInfoKey] ;
    _jgManager = [JGBlueToothManager shareInstances] ;
    
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"形体";
    self.navigationItem.titleView = titleLabel;
    RELEASE(titleLabel);
    
    //    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    //增加好点的返回键
    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"backToMain" isLeftItem:YES inResponseObject:self];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    RELEASE(leftBtn);
    RELEASE(leftButton);

    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    //    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    RELEASE(rightBtn);
    RELEASE(rightButton);
    
    btn_touch = YES;
    [self greatUI];
}

- (void)greatUI
{
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = self.view.frame;
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myScrollView];
    
    UILabel * top_lab = [[UILabel alloc]init];
    top_lab.frame = CGRectMake(0, 25, __MainScreen_Width, 20);
    top_lab.text = @"体重指数计算器";
    top_lab.textAlignment = NSTextAlignmentCenter;
    top_lab.font = [UIFont systemFontOfSize:16];
    top_lab.textColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [_myScrollView addSubview:top_lab];

    UIButton * sex_btn = [[UIButton alloc]init];
    sex_btn.frame = CGRectMake(0, 0, 185, 68);
    
    //确认男女
    NSInteger sex = [userDic[@"sex"] integerValue];
    NSString *sexImgName = nil;
    if (_jgManager.userBodyModel.genderType == GenderTypeWoman) {//男
        sexImgName = @"life_boy";
    }else{//
        sexImgName = @"life_girl";
    }
    [sex_btn setBackgroundImage:[UIImage imageNamed:sexImgName] forState:UIControlStateNormal];
    NSNumber *weight =  @(_jgManager.userBodyModel.weight);
    NSNumber *height = @(_jgManager.userBodyModel.height);
    NSArray *valueArr = nil;
    if (weight!= nil && height != nil) {
        
        valueArr = @[weight,height];

    }else{
    
        valueArr = @[@120,@170];
    }
    
    
    //    [sex_btn setBackgroundImage:[UIImage imageNamed:@"life_boy"] forState:UIControlStateNormal];
    sex_btn.tag = 1;
    btn_touch = YES;
    [sex_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sex_btn.center = CGPointMake(__MainScreen_Width/2, top_lab.frame.origin.y+top_lab.frame.size.height+32+68/2);
    [_myScrollView addSubview:sex_btn];
    
    float lab_h = sex_btn.frame.origin.y+sex_btn.frame.size.height;
    float lab_x = (__MainScreen_Width-504/2)/2;
    float lab_spase_y = 12;
//    float lab_spase_x = 10;
    _weight_tf = [[UITextField alloc]init];
    _height_tf = [[UITextField alloc]init];
    NSArray * array = [NSArray arrayWithObjects:@"体重：",@"身高：", nil];
    NSArray * array_tf = [NSArray arrayWithObjects:_weight_tf,_height_tf, nil];
    NSArray * array_pl = [NSArray arrayWithObjects:@"请输入您的体重",@"请输入您的身高", nil];
    NSArray * array_right = [NSArray arrayWithObjects:@"kg",@"cm", nil];
    UIButton * btn2 = [[UIButton alloc]init];
    for (int i = 0; i < 2; i ++) {
        UILabel * lab = [[UILabel alloc]init];
        lab.backgroundColor = [UIColor clearColor];
        lab.frame = CGRectMake(lab_x, lab_h+46+i*(43+lab_spase_y), 60, 43);
        lab.text = [array objectAtIndex:i];
        lab.textColor = [UIColor darkGrayColor];
        [_myScrollView addSubview:lab];

        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(lab_x+lab.frame.size.width-10, lab_h+46+i*(43+lab_spase_y), 209, 43);
        view.backgroundColor = [UIColor whiteColor];
        [_myScrollView addSubview:view];

        
        UILabel * right_lab = [[UILabel alloc]init];
        right_lab.frame = CGRectMake(view.frame.size.width-40, 10, 30, view.frame.size.height-20);
        right_lab.textColor = [UIColor darkGrayColor];
        right_lab.text = [array_right objectAtIndex:i];
        [view addSubview:right_lab];

        
        UITextField * tf = [array_tf objectAtIndex:i];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.frame = CGRectMake(10, 5, view.frame.size.width-40, view.frame.size.height-10);
        if (valueArr != nil) {
            
            tf.text = [valueArr[i] stringValue];
        }else{
            
            tf.placeholder = [array_pl objectAtIndex:i];
        
        }
        
        
        [view addSubview:tf];
        if (i == 1) {
            btn2.frame = CGRectMake(lab.frame.origin.x+5, view.frame.origin.y+view.frame.size.height+35, 504/2, 84/2);
            btn2.backgroundColor = [UIColor colorWithRed:242.0/255 green:169.0/255 blue:84.0/255 alpha:1];
            btn2.layer.cornerRadius = 4;
            btn2.clipsToBounds = YES;
            btn2.tag = 2;
            [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn2.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn2 setTintColor:[UIColor whiteColor]];
            [btn2 setTitle:@"开始计算" forState:UIControlStateNormal];
            [_myScrollView addSubview:btn2];

        }
    }

    
    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, btn2.frame.size.height+btn2.frame.origin.y+100);
    content_x = __MainScreen_Width;
    content_y = __MainScreen_Height+50;
    UITapGestureRecognizer * sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap)];
    //    [sideslipTapGes setNumberOfTapsRequired:1];
    
    [_myScrollView addGestureRecognizer:sideslipTapGes];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


//键盘出现
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    CGFloat upDeta = 0;
    [Util setValueIndiffScreensWithVarary:&upDeta in4s:120 in5s:110 in6s:100 plus:90];
    
    _myScrollView.contentSize = CGSizeMake(content_x,content_y);
    
   [UIView animateWithDuration:0.2 animations:^{
       
       [_myScrollView setContentOffset:CGPointMake(0, upDeta)];
   }];
    
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    _myScrollView.contentSize = CGSizeMake(content_x, __MainScreen_Height);
    [UIView animateWithDuration:0.2 animations:^{
        
        [_myScrollView setContentOffset:CGPointMake(0, 0)];
    }];
    
}


- (void)btnClick:(UIButton *)btn
{
    NSLog(@"btn.tag = %ld",(long)btn.tag);
    if (btn.tag == 1) {
        btn_touch = !btn_touch;
        if (btn_touch) {
            [btn setBackgroundImage:[UIImage imageNamed:@"life_boy"] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"life_girl"] forState:UIControlStateNormal];
        }
    }else if (btn.tag == 2){
//        [self.view endEditing:YES];
        //_height_tf,*_weight_tf
        if (_weight_tf.text.length!=0&&_height_tf.text.length != 0) {
            
            
            float weight = [_weight_tf.text floatValue];
            float height = [_height_tf.text floatValue];
            float bodyResult = weight/(height/100)/(height/100);
            NSLog(@"bodyresult = %.2f",bodyResult);
            BOOL _inputValide = YES;
            if (height < 100 || height > 400 ) {
                _inputValide = NO;
                [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"身高填写不合理,请重新填写"];
            }
            
            if (weight < 10 || weight > 300 ) {
                _inputValide = NO;
                [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"体重填写不合理,请重新填写"];
            }
            if (_inputValide) {
                
                bodyresultViewController * bodyVc = [[bodyresultViewController alloc]init];
                bodyVc.bodyResult = bodyResult;
                if (btn_touch) {
                    bodyVc.sex = @"man";
                    NSLog(@"man");
                }else{
                    bodyVc.sex = @"women";
                    NSLog(@"women");
                }
                [self.navigationController pushViewController:bodyVc animated:YES];
            }

        }else{
             UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请完整输入个人身高体重信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertVc show];

        }
    }
}

- (void)handeTap
{
    [self.view endEditing:YES];
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
