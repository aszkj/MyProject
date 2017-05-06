//
//  eyeChartViewController.m
//  jingGang
//
//  Created by thinker on 15/7/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "eyeChartView.h"
#import "PublicInfo.h"

@interface eyeChartView ()

@end

@implementation eyeChartView

//- (void)viewDidLoad {
//    [super viewDidLoad];
//   
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void) initUI
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height - 108)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 1584)];
    NSLog(@"cheshi ---- %@",NSStringFromCGRect(scrollView.frame));
    imageView.image = [UIImage imageNamed:@"640-1136"];
    scrollView.contentSize = CGSizeMake(1, CGRectGetHeight(imageView.frame));
    [scrollView addSubview:imageView];
    [self addSubview:scrollView];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
