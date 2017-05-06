//
//  foodViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "foodViewController.h"
#import "PublicInfo.h"
#import "foodChildViewController.h"
#import "GlobeObject.h"
#import "JGBlueToothManager.h"

@interface foodViewController ()
{
    BOOL             btn_touch;
    UIScrollView    *_myscrollview;
    UITextField     *_height_tf,*_weight_tf;
    UIView          *_Bomb_box_view;
    UIButton        *_midel_btn;
    NSArray         *_name_array;
    float           content_x,content_y;//scrollView的滑动范围
    NSDictionary    *userDic;
    JGBlueToothManager *_jgBlueManager;
    
}

@end

@implementation foodViewController


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = status_color;

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    userDic = [kUserDefaults objectForKey:userInfoKey] ;
    _jgBlueManager = [JGBlueToothManager shareInstances] ;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"膳食建议";
    self.navigationItem.titleView = titleLabel;
    RELEASE(titleLabel);
    
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

    
    self.navigationController.navigationBar.tintColor = status_color;
    [self greatUI];
}



- (void)greatUI
{
    _myscrollview = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _myscrollview.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myscrollview];
    NSLog(@"12313---1313");
    UILabel * top_lab = [[UILabel alloc]init];
    top_lab.frame = CGRectMake(0, 25, __MainScreen_Width, 20);
    top_lab.text = @"每日摄取能量计算";
    top_lab.textAlignment = NSTextAlignmentCenter;
    top_lab.font = [UIFont systemFontOfSize:16];
    top_lab.textColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [_myscrollview addSubview:top_lab];

    UIButton * sex_btn = [[UIButton alloc]init];
    sex_btn.frame = CGRectMake(0, 0, 185, 68);
    
    
    //确认男女
    NSInteger sex = [userDic[@"sex"] integerValue];
    NSString *sexImgName = nil;
    if (_jgBlueManager.userBodyModel.genderType == GenderTypeWoman) {//男
        sexImgName = @"life_boy";
    }else{//
        sexImgName = @"life_girl";
    }
    
    [sex_btn setBackgroundImage:[UIImage imageNamed:sexImgName] forState:UIControlStateNormal];
    NSNumber *weight = @(_jgBlueManager.userBodyModel.weight) ;
    NSNumber *height = @(_jgBlueManager.userBodyModel.height) ;
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
    [_myscrollview addSubview:sex_btn];
    
    float lab_h = sex_btn.frame.origin.y+sex_btn.frame.size.height;
    float lab_x = (__MainScreen_Width-504/2)/2;
    float lab_spase_y = 12;
