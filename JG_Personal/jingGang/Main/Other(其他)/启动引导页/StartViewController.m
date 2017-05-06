//
//  InputInviteCodeController.h
//  jingGang
//
//  Created by HanZhongchou on 15/12/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"
#import "Common.h"
#import "AppDelegate.h"
#import "JGActivityHelper.h"
#import "UIView+Frame.h"
@interface StartViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *startButton;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initScrollView];
    [self initPageControl];
    
}

//添加scrollView
- (void)initScrollView
{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    for (int i = 0; i < self.arrayStarImage.count; i ++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%@",self.arrayStarImage[i]];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imgView.frame = CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight);
        [_scrollView addSubview:imgView];
        
        if (i == self.arrayStarImage.count - 1) {
            
            self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            CGRect buttonRect;
            
            if (iPhone4||iPhone5) {
                buttonRect = CGRectMake(0, kScreenHeight - 29 - 30, 120, 30);
            }else if (iPhone6){
                buttonRect = CGRectMake(0, kScreenHeight - 29 - 40, 160, 40);
            }else if (iPhone6p){
                buttonRect = CGRectMake(0, kScreenHeight - 29 - 50, 200, 45);
            }
        
            self.startButton.frame = buttonRect;
            CGPoint point = self.startButton.center;
            point.x = self.view.center.x;
            self.startButton.center = point;
            self.startButton.hidden = YES;
            [self.startButton addTarget:self action:@selector(changeRootViewController) forControlEvents:UIControlEventTouchUpInside];
            [self.startButton setTitle:@"立即体验" forState:UIControlStateNormal];
            [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            self.startButton.layer.cornerRadius = 4.0;
            [self.startButton.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
            [self.startButton.layer setBorderWidth:1];//设置边界的宽度
            //设置按钮的边界颜色
            
            CGColorRef color = [UIColor whiteColor].CGColor;
            
            [self.startButton.layer setBorderColor:color];
            [self.startButton setBackgroundColor:[UIColor clearColor]];
            [imgView addSubview:self.startButton];
            imgView.userInteractionEnabled = YES;
            
            
        }
    }
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.arrayStarImage.count, ScreenHeight);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:self.scrollView];
    
}

// 添加pageControl
- (void)initPageControl
{
    
    self.pageControl = [[UIPageControl alloc]init];;
    self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.bounds = CGRectMake(0, 0, 90, 20);
    self.pageControl.center = CGPointMake(ScreenWidth / 2, ScreenHeight);
    CGRect pageFrame = self.pageControl.frame;
    if (iPhone6p) {
        pageFrame.origin.y = kScreenHeight - 32;
    }else{
        pageFrame.origin.y = kScreenHeight - 25;
    }
    
    self.pageControl.frame = pageFrame;
    
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageControl.numberOfPages = self.scrollView.contentSize.width/ScreenWidth;
    self.pageControl.currentPage = 0;
    
//    self.scrollView.backgroundColor = [UIColor redColor];
//    self.pageControl.hidden = YES;//加这句是因为图片本身有翻页的点显示

    [self.view addSubview:self.pageControl];
    
}

#pragma mark -
#pragma mark PageControlDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.pageControl.currentPage = scrollView.contentOffset.x / ScreenWidth;
    [self showButton:self.pageControl.currentPage];

}

#pragma mark -
#pragma mark PageControlDelegate

- (void)changePage:(UIPageControl *)aPageControl
{
    
    [self.scrollView setContentOffset:CGPointMake(aPageControl.currentPage * ScreenWidth, 0) animated:YES];
    [self showButton:aPageControl.currentPage];
    
}

//显示按钮
- (void)showButton:(NSInteger )index
{
    
    if (index == self.arrayStarImage.count - 1) {
        
//        self.pageControl.hidden = YES;
        self.startButton.hidden = NO;
        
    }

}

- (void)changeRootViewController
{
    //延迟2秒执行，如果出现版本更新就在这边调用自动签到系统
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JGActivityHelper queryUserDidCheckInPopView:^(UserSign *userSign) {
            // 用户没签到弹窗
            //        JGLog(@"用户当前签到状况: 没签到！");
            //        JGLog(@"userSign:%@",userSign);
        } notPop:^{
            // 用户已签到，或网络错误不弹窗
            //        JGLog(@"用户当前签到状况: 没签到！");
        }];
        
        
    });
    
    AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [app gogogoWithTag:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
