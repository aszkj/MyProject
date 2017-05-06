//
//  astigmatismViewController.m
//  jingGang
//
//  Created by thinker on 15/7/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "astigmatismView.h"
#import "PublicInfo.h"
#import "blindnessResultViewController.h"

#import "WSJShopHomeViewController.h"

#import "MERFastResultViewController.h"

#define K_Heigth (__MainScreen_Height - 108)
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface astigmatismView ()
{
    UIButton *_btnN;
    UIButton *_btnS;
}

@end

@implementation astigmatismView

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self initUI];
//    NSLog(@"cheshi ---- %@.....%@.",self.VC,self);
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void) initUI
{
//第一层
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.center = CGPointMake(__MainScreen_Width / 2, K_Heigth / 4);
    imageView.bounds = CGRectMake(0, 0, K_Heigth / 2 -20, K_Heigth / 2 -20);
    imageView.image = [UIImage imageNamed:@"testphoto"];
    [self addSubview:imageView];
    
    
//第二层
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, K_Heigth / 2, __MainScreen_Width, K_Heigth / 4 + 40)];
    backView2.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView2];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = [UIColor blackColor];
    label1.text = @"请选择您观测的结果";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.center = CGPointMake(__MainScreen_Width / 2, K_Heigth / 48 + 5);
    label1.bounds = CGRectMake(0, 0, 200, K_Heigth / 24);
    [backView2 addSubview:label1];
    
    
    UIView *btnView = [[UIView alloc] init];
    btnView.center = CGPointMake(__MainScreen_Width / 2,  CGRectGetMaxY(label1.frame) + (K_Heigth / 4  - K_Heigth / 24) / 2 + 10);
    btnView.bounds = CGRectMake(0, 0, 210, K_Heigth / 12 + 50);
//    btnView.backgroundColor = [UIColor redColor];
    [backView2 addSubview:btnView];
    
    
    //两个单选按钮
    _btnN = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnN setImage:[UIImage imageNamed:@"no_select"] forState:UIControlStateNormal];
    [_btnN setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [_btnN addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
//    _btnN.frame = CGRectMake(30, CGRectGetMaxY(label1.frame) + 10, 20, 20 );
    _btnN.bounds = CGRectMake(0, 0, 20, 20);
    _btnN.center = CGPointMake(10, CGRectGetHeight(btnView.frame) / 7 * 2);
    [btnView addSubview:_btnN];
    
    UILabel *label2 = [[UILabel alloc] init ];
//                       WithFrame:CGRectMake(CGRectGetMaxX(_btnN.frame)+ 10, CGRectGetMaxY(label1.frame) + 10, 200, K_Heigth / 24 + 15)];
    label2.center = CGPointMake(btnView.frame.size.width / 2 + 15, btnView.frame.size.height / 7 * 2);
    label2.bounds = CGRectMake(0, 0, 180, K_Heigth / 24 + 15);
    label2.text = @"图中某一线条黑而清晰";
    label2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    label2.tag = 0;
    [label2 addGestureRecognizer:tap2];
    [btnView addSubview:label2];
    
    _btnS = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnS addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btnS setImage:[UIImage imageNamed:@"no_select"] forState:UIControlStateNormal];
    [_btnS setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    _btnS.bounds = CGRectMake(0, 0, 20, 20);
    _btnS.center = CGPointMake(10, CGRectGetHeight(btnView.frame) / 7 * 5);
    [btnView addSubview:_btnS];
    
    UILabel *label3 = [[UILabel alloc] init];
//                       WithFrame:CGRectMake(CGRectGetMaxX(_btnS.frame)+ 10, CGRectGetMaxY(_btnN.frame) + 10, 180, K_Heigth / 24 + 15)];
    label3.bounds = CGRectMake(0, 0, 180, K_Heigth / 24 + 15);
    label3.center = CGPointMake(btnView.frame.size.width / 2 + 15, btnView.frame.size.height / 7 * 5);
    label3.text = @"图中各向线条粗细均匀";
    NSLog(@"cheshi --ddddd-- %lf  ++%lf",label3.frame.size.height,label3.frame.size.width - 5);
    label3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    label3.tag = 1;
    [label3 addGestureRecognizer:tap3];
    [btnView addSubview:label3];
    
    
//第三层
    UIView *backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, K_Heigth / 4 * 3 + 40, __MainScreen_Width, K_Heigth / 4  - 30)];
    backView3.backgroundColor = status_color;
    [self addSubview:backView3];
    
    
    //提交按钮
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeSystem];
    submit.center = CGPointMake(__MainScreen_Width / 2, K_Heigth / 8 - 20);
    submit.bounds = CGRectMake(0, 0, 100, 40);
    submit.layer.cornerRadius = 5;
    submit.backgroundColor = [UIColor colorWithRed:4.0 / 255 green:145.0 / 255 blue:203.0 / 255 alpha:1];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView3 addSubview:submit];
}
#pragma mark - 单选按钮
- (void) selectBtn:(UIButton *)btn
{
    _btnN.selected = NO;
    _btnS.selected = NO;
    btn.selected = YES;
}
#pragma mark - 提交测试事件
- (void) submitAction
{
//    MERFastResultViewController *merVC =  [[MERFastResultViewController alloc] initWithNibName:@"MERFastResultViewController" bundle:nil];
//    merVC.heartRateValue = 90;
//
//    merVC.OxygenValue = 97;
//
//    
//    merVC.highPressure = 100;
//    merVC.lowPressure = 50;
//    [self.VC.navigationController pushViewController:merVC animated:YES];
//    return;
#warning 跳转结果界面
#if 1
    if ( !_btnN.selected && !_btnS.selected)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择您观测的结果" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        blindnessResultViewController *resultVC = [[blindnessResultViewController alloc] initWithNibName:@"blindnessResultViewController" bundle:nil];
        resultVC.type = k_Astigma;
        resultVC.isAstigmatism = _btnN.selected;
        [self.VC.navigationController pushViewController:resultVC animated:YES];
    }
#endif
 

}

#pragma mark - label点击事件
- (void) tapAction:(UIGestureRecognizer *)tap
{
    _btnN.selected = NO;
    _btnS.selected = NO;
    if (tap.view.tag)
    {
        _btnS.selected = YES;
    }
    else
    {
        _btnN.selected = YES;
    }
}


@end
