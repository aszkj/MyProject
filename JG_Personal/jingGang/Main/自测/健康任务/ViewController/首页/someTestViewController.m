//
//  someTestViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "someTestViewController.h"
#import "PublicInfo.h"
#import "AppDelegate.h"
#import "someTestTableViewCell.h"
#import "UIButton+Block.h"
#import "GlobeObject.h"
#import "HealthMaintainceVC.h"
#import "JGHealthTaskManager.h"
#import "MainTainceResultVC.h"
#import "VApiManager+Aspects.h"
//接收下一项任务的通知
#define K_next_task_Notification @"K_next_task_Notification"


@interface someTestViewController ()
{
    UIScrollView         *_myScrollView;
    UITableView          *_myTableView;
    
    JGHealthTaskManager  *_JGHealthTaskManager;
    
    NSArray             *_completedArr;
    
    NSString            *_maitaiceTitle;
    NSString            *_maitainceRelativePath;
    NSInteger           _unfinishedTaskCount;
    UILabel *taskLabel;
    
}

@end

@implementation someTestViewController

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:K_next_task_Notification object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _JGHealthTaskManager = [JGHealthTaskManager shareInstances] ;
    //获取任务信息
    switch (self.bigTaskNum) {
        case 0:
            _completedArr = _JGHealthTaskManager.eyesightMaintainceCompletedArr;
            _unfinishedTaskCount = _JGHealthTaskManager.eyesightMaintainceCompletedArr.count - _JGHealthTaskManager.eyeCompletedCount;
            break;
        case 1:
            _completedArr = _JGHealthTaskManager.hearingMaintainceCompletedArr;
            _unfinishedTaskCount = _JGHealthTaskManager.hearingMaintainceCompletedArr.count - _JGHealthTaskManager.hearingCompletedCount;
            break;
        case 2:
            _unfinishedTaskCount = _JGHealthTaskManager.blooControlceCompletedArr.count - _JGHealthTaskManager.bloodControlCompletedCount;
            _completedArr = _JGHealthTaskManager.blooControlceCompletedArr;
            break;
        case 3:
            _unfinishedTaskCount = _JGHealthTaskManager.weightControlCompletedArr.count-_JGHealthTaskManager.weightControlCompletedCount;
            _completedArr = _JGHealthTaskManager.weightControlCompletedArr;
            break;
        default:
            break;
    }
    taskLabel.text = [NSString stringWithFormat:@"你还有%ld项任务没有完成",_unfinishedTaskCount];

    [_myTableView reloadData];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //添加下一项任务的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextTaskBegin:) name:K_next_task_Notification object:nil];
    
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _keyStr;
    self.navigationItem.titleView = titleLabel;
    RELEASE(titleLabel);

    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    //增加好点的返回键
    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"backToMain" isLeftItem:YES inResponseObject:self];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;


    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    //    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;


    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    
    [self greatUI];
}

- (void)greatUI
{
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = self.view.frame;
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myScrollView];
    
    UIImageView * img_view = [[UIImageView alloc]init];
    img_view.frame = CGRectMake(0, 0, __MainScreen_Width, 107);
    img_view.image = [UIImage imageNamed:_img_name];
    NSLog(@"img_name = %@",_img_name);
    [_myScrollView addSubview:img_view];

    UIImageView * img_view2 = [[UIImageView alloc]init];
    img_view2.frame = CGRectMake(0, 0, 46, 51);
    img_view2.center = CGPointMake(__MainScreen_Width/2, img_view.center.y-15);
    img_view2.image = [UIImage imageNamed:_img_name2];
    [img_view addSubview:img_view2];

    
    taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
//    taskLabel.text = [NSString stringWithFormat:@"你还有%ld项任务没有完成",_unfinishedTaskCount];
    taskLabel.textColor = [UIColor whiteColor];
    taskLabel.font = [UIFont systemFontOfSize:18];
    taskLabel.center = CGPointMake(__MainScreen_Width/2, img_view.center.y+img_view2.frame.size.height/ 2 );
    [img_view addSubview:taskLabel];
