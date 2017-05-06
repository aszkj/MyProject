//
//  WWSideslipViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

#import "WWSideslipViewController.h"
#import "PublicInfo.h"
#import "userDefaultManager.h"
#import "mainViewController.h"

@interface WWSideslipViewController ()

@end

@implementation WWSideslipViewController
@synthesize speedf,sideslipTapGes;

static WWSideslipViewController *shopview = nil;

+ (WWSideslipViewController *) instance {
    if (shopview == nil){
        NSLog(@"单利");
        shopview = [[WWSideslipViewController alloc] init];
    }
    return shopview;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    speedf = 0.5;
    
//    leftControl = LeftView;
//    mainControl = MainView;
//    righControl = RighView;
    
    //滑动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.mainControl.view addGestureRecognizer:pan];
    
    
    //单击手势
//    sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
//    [sideslipTapGes setNumberOfTapsRequired:1];
//    
//    [self.mainControl.view addGestureRecognizer:sideslipTapGes];
    
    self.leftControl.view.hidden = YES;
    self.righControl.view.hidden = YES;
    
    [self.view addSubview:self.leftControl.view];
    [self.view addSubview:self.righControl.view];
    
    [self.view addSubview:self.mainControl.view];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{

    CGPoint point = [rec translationInView:self.view];
    
    scalef = (point.x*speedf+scalef);
    NSLog(@"scalef = %f",scalef);
//    //根据视图位置判断是左滑还是右边滑动
//    if (rec.view.frame.origin.x>=0){
//        
//        [userDefaultManager SetLocalDataString:[NSString stringWithFormat:@"%f",point.x] key:@"point"];
//        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
//        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
//        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
//        
//        righControl.view.hidden = YES;
//        leftControl.view.hidden = NO;
//    }
//    else
//    {
////        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
////        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1+scalef/1000,1+scalef/1000);
////        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
////    
////        
////        righControl.view.hidden = YES;
//        leftControl.view.hidden = YES;
//    }

    if (scalef>140*speedf){
        [self doSomeThingtoLeft];
        
    }else{
        [self doSomeThingtoRight];
        scalef = 0;
    }
    
    //手势结束后修正位置
//    if (rec.state == UIGestureRecognizerStateEnded) {
//        if (scalef>140*speedf){
//            [self showLeftView];
//        }
////        else if (scalef<-140*speedf) {
//////            [self showRighView];
////        }
//        else
//        {
//            [self showMainView];
//            scalef = 0;
//        }
//    }

}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    if (tap.view.center.x != [UIScreen mainScreen].bounds.size.width/2) {
        if (tap.state == UIGestureRecognizerStateEnded) {
            [UIView beginAnimations:nil context:nil];
            tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
            tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
            [UIView commitAnimations];
            scalef = 0;
        }
    }
    NSLog(@"yeah----yeah");
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    _mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    _mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    _mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
    _mainControl.view.center = CGPointMake(__MainScreen_Width+__MainScreen_Width/2-50,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];

}

- (void)doSomeThingtoLeft
{
    NSLog(@"dosome----dosome");
    mainViewController  * mainVc = [mainViewController instance];
    mainVc.headYorN = YES;
    _righControl.view.hidden = YES;
    _leftControl.view.hidden = NO;
    [self showLeftView];
}

- (void)doSomeThingtoRight
{
    self.leftControl.view.hidden = NO;
    [self showMainView];
}


//显示右视图
//-(void)showRighView{
//    [UIView beginAnimations:nil context:nil];
//    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
//    mainControl.view.center = CGPointMake(-60,[UIScreen mainScreen].bounds.size.height/2);
//    [UIView commitAnimations];
//}

//#warning 为了界面美观，所以隐藏了状态栏。如果需要显示则去掉此代码
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; //返回NO表示要显示，返回YES将hiden
//}

@end