//    float lab_spase_x = 10;
    _weight_tf = [[UITextField alloc]init];
    _weight_tf.keyboardType = UIKeyboardTypeNumberPad;
    _height_tf = [[UITextField alloc]init];
    _height_tf.keyboardType = UIKeyboardTypeNumberPad;
    NSArray * array = [NSArray arrayWithObjects:@"体重：",@"身高：", nil];
    NSArray * array_tf = [NSArray arrayWithObjects:_weight_tf,_height_tf, nil];
    NSArray * array_pl = [NSArray arrayWithObjects:@"请输入您的体重",@"请输入您的身高", nil];
    NSArray * array_right = [NSArray arrayWithObjects:@"kg",@"cm", nil];
    UIImageView * img = [[UIImageView alloc]init];//劳动强度图标
    UILabel * img_lab = [[UILabel alloc]init];//劳动强度
    for (int i = 0; i < 2; i ++) {
        UILabel * lab = [[UILabel alloc]init];
        lab.backgroundColor = [UIColor clearColor];
        lab.frame = CGRectMake(lab_x, lab_h+46+i*(43+lab_spase_y), 60, 43);
        lab.text = [array objectAtIndex:i];
        lab.textColor = [UIColor darkGrayColor];
        [_myscrollview addSubview:lab];

        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(lab_x+lab.frame.size.width-10, lab_h+46+i*(43+lab_spase_y), 209, 43);
        view.backgroundColor = [UIColor whiteColor];
        [_myscrollview addSubview:view];

        
        UILabel * right_lab = [[UILabel alloc]init];
        right_lab.frame = CGRectMake(view.frame.size.width-40, 10, 30, view.frame.size.height-20);
        right_lab.textColor = [UIColor darkGrayColor];
        right_lab.text = [array_right objectAtIndex:i];
        [view addSubview:right_lab];

        
        UITextField * tf = [array_tf objectAtIndex:i];
        tf.frame = CGRectMake(10, 5, view.frame.size.width-40, view.frame.size.height-10);
//        tf.placeholder = [array_pl objectAtIndex:i];
        
        if (valueArr != nil) {
            
            tf.text = [valueArr[i] stringValue];
        }else{
            
            tf.placeholder = [array_pl objectAtIndex:i];
            
        }

        
        [view addSubview:tf];
        if (i == 1) {

            img.image = [UIImage imageNamed:@"life_labor"];
            img.frame = CGRectMake(lab.frame.origin.x+2, view.frame.origin.y+view.frame.size.height+31, 14, 13);
            [_myscrollview addSubview:img];


            img_lab.frame = CGRectMake(img.frame.size.width+img.frame.origin.x+5, img.frame.origin.y+3, 200, 10);
            img_lab.text = @"劳动强度";
            img_lab.textColor = [UIColor lightGrayColor];
            img_lab.font = [UIFont systemFontOfSize:13];
            [_myscrollview addSubview:img_lab];

        }
    }
    
    _midel_btn = [[UIButton alloc]init];
    _midel_btn.frame = CGRectMake(img.frame.origin.x, img.frame.origin.y+img.frame.size.height+8, 504/2, 84/2);
    _midel_btn.backgroundColor = [UIColor colorWithRed:89.0/255 green:122.0/255 blue:150.0/255 alpha:1];
    _midel_btn.layer.cornerRadius = 4;
    _midel_btn.clipsToBounds = YES;
    _midel_btn.tag = 2;
    _midel_btn.titleLabel.numberOfLines = 0;
    _midel_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _midel_btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_midel_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_midel_btn setTintColor:[UIColor whiteColor]];
    [_midel_btn setTitle:@"轻体力劳动(白领 老师 售票员 学生)" forState:UIControlStateNormal];
    [_myscrollview addSubview:_midel_btn];
    
    UIImageView * img2 = [[UIImageView alloc]init];
    img2.image = [UIImage imageNamed:@"life_arr_down"];
    img2.frame = CGRectMake(504/2-15, 84/4, 7, 4);
    [_midel_btn addSubview:img2];

    
    UILabel * line_lab = [[UILabel alloc]init];
    line_lab.frame = CGRectMake(img.frame.origin.x, _midel_btn.frame.origin.y+_midel_btn.frame.size.height+18, 504/2, 0.5);
    line_lab.backgroundColor = [UIColor lightGrayColor];
    [_myscrollview addSubview:line_lab];

    
    UIButton * btn2 = [[UIButton alloc]init];
    btn2.frame = CGRectMake(img.frame.origin.x, _midel_btn.frame.origin.y+_midel_btn.frame.size.height+35, 504/2, 84/2);
    btn2.backgroundColor = [UIColor colorWithRed:242.0/255 green:169.0/255 blue:84.0/255 alpha:1];
    btn2.layer.cornerRadius = 4;
    btn2.clipsToBounds = YES;
    btn2.tag = 3;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn2 setTintColor:[UIColor whiteColor]];
    [btn2 setTitle:@"开始计算" forState:UIControlStateNormal];
    [_myscrollview addSubview:btn2];

    _myscrollview.contentSize = CGSizeMake(__MainScreen_Width, btn2.frame.size.height+btn2.frame.origin.y+100);
    content_x = __MainScreen_Width;
    content_y = btn2.frame.size.height+btn2.frame.origin.y+100;
    UITapGestureRecognizer * sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap)];
