//
//  lungManualView.m
//  jingGang
//
//  Created by thinker on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "lungManualView.h"
#import "PublicInfo.h"
#import "WSJLungResultViewController.h"
#import "MJRefresh.h"
#import "WSJHeartRateResultViewController.h"

@implementation lungManualView
{
    UITextField *_lungValueTextField;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void) keyboardWillShow:(NSNotification *)show
{
    if ([_lungValueTextField isFirstResponder])
    {
        CGRect frame = self.frame;
        frame.origin.y = -50;
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
        NSLog(@"cheshi ---- %@",show.userInfo);
    }
}
- (void) initUI
{
    //设置背景颜色
    self.backgroundColor = [UIColor colorWithRed:232.0 /255 green:232.0 /255 blue:232.0 /255 alpha:1];
    
    //提示视图View
    UIView *promptView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 40)];
    promptView.backgroundColor = [UIColor colorWithRed:217.0 / 255 green:217.0 / 255 blue:217.0 / 255 alpha:1];
    [self addSubview:promptView];
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, promptView.frame.size.width, promptView.frame.size.height)];
    promptLabel.text = @"请输入您的肺活量值";
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:16];
    [promptView addSubview:promptLabel];
    
    UIImageView *promptImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-tishi_看图王"]];
    promptImageView.bounds = CGRectMake(0, 0, 25, 25);
    promptImageView.center = CGPointMake(__MainScreen_Width / 2 - 100,20);
    [promptView addSubview:promptImageView];
    
    UILabel *lungLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 100 , 50)];
    lungLabel.text = @"肺活量值:";
    lungLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:lungLabel];
    
    _lungValueTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 70, __MainScreen_Width - 80 - 100, 50)];
    _lungValueTextField.placeholder = @"0~10000";
    _lungValueTextField.borderStyle = UITextBorderStyleRoundedRect;
    _lungValueTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_lungValueTextField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHiddenKey)];
    [self addGestureRecognizer:tap];
    
    UIButton *certain = [UIButton buttonWithType:UIButtonTypeSystem];
    certain.frame = CGRectMake(40, 150 , __MainScreen_Width - 80 , 50);
    certain.layer.cornerRadius = 5;
    certain.backgroundColor = [UIColor colorWithRed:4.0 / 255 green:145.0 / 255 blue:203.0 / 255 alpha:1];
    [certain setTitle:@"确认输入" forState:UIControlStateNormal];
    [certain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [certain addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:certain];
    
    
   
    //监听键盘状态
    [self monitorKey];
}
#pragma mark - 监听键盘状态
- (void) monitorKey
{
    //键盘抬起通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //界面切换时隐藏键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapHiddenKey) name:@"changeMenu" object:nil];
}
- (void) certainAction
{
    if ([_lungValueTextField.text integerValue] > 0 && [_lungValueTextField.text integerValue] < 10000 )
    {
        WSJLungResultViewController *lungResultVC = [[WSJLungResultViewController alloc] initWithNibName:@"WSJLungResultViewController" bundle:nil];
        lungResultVC.type = lungCapacityType;
        lungResultVC.lungValue = [_lungValueTextField.text integerValue];
        [self.VC.navigationController pushViewController:lungResultVC animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"肺活量输入不合理，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        _lungValueTextField.text = @"";
    }
    NSLog(@"确认输入");
}
- (void) tapHiddenKey
{
    [self endEditing:YES];
    CGRect frame = self.frame;
    frame.origin.y = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
    }];
}
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
