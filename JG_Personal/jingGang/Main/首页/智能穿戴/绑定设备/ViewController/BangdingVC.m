//
//  BangdingVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BangdingVC.h"
#import "PublicInfo.h"
#import "JGBlueToothManager.h"
#import "GlobeObject.h"
#import "devicesViewController.h"
#import "devicesChildViewController.h"
#import "clockViewController.h"
#import "JYSlideSegmentController.h"

#define R 47.5//旋转图片的半径
#define NAV_Height 64
@interface BangdingVC (){

    UIButton            * button;
    float               top_img_h ;
    UIImageView         * top_img2;
    UIImageView         * top_img;
    NSTimer             * timer;
    
    UILabel             *_mylab;
    
    float               x0,y0;
    
    UILabel * lab;

}

@end

@implementation BangdingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeTop;

    self.view.backgroundColor = [UIColor colorWithRed:63.0/255 green:153.0/255 blue:191.0/255
                                                alpha:1];
    top_img_h = 100;
    if (__MainScreen_Height == 480) {
        top_img_h = 100;
    }

    
    button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:@"home_bluetooth"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, __MainScreen_Height / 3.0, 100, 100);
    button.center = CGPointMake(__MainScreen_Width/2, __MainScreen_Height / 3.0);
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    top_img2 =[[UIImageView alloc]init];
    top_img2.image = [UIImage imageNamed:@"home_run1"];
    top_img2.frame = CGRectMake(0, 0, 5, 5);
    top_img2.center = CGPointMake(__MainScreen_Width/2, top_img_h);
    top_img2.hidden = YES;
    [self.view addSubview:top_img2];

    
    

//    top_img =[[UIImageView alloc]init];
//    top_img.image = [UIImage imageNamed:@"home_bluetooth"];
//    top_img.frame = CGRectMake(0, 0, 100, 100);
//    top_img.center = CGPointMake(__MainScreen_Width/2, top_img_h);




    lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(0, button.frame.origin.y+button.frame.size.height+16, __MainScreen_Width, 15);
    lab.text = @"正在绑定";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [self.view addSubview:lab];


    UILabel * lab2 = [[UILabel alloc]init];
    lab2.textColor = [UIColor whiteColor];
    lab2.text = @"该过程大概需要10～40秒";
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.frame = CGRectMake(0, lab.frame.size.height+lab.frame.origin.y+35, __MainScreen_Width, 15);
    [self.view addSubview:lab2];


    UILabel * lab3 = [[UILabel alloc]init];
    lab3.textColor = [UIColor whiteColor];
    lab3.text = @"请耐心等候";
    lab3.textAlignment = NSTextAlignmentCenter;
    lab3.frame = CGRectMake(0, lab2.frame.size.height+lab2.frame.origin.y+12, __MainScreen_Width, 15);
    [self.view addSubview:lab3];


    UIButton * cancel_btn = [[UIButton alloc]init];
    cancel_btn.frame = CGRectMake(0, 0, 86, 41);
    cancel_btn.center = CGPointMake(__MainScreen_Width/2, __MainScreen_Height-80);
    [cancel_btn setBackgroundImage:[UIImage imageNamed:@"home_but_tem"] forState:UIControlStateNormal];
    [cancel_btn setBackgroundImage:[UIImage imageNamed:@"home_but_tem_pressed"] forState:UIControlStateHighlighted];
    [cancel_btn setTitle:@"暂不绑定" forState:UIControlStateNormal];
    [cancel_btn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    [cancel_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel_btn setTitleColor:[UIColor colorWithRed:63.0/255 green:153.0/255 blue:191.0/255 alpha:1] forState:UIControlStateHighlighted];
    [self.view addSubview:cancel_btn];


    timer =  [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(loop) userInfo:nil repeats:YES];
    
    //开始绑定设备,即首次连接该设备
    if (self.needBandePerial != nil) {
        [[JGBlueToothManager shareInstances] connectSpecifiedPerial:self.needBandePerial connectResult:^(BOOL connectSuccess) {
            if (connectSuccess) {//首次绑定成功
                lab.text = @"绑定成功!";
            }
            JGBlueToothManager *jgb = [JGBlueToothManager shareInstances];
//            jgb.isFirstConnect = YES;
            jgb.connectTimeState = FirstConnectState;
            //第一次绑定，，同步下参数
            [jgb syncParamater:^(BOOL success) {
                
                //将要同步状态
//                jgb.needToSyncState = NeededSyncState;
                [self performSelector:@selector(backToRingPage) withObject:nil afterDelay:1.0];
            }];
//            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
    }
}




-(void)backToRingPage{
    
//    JYSlideSegmentController *backRootVC = nil;
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//        
////        NSLog(@"vcClass-----%@",NSStringFromClass([vc class]));
//        if ([vc isMemberOfClass:[JYSlideSegmentController class]]) {
//            backRootVC = (JYSlideSegmentController *)vc;
//            break;
//        }
//    }
//    
//    [self.navigationController popToViewController:backRootVC animated:YES];
    
//     [self.navigationController popToRootViewControllerAnimated:YES];
    
//    
//    if (iOS8) {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        if (self.backBlock != nil) {
//            self.backBlock();
//        }
//        
//        return;
//    }
    
    if (iOS7) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];

    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        if (self.backBlock != nil) {
            self.backBlock();
        }
        
        return;

    }
    
    
    
    
}//返回手环页


float angle2=0;

-(void)loop
{
    x0 = button.center.x;
    y0= button.center.y;
    
    CGPoint sunPoint = CGPointMake(x0, y0);
    CGPoint point  = top_img2.center;
    
    
    button.center = sunPoint;
    
    int x=x0+R*sin(angle2*3.1415/180);
    int y=y0-R*cos(angle2*3.1415/180);
    
    angle2+=5;
    
    if (angle2 >=360) {
        
        angle2 =0;
    }
    
    point.x =x;
    point.y =y;
    
    top_img2.center = point;
    
    //产生烟雾
    
    UIImageView *smoke=[[UIImageView alloc] initWithImage:top_img2.image];
    
    smoke.frame = top_img2.frame;
    
    smoke.alpha=0.5;
    
    [self.view addSubview:smoke];
    
    //增加动画，移除烟雾
    [UIView beginAnimations:nil context:(__bridge void *)(smoke)];
    
    [UIView setAnimationDuration:2];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    CGRect rect = smoke.frame;
    
    rect.size.width=1;
    
    rect.size.height=1;
    
    rect.origin.x = top_img2.center.x;
    
    rect.origin.y= top_img2.center.y;
    
    smoke.frame = rect;
    
    [UIView commitAnimations];
    

    
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imgv = (__bridge UIImageView*)context;
    
    [imgv removeFromSuperview];
    

    
}

- (void)greatSearchVc
{
    _mylab.hidden = NO;
}

- (void)backToMain
{
    [timer setFireDate:[NSDate distantFuture]];
    
//    if ([self.keyStr isEqualToString:@"oneVc"]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else if ([self.keyStr isEqualToString:@"setting"]){
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
//    [self.navigationController popViewControllerAnimated:YES];
    [self backToRingPage];
    
}






//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//
//}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