//    [sideslipTapGes setNumberOfTapsRequired:1];
    
    [_myscrollview addGestureRecognizer:sideslipTapGes];
    
    _Bomb_box_view = [[UIView alloc]init];
    _Bomb_box_view.layer.cornerRadius = 4;
    _Bomb_box_view.clipsToBounds = YES;
    _Bomb_box_view.frame = CGRectMake(0, 0, 540/2, 540/2);
    _Bomb_box_view.center = CGPointMake(__MainScreen_Width + 540/4, 240);
    _Bomb_box_view.backgroundColor = [UIColor whiteColor];
    float spase_one = 49;
    float spase_two = 42;
    _name_array = [NSArray arrayWithObjects:@"请选择",@"卧床",@"轻体力劳动(白领 老师 售票员 学生)",@"中体力劳动(工人 司机 快递员 清洁工 IT人士)",@"重体力劳动(农民 建筑工 搬运工 舞蹈员)", nil] ;
    for (int i = 0; i < 5; i ++) {
        UILabel * line_lab = [[UILabel alloc]init];
        line_lab.frame = CGRectMake(0, spase_one+i*spase_two, 540/2, 0.5);
        line_lab.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [_Bomb_box_view addSubview:line_lab];

        UIButton * line_btn = [[UIButton alloc]init];
        line_btn.frame = CGRectMake(0, 7+i*spase_two, 540/2, spase_two);
        [line_btn setTitle:[_name_array objectAtIndex:i] forState:UIControlStateNormal];\
        [line_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        line_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [line_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        line_btn.tag = i + 500;
        if (i == 0) {
            line_btn.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        [_Bomb_box_view addSubview:line_btn];

        if (i == 4) {
            UIButton * line_btn2 = [[UIButton alloc]init];
            line_btn2.frame = CGRectMake(0, 10+5*spase_two, 540/2, spase_two);
            [line_btn2 setTitle:@"取消" forState:UIControlStateNormal];
            [line_btn2 setTitleColor:[UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1] forState:UIControlStateNormal];
            line_btn2.tag = 505;
            line_btn2.titleLabel.font = [UIFont systemFontOfSize:17];
            [line_btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_Bomb_box_view addSubview:line_btn2];

        }
    }
    [_myscrollview addSubview:_Bomb_box_view];
    _Bomb_box_view.hidden = YES;
//    _Bomb_box_view.frame = CGRectMake(0, 0, 1, 1);
//    _Bomb_box_view.center = CGPointMake(self.view.center.x, 240);
    
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
    
    _myscrollview.contentSize = CGSizeMake(content_x,content_y);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [_myscrollview setContentOffset:CGPointMake(0, upDeta)];
    }];
    
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    _myscrollview.contentSize = CGSizeMake(content_x, __MainScreen_Height);
    [UIView animateWithDuration:0.2 animations:^{
        
        [_myscrollview setContentOffset:CGPointMake(0, 0)];
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
        _Bomb_box_view.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
//            _Bomb_box_view.frame = CGRectMake(0, 0, 540/2, 540/2);
            _Bomb_box_view.center = CGPointMake(__MainScreen_Width / 2, 240);
        }];
    }else if (btn.tag == 3){
        NSLog(@"height = %@,weight = %@",_height_tf.text,_weight_tf.text);
        if (_weight_tf.text.length > 0 && _height_tf.text.length >0 ) {
            
            float weight = [_weight_tf.text floatValue];
            float height = [_height_tf.text floatValue];
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
                
                [self calculate];
            }
            
        }else{
            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"资料未填写完整，请补充完整"];
            
        }
        
    }else if (btn.tag>500&&btn.tag<505 ){
        [_midel_btn setTitle:[_name_array objectAtIndex:btn.tag-500] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
//            _Bomb_box_view.frame = CGRectMake(0, 0, 1, 1);
            _Bomb_box_view.center = CGPointMake(self.view.center.x,240);
        } completion:^(BOOL finished) {
            _Bomb_box_view.hidden = YES;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
//            _Bomb_box_view.frame = CGRectMake(0, 0, 1, 1);
            _Bomb_box_view.center = CGPointMake(__MainScreen_Width + 540/4, 240);//CGPointMake(self.view.center.x, 240);
        } completion:^(BOOL finished) {
            _Bomb_box_view.hidden = YES;
        }];
    }
}

- (void)handeTap
{
    CGSize myScrollViewSize = _myscrollview.contentSize;
    [self.view endEditing:YES];
    _myscrollview.contentSize = myScrollViewSize;
}

