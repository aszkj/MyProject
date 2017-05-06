//
//  clockChildViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "clockChildViewController.h"
#import "PublicInfo.h"
#import "clockTableViewCell.h"
#import "addClockViewController.h"
#import "JGBlueToothManager.h"
#import "DrinkWaterMoel.h"
#import "GetAwakeModel.h"
#import "TMCache.h"
#import "Util.h"
#import "GlobeObject.h"
#define DrinKWater_Cache_key @"DrinKWater_Cache_key"
#define GetAwake_Cache_key @"GetAwake_Cache_key"

@interface clockChildViewController ()
{
    UITableView    *_myTableView;
    NSInteger            point;//全局变量，控制删除哪一个闹钟
    UILabel        *titleLabel;
    TMCache         *_cache;
}

@end

@implementation clockChildViewController

static clockChildViewController *shopview = nil;

+ (clockChildViewController *) instance {
    if (shopview == nil){
        NSLog(@"单利");
        shopview = [[clockChildViewController alloc] init];
    }
    return shopview;
}

- (void)dealloc
{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleLabel.text = _name_str;
#pragma mark - 修改的
    _myTableView.frame = CGRectMake(0, 0, kScreenWidth, (45+10)*_clock_num_array.count);
    [_myTableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    
    if ([self.name_str isEqualToString:@"喝水提醒"]) {
        
        [_cache setObject:_clock_num_array forKey:@"DrinKWater_Cache_key"];
    }else if ([self.name_str isEqualToString:@"起床提醒"]){
        
        [_cache setObject:_clock_num_array forKey:@"GetAwake_Cache_key"];
    }
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cache = [TMCache sharedCache] ;
    
//    [self _initDataCache];
    
    
//    _clock_num_array = [NSMutableArray arrayWithCapacity:0];
    
    NSLog(@"self.name_str = %@",_name_str);
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;


    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 44.0f)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"home_add"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addBtnclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;


    
    [self greatUI];
    
}

- (void)greatUI
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    _myTableView = [[UITableView alloc]init];
#pragma mark - 修改
//    _myTableView.frame = CGRectMake(0, 0, __MainScreen_Height, (45+10)*_clock_num_array.count);
    _myTableView.frame = CGRectMake(0, 0, kScreenWidth, (45+10)*_clock_num_array.count);
    _myTableView.scrollEnabled = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 45;
    [self.view addSubview:_myTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _clock_num_array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellStr = @"cellStr";
    clockTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"clockTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell._right_btn.tag = indexPath.section;
    NSString *clockStr = nil;
    if ([self.name_str isEqualToString:@"喝水提醒"]) {
        clockStr = [NSString stringWithFormat:@"%@ 喝水",[_clock_num_array objectAtIndex:indexPath.section]];
    }else if ([self.name_str isEqualToString:@"起床提醒"]){
         clockStr = [NSString stringWithFormat:@"%@ 起床",[_clock_num_array objectAtIndex:indexPath.section]];
    }

    cell._left_lab.text = clockStr;
    [cell._right_btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    return AUTO_RELEASE(view);
}

-(void)viewDidLayoutSubviews
{
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)backToMain
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addBtnclick
{
    addClockViewController * addClockVc = [[addClockViewController alloc]init];
    
    if (_clock_num_array.count > 10) {
        [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"闹钟数超过十个"];
    }
    
    
    addClockVc.name_str = [NSString stringWithFormat:@"添加%@",_name_str];
    [self.navigationController pushViewController:addClockVc animated:YES];

}

- (void)rightBtnClick:(UIButton *)btn
{
    NSLog(@"clockBtn.tag = %ld",(long)btn.tag);
    point = btn.tag;
    UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"确认删除闹钟？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];[alertVc show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 0) {
        
    }else{
        
        [self canCelClockWithTimeStr:self.clock_num_array[point]];
        if (point >=0 && point < _clock_num_array.count ) {

            [self.clock_num_array removeObjectAtIndex:point];
        }
#pragma mark - 修改的
        _myTableView.frame = CGRectMake(0, 0, kScreenWidth, (45+10)*_clock_num_array.count);
        [_myTableView reloadData];
        
        
        //查询数据库
        if ([self.name_str isEqualToString:@"喝水提醒"]) {
            //DrinKWater_Cache_key
            [_cache setObject:_clock_num_array forKey:DrinKWater_Cache_key];
            
        }else if ([self.name_str isEqualToString:@"起床提醒"]){
//            NSMutableArray *getAwakerArr = [_cache objectForKey:GetAwake_Cache_key];
//            _clock_num_array = getAwakerArr;
            [_cache setObject:_clock_num_array forKey:GetAwake_Cache_key];
            
        }
    }
}





-(void)canCelClockWithTimeStr:(NSString *)timeStr{
    
    JGBlueToothManager *manager = [JGBlueToothManager shareInstances];
    
    //取消闹钟
    NSString *hourStr = [timeStr substringWithRange:NSMakeRange(0, 2)];
    NSString *minuteStr = [timeStr substringWithRange:NSMakeRange(3, 2)];
    
    
    int hour = [hourStr intValue];
    //若第一位是0的话，只取第二位
    if ([[hourStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        hour = [[hourStr substringWithRange:NSMakeRange(1, 1)] intValue];
    }
    
    int minute = [minuteStr intValue];
    //若第一位是0的话，只取第二位
    if ([[minuteStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
        minute = [[minuteStr substringWithRange:NSMakeRange(1, 1)] intValue];
    }
    
    //喝水提醒
    if ([self.name_str isEqualToString:@"喝水提醒"]) {
        
        [manager setArmClockAtHour:hour minute:minute reminderType:RemindTypeDrink warnType:WarnEventTypeClose];
        
    }
    
    //起床提醒
    if ([self.name_str isEqualToString:@"起床提醒"]) {
        
        [manager setArmClockAtHour:hour minute:minute reminderType:RemindTypeClock warnType:WarnEventTypeClose];
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
