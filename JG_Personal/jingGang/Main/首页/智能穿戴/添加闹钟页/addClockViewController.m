//
//  addClockViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "addClockViewController.h"
#import "PublicInfo.h"
#import "clockChildViewController.h"
#import "JGBlueToothManager.h"
#import "TMCache.h"

#define lab_color           [UIColor colorWithRed:90.f/255.0f green:196.f/255.0f blue:241.f/255.0f alpha:1.0f]

@interface addClockViewController ()
{
    NSMutableArray           *pick_arr,*pick_arr2,*lab_array,*lab_array2;
    TMCache                  *_cache;
    
    NSMutableArray           *_drinkWaterArr;
    NSMutableArray           *_getAwakeArr;
    
}

@end

@implementation addClockViewController

- (void)dealloc
{


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)_initDataCache{

    _cache = [TMCache sharedCache] ;
    _drinkWaterArr = (NSMutableArray *)[_cache objectForKey:@"DrinKWater_Cache_key"];
    if(_drinkWaterArr.count == 0){
    
        _drinkWaterArr = [NSMutableArray arrayWithCapacity:0];
    }

    
    _getAwakeArr = (NSMutableArray *)[_cache objectForKey:@"GetAwake_Cache_key"];
    if (_getAwakeArr.count == 0) {
        _getAwakeArr = [NSMutableArray arrayWithCapacity:0];
    }

}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.H_str = @"00";
    self.M_str = @"00";
    
//    [self _initDataCache];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _name_str;
    self.navigationItem.titleView = titleLabel;

    

    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;

    
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 44.0f)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"home_sure"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sureBtnclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    
    lab_array = [[NSMutableArray alloc]init];
    lab_array2 = [[NSMutableArray alloc]init];
    
    [self greatUI];
}

- (void)greatUI
{
    UIView * bg_view = [[UIView alloc]init];
    bg_view.backgroundColor = [UIColor whiteColor];
    bg_view.frame = CGRectMake(0, 10, __MainScreen_Width, 200);
    [self.view addSubview:bg_view];
    
    for (int i =0 ; i < 2; i ++) {
        UILabel * point_lab = [[UILabel alloc]init];
        point_lab.frame = CGRectMake(0, 0, 2, 2);
        point_lab.backgroundColor = lab_color;
        point_lab.layer.cornerRadius = 1;
        point_lab.clipsToBounds = YES;
        point_lab.center = CGPointMake(__MainScreen_Width/2, bg_view.frame.size.height/2-5+i*10);
        [bg_view addSubview:point_lab];

    }
    
    UIPickerView * timePick = [[UIPickerView alloc] initWithFrame:CGRectMake(73, 10, 58, bg_view.frame.size.height-20)];
    timePick.tag = 1;
    timePick.delegate = self;
    timePick.dataSource = self;
//    timePick.showsSelectionIndicator = YES;
    UIPickerView * timePick2 = [[UIPickerView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2+30, 10, 58, bg_view.frame.size.height-20)];
    timePick2.tag = 2;
    timePick2.delegate = self;
    timePick2.dataSource = self;
    
    pick_arr = [[NSMutableArray alloc]init];
    pick_arr2 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 60; i ++) {
        NSString * numstr = [NSString stringWithFormat:@"%d",i];
        if (i < 10) {
            numstr = [NSString stringWithFormat:@"0%d",i];
        }
        if (i<24) {
            [pick_arr addObject:numstr];
        }
        [pick_arr2 addObject:numstr];
    }
    [bg_view addSubview:timePick];
    [bg_view addSubview:timePick2];

  
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return [pick_arr count];
    }else{
        return [pick_arr2 count];
    }
}

//自定义UIPickerView的每一行label
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    if (pickerView.tag == 1) {
        label.text = [pick_arr objectAtIndex:row];
        [lab_array addObject:label];
    } else {
        label.text = [pick_arr2 objectAtIndex:row];
        [lab_array2 addObject:label];
    }
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = lab_color;
    return AUTO_RELEASE(label);
}


-(CGFloat)pickerView:(UIPickerView*)pickerView widthForComponent:(NSInteger) component
{
    return 58;
}

//选中某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//   [self viewForRow:row forComponent:component];
    if (pickerView.tag == 1) {
        self.H_str = [pick_arr objectAtIndex:row];
    }else{
        self.M_str = [pick_arr2 objectAtIndex:row];
    }
}

//取这一行的Label，改变颜色
- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    NSLog(@"row ===  %d compont = %d",row,component);
//    UILabel * lab = nil;
//    if (component == 0) {
//        lab = [lab_array objectAtIndex:row];
//    } else {
//        lab = [lab_array2 objectAtIndex:row];
//    }
//    lab.textColor = [UIColor greenColor];
//    return lab;
    return nil;
}


- (void)backToMain
{
    
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)_makeArmClock{
    
    JGBlueToothManager *blueManager = [JGBlueToothManager shareInstances];
   
    int hour = [self.H_str intValue];
    //若第一位是0的话，只取第二位
    if ([[self.H_str substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        hour = [[self.H_str substringWithRange:NSMakeRange(1, 1)] intValue];
    }
    
    int minute = [self.M_str intValue];
    //若第一位是0的话，只取第二位
    if ([[self.M_str substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        minute = [[self.M_str substringWithRange:NSMakeRange(1, 1)] intValue];
    }
    
    
    //喝水提醒
    if ([self.name_str isEqualToString:@"添加喝水提醒"]) {

        [blueManager setArmClockAtHour:hour minute:minute reminderType:RemindTypeClock warnType:WarnEventTypeOpen];
        
        NSString *drinKwaterStr = [NSString stringWithFormat:@"%@:%@",self.H_str,self.M_str];
        
    }
    
    
    
    //起床提醒
    if ([self.name_str isEqualToString:@"添加起床提醒"]) {

        [blueManager setArmClockAtHour:hour minute:minute reminderType:RemindTypeClock warnType:WarnEventTypeOpen];
        
        NSString *getWakeStr = [NSString stringWithFormat:@"%@:%@",self.H_str,self.M_str];
        
    }
    
    
    //存进数据库
    
}



-(void)addAwakeClock{




}




- (void)sureBtnclick
{
    NSLog(@"H-----%@,M------%@",_H_str,_M_str);
    
    //先设置闹钟
    [self _makeArmClock];    
    
    NSString * str = [NSString stringWithFormat:@"%@:%@",_H_str,_M_str];
    clockChildViewController * clockVc = [clockChildViewController instance];
    if (![self _hasAddThisClockAtArr:clockVc.clock_num_array forClock:str]) {
        [clockVc.clock_num_array addObject:str];
        [self _showAddClockResultAlertWithStr:@"添加闹钟成功"];
    }else {
        [self _showAddClockResultAlertWithStr:@"添加失败，闹钟已存在！"];
    }
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)_showAddClockResultAlertWithStr:(NSString *)alertStr{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];

    [alert show];
}


-(BOOL)_hasAddThisClockAtArr:(NSArray *)clockArr forClock:(NSString *)willAddClockStr {

    BOOL isAdded = NO;
    for (NSString *addedClockstr in clockArr) {
        if ([addedClockstr isEqualToString:willAddClockStr]) {
            isAdded = YES;
            break;
        }
    }
    return isAdded;
}

#pragma mark ----------------------- alert delegate -----------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index --- %ld",buttonIndex);
    if (!buttonIndex) {
         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