- (void)backToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)calculate{
    float tiZhong = [_weight_tf.text integerValue];
    float shengaGao = [_height_tf.text integerValue];
    float biaoZhunTiZhong = shengaGao - 105;//标准体重
    float tiZhongZhiShu =  tiZhong/(shengaGao/100)/(shengaGao/100);//体重指数
    TiZhongDengJi tiZhongDengJi = TiZhongDengJiZhengChang;//体重等级
    if(btn_touch){
        if (tiZhongZhiShu < 20) {
            tiZhongDengJi = TiZhongDengJiPianShou;
        }else if (tiZhongZhiShu < 25 && tiZhongZhiShu >= 20){
            tiZhongDengJi = TiZhongDengJiZhengChang;
        }else if (tiZhongZhiShu < 30 && tiZhongZhiShu >= 25){
            tiZhongDengJi = TiZhongDengJiPianPang;
        }else if (tiZhongZhiShu < 35 && tiZhongZhiShu >= 30){
            tiZhongDengJi = TiZhongDengJiQingDuFeiPang;
        }else if (tiZhongZhiShu > 35){
            tiZhongDengJi = TiZhongDengJiZhongDuFeiPang;
        }
    }else{
        if (tiZhongZhiShu < 19) {
            tiZhongDengJi = TiZhongDengJiPianShou;
        }else if (tiZhongZhiShu < 24 && tiZhongZhiShu >= 19){
            tiZhongDengJi = TiZhongDengJiZhengChang;
        }else if (tiZhongZhiShu < 29 && tiZhongZhiShu >= 24){
            tiZhongDengJi = TiZhongDengJiPianPang;
        }else if (tiZhongZhiShu < 34 && tiZhongZhiShu >= 29){
            tiZhongDengJi = TiZhongDengJiQingDuFeiPang;
        }else if (tiZhongZhiShu > 34){
            tiZhongDengJi = TiZhongDengJiZhongDuFeiPang;
        }
    }
    NSInteger danWeiTiZhongSuoXuReLiang = 0;
    NSInteger selectNum = [_name_array indexOfObject:_midel_btn.titleLabel.text];
    switch (selectNum) {
        case 1:
        {
            switch (tiZhongDengJi) {
                case TiZhongDengJiPianShou:
                    danWeiTiZhongSuoXuReLiang = 25;
                    break;
                case TiZhongDengJiZhengChang:
                case TiZhongDengJiPianPang:
                    danWeiTiZhongSuoXuReLiang = 20;
                    break;
                case TiZhongDengJiQingDuFeiPang:
                case TiZhongDengJiZhongDuFeiPang:
                    danWeiTiZhongSuoXuReLiang = 15;
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
            switch (tiZhongDengJi) {
                case TiZhongDengJiPianShou:
                    danWeiTiZhongSuoXuReLiang = 35;
                    break;
                case TiZhongDengJiZhengChang:
                case TiZhongDengJiPianPang:
                    danWeiTiZhongSuoXuReLiang = 30;
                    break;
                case TiZhongDengJiQingDuFeiPang:
                case TiZhongDengJiZhongDuFeiPang:
                    danWeiTiZhongSuoXuReLiang = 25;
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch (tiZhongDengJi) {
                case TiZhongDengJiPianShou:
                    danWeiTiZhongSuoXuReLiang = 40;
                    break;
                case TiZhongDengJiZhengChang:
                case TiZhongDengJiPianPang:
                    danWeiTiZhongSuoXuReLiang = 35;
                    break;
                case TiZhongDengJiQingDuFeiPang:
                case TiZhongDengJiZhongDuFeiPang:
                    danWeiTiZhongSuoXuReLiang = 30;
                    break;
                default:
                    break;
            }
            break;
        case 4:
            switch (tiZhongDengJi) {
                case TiZhongDengJiPianShou:
                    danWeiTiZhongSuoXuReLiang = 50;
                    break;
                case TiZhongDengJiZhengChang:
                case TiZhongDengJiPianPang:
                    danWeiTiZhongSuoXuReLiang = 40;
                    break;
                case TiZhongDengJiQingDuFeiPang:
                case TiZhongDengJiZhongDuFeiPang:
                    danWeiTiZhongSuoXuReLiang = 35;
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    float kaluliStr = danWeiTiZhongSuoXuReLiang * biaoZhunTiZhong;
    foodChildViewController * foodChildVc = [[foodChildViewController alloc]init];
    foodChildVc.kaluliStr = [NSString stringWithFormat:@"%ld卡",(long)kaluliStr];
    [self.navigationController pushViewController:foodChildVc animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