//    [taskLabel release];
    
    _myTableView = [[UITableView alloc]init];
    _myTableView.rowHeight = 46;
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.frame = CGRectMake(0, img_view.frame.origin.y+img_view.frame.size.height, __MainScreen_Width, 46*self.name_array.count);
    _myScrollView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.scrollEnabled = NO;
    [_myScrollView addSubview:_myTableView];
    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, _myTableView.frame.origin.y+_myTableView.frame.size.height+100);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.name_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellStr = @"cellStr";
    someTestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"someTestTableViewCell" owner:self options:nil];
        cell = [array firstObject];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell._left_img.image = [UIImage imageNamed:[NSString stringWithFormat:@"test_step_0%ld",(long)indexPath.row+1]];
    cell._name_lab.text = [self.name_array objectAtIndex:indexPath.row];
    
    if ([_completedArr[indexPath.row] integerValue] == 1) {//已完成
        cell.haveCompletedimgView.hidden = NO;
    }else{
        cell.haveCompletedimgView.hidden = YES;
    }

    
    [cell.clickButton addActionHandler:^(NSInteger tag) {
        
        UNLOGIN_HANDLE
        NSString *mainTainceName = cell._name_lab.text;
        //根据保健名称进入不同的保健页面
        [self comIntoDifferentcMainTaincePageWithMainTainceName:mainTainceName withSmallTaskNum:indexPath.row];
    }];
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%ld",indexPath.row);
    
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

-(void)comIntoDifferentcMainTaincePageWithMainTainceName:(NSString *)mainTainceName withSmallTaskNum:(NSInteger)smallTaskNum{
    
    
    HealthMaintainceVC *mainTainceVC = [[HealthMaintainceVC alloc] init];
    mainTainceVC.mainTainceTitle = mainTainceName;
    _maitaiceTitle = [mainTainceName copy];
    if ([mainTainceName isEqualToString:@"眼保健操"]) {
        
        mainTainceVC.mainTainceRelativePath = @"task-eye.jsp";
    }else if ([mainTainceName isEqualToString:@"捏耳廓"]){
        mainTainceVC.mainTainceRelativePath = @"task-ear-02.jsp";
        
    }else if ([mainTainceName isEqualToString:@"降压操"]){
        mainTainceVC.mainTainceRelativePath = @"task.jsp";
        
    }else if ([mainTainceName isEqualToString:@"快速减肥操"]){
        mainTainceVC.mainTainceRelativePath = @"task-fast.jsp";
        
    }else if ([mainTainceName isEqualToString:@"捏耳屏"]){
        mainTainceVC.mainTainceRelativePath = @"task-ear-03.jsp";
        
    }else if ([mainTainceName isEqualToString:@"拧耳朵"]){
        mainTainceVC.mainTainceRelativePath = @"task-ear-04.jsp";
        
    }else if ([mainTainceName isEqualToString:@"松耳廓"]){
        mainTainceVC.mainTainceRelativePath = @"task-ear-05.jsp";
        
    }else if ([mainTainceName isEqualToString:@"睡前减肥操"]){
        mainTainceVC.mainTainceRelativePath = @"task-loss.jsp";
        
    }else if ([mainTainceName isEqualToString:@"拉耳廓"]){
        mainTainceVC.mainTainceRelativePath = @"task-ear.jsp";
        
    }else if ([mainTainceName isEqualToString:@"紧闭双眼"]){
        mainTainceVC.mainTainceRelativePath = @"task-eye-01.jsp";
        
    }else if ([mainTainceName isEqualToString:@"闭眼移动"]){
        mainTainceVC.mainTainceRelativePath = @"task-eye-02.jsp";
        
    }else if ([mainTainceName isEqualToString:@"两个物体"]){
        mainTainceVC.mainTainceRelativePath = @"task-eye-03.jsp";
        
    }else if ([mainTainceName isEqualToString:@"左右移动"]){
        mainTainceVC.mainTainceRelativePath = @"task-eye-04.jsp";
        
    }else if ([mainTainceName isEqualToString:@"上下移动"]){
        mainTainceVC.mainTainceRelativePath = @"task-eye-05.jsp";
        
    }else if ([mainTainceName isEqualToString:@"随机移动"]){
        mainTainceVC.mainTainceRelativePath = @"task-eye-06.jsp";
        
    }else if ([mainTainceName isEqualToString:@"圆圈聚焦"]){
        mainTainceVC.mainTainceRelativePath = @"task-eye-07.jsp";
        
    }
    _maitainceRelativePath = [mainTainceVC.mainTainceRelativePath copy];
    mainTainceVC.bigTaskNum = self.bigTaskNum;
    mainTainceVC.smallTaskNum = smallTaskNum;

    [self.navigationController pushViewController:mainTainceVC animated:YES];

    
}//进入不同的保健页面，根据保健名称


#pragma mark - 下一项任务通知响应
-(void)nextTaskBegin:(NSNotification *)info{
    
    NSNumber *smallTaskNum = info.object;
    if (smallTaskNum.integerValue >= self.name_array.count) {
        return;
    }
    
    someTestTableViewCell *cell = (someTestTableViewCell *)[_myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:smallTaskNum.integerValue inSection:0]];
    //根据保健名称进入不同的保健页面
    [self comIntoDifferentcMainTaincePageWithMainTainceName:cell._name_lab.text withSmallTaskNum:smallTaskNum.integerValue];
}


- (void)backToMain
{
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app gogogoWithTag:2];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
