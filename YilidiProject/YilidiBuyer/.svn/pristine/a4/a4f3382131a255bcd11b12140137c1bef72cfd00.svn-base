//
//  GuideViewController.m
//  Movie
//
//  Created by Mac on 14-8-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "GuideViewController.h"
#import "DLMainTabBarController.h"

@interface GuideViewController ()
{
    UIPageControl *pageControl;
    UIButton *button;
}
@end

@implementation GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建图片数组
    NSMutableArray *guideImages = [NSMutableArray arrayWithCapacity:3];
    NSString *guide;
    if (iPhone4) {
        guide=@"GuideIphone4-";
    }else if (iPhone5){
        guide=@"GuideIphone5-";
    }else if (iPhone6){
        guide=@"GuideIphone6-";
    }else if (iPhone6p){
        guide=@"GuideIphone6p-";
    }
    
    for (int i = 1 ; i <= 3; i++) {
        NSString *image = [NSString stringWithFormat:@"%@%d",guide,i];
        [guideImages addObject:image];
        
        
    }
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth/2-60, kScreenHeight-120, 120, 31);
    [button setImage:[UIImage imageNamed:@"LaunchImageButton"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, 50, 10)];
    pageControl.numberOfPages = 3;
    pageControl.enabled = NO;
    pageControl.tag = 101;
    pageControl.pageIndicatorTintColor = UIColorFromRGB(0xEA9799);
    pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0xFB272E);
    pageControl.center = self.view.center;
    CGRect rect=pageControl.frame;
    rect.origin.y = kScreenHeight-104;
    pageControl.frame = rect;
   [self.view  addSubview:pageControl];

    for (int i = 0; i< guideImages.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.userInteractionEnabled = YES;
       
        
        imageView.image = [UIImage imageNamed:guideImages[i]];
        
//        UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        skipButton.frame = CGRectMake(kScreenWidth-80, 30, 60, 32);
//        [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
//        [skipButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//        [imageView addSubview:skipButton];
//          [imageView addSubview:button];
        
        [self.scrollView addSubview:imageView];
    }
  

    
    
    //内容大小
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * guideImages.count, 0);
    //滑动分页
//    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
}
 


#pragma mark - override Method
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        
        NSInteger index = scrollView.contentOffset.x / kScreenWidth;
        UIPageControl *page = (UIPageControl *)[self.view viewWithTag:101];
        page.currentPage = index;
        if (page.currentPage==2) {
            button.transform = CGAffineTransformMakeScale(0.2, 0.2);
            
            [UIView animateWithDuration:0.4 animations:^{
                button.transform = CGAffineTransformMakeScale(1, 1);
                button.hidden=NO;
                [self.view addSubview:button];
            }];
        }else{
        
            button.hidden=YES;
        }
    }
    
    if (scrollView.contentOffset.x >= scrollView.frame.size.width * 1 +50) {
         pageControl.hidden=YES;
       
    }else{
        pageControl.hidden=NO;
    }
    
    
//    if (scrollView.contentOffset.x >= scrollView.frame.size.width * 2 +20) {
//        
//        //存入数据
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        [userDefault setObject:@(YES) forKey:@"isAppFirstLauched"];
//        
//        //数据同步,数据多时尽量不要使用
//        [userDefault synchronize];
//        
//        DLMainTabBarController *mainVC = [[DLMainTabBarController alloc] init];
//        self.view.window.rootViewController = mainVC;
//
//        mainVC.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
//
//        [UIView animateWithDuration:0.4 animations:^{
//            mainVC.view.transform = CGAffineTransformIdentity;
//        }];
//        
//    }
    
}



- (void)buttonClick{

    //存入数据
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(YES) forKey:@"isAppFirstLauched"];
    
    //数据同步,数据多时尽量不要使用
    [userDefault synchronize];
    
    
    DLMainTabBarController *mainVC = [[DLMainTabBarController alloc] init];
    self.view.window.rootViewController = mainVC;

    mainVC.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.4 animations:^{
        mainVC.view.transform = CGAffineTransformIdentity;
    }];

    
}

@end
