//
//  devieseViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "mydevieseViewController.h"
#import "PublicInfo.h"
#import "devieseTableViewCell.h"
#import "UIButton+Block.h"
#import "JGBlueToothManager.h"
#import "BangdingVC.h"
#import "AppDelegate.h"
#import "Util.h"

#define R 47.5//旋转图片的半径


@interface mydevieseViewController ()
{
    UIImageView         * top_img;
    float               top_img_h ;
    NSTimer             * timer;
    float               x0,y0;
    UIImageView         * top_img2;
    UIButton            * button;
    UITableView         *_myTableView;
    float               tableView_h;
    UIScrollView        *_myScrollView;
    UILabel             *_mylab;
    
    JGBlueToothManager *_jgBlueToothManager;
    
    UILabel             *_blueToothErrorLabel;//错误信息提示label
    
    
}
@property (nonatomic,strong)UILabel *blueToothErrorLabel;
@end

@implementation mydevieseViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    //启动蓝牙模块
    [[qBleClient sharedInstance] pubControlSetup];
#endif

    
    
    _jgBlueToothManager = [JGBlueToothManager shareInstances] ;
    

    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
#pragma mark - 修改的
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"扫描设备";
    self.navigationItem.titleView = titleLabel;
    RELEASE(titleLabel);
    //    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //增加好点的返回键
    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"backToMain" isLeftItem:YES inResponseObject:self];
    
    RELEASE(leftBtn);
    RELEASE(leftButton);

    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    //    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    RELEASE(rightBtn);
    RELEASE(rightButton);

    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    top_img_h = 100;
    if (__MainScreen_Height == 480) {
        top_img_h = 100;
    }
    
    
    
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = self.view.frame;
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myScrollView];
    
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, __MainScreen_Width, 216);
    view.backgroundColor = [UIColor colorWithRed:63.0/255 green:153.0/255 blue:191.0/255 alpha:1];
    [_myScrollView addSubview:view];
    
    button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:@"home_back_scan"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = CGPointMake(__MainScreen_Width/2, top_img_h);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"点击扫描" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_myScrollView addSubview:button];
//    top_img =[[UIImageView alloc]init];
//    top_img.image = [UIImage imageNamed:@"home_bluetooth"];
//    top_img.frame = CGRectMake(0, 0, 100, 100);
//    top_img.center = CGPointMake(__MainScreen_Width/2, top_img_h);
//    [self.view addSubview:top_img]; [top_img release];
    
    top_img2 =[[UIImageView alloc]init];
    top_img2.image = [UIImage imageNamed:@"home_run1"];
    top_img2.frame = CGRectMake(0, 0, 5, 5);
    top_img2.center = CGPointMake(__MainScreen_Width/2, top_img_h);
    top_img2.hidden = YES;
    [_myScrollView addSubview:top_img2];

    
    tableView_h = view.frame.origin.y+view.frame.size.height;
    _myTableView = [[UITableView alloc]init];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.rowHeight = __mydeviese_tab_cell_h;
    _myTableView.frame = CGRectMake(0, tableView_h, __MainScreen_Width, __mydeviese_tab_cell_h*(self.devArray.count));
    [_myScrollView addSubview:_myTableView];
    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, _myTableView.frame.origin.y+_myTableView.frame.size.height+__Other_Height+10);
    
    _mylab = [[UILabel alloc]init];
    _mylab.textAlignment = NSTextAlignmentCenter;
    _mylab.textColor = [UIColor lightGrayColor];
    _mylab.frame = CGRectMake(0, tableView_h+103, __MainScreen_Width, 20);
    _mylab.text = @"请确保您身边有打开了的蓝牙设备";
    _mylab.font = [UIFont boldSystemFontOfSize:16];
    [_myScrollView addSubview:_mylab];
    _mylab.hidden = YES;
    
    RELEASE(view);
    
//    UILabel * lab = [[UILabel alloc]init];
//    lab.frame = CGRectMake(0, top_img.frame.origin.y+top_img.frame.size.height+16, __MainScreen_Width, 15);
//    lab.text = @"正在绑定";
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.textColor = [UIColor whiteColor];
//    [self.view addSubview:lab];[lab release];
//    
//    UILabel * lab2 = [[UILabel alloc]init];
//    lab2.textColor = [UIColor whiteColor];
//    lab2.text = @"该过程大概需要10～40秒";
//    lab2.textAlignment = NSTextAlignmentCenter;
//    lab2.frame = CGRectMake(0, lab.frame.size.height+lab.frame.origin.y+35, __MainScreen_Width, 10);
//    [self.view addSubview:lab2];[lab2 release];
//    
//    UILabel * lab3 = [[UILabel alloc]init];
//    lab3.textColor = [UIColor whiteColor];
//    lab3.text = @"请耐心等候";
//    lab3.textAlignment = NSTextAlignmentCenter;
//    lab3.frame = CGRectMake(0, lab2.frame.size.height+lab2.frame.origin.y+12, __MainScreen_Width, 10);
//    [self.view addSubview:lab3];[lab3 release];
    
//    UIButton * cancel_btn = [[UIButton alloc]init];
//    cancel_btn.frame = CGRectMake(0, 0, 86, 41);
//    cancel_btn.center = CGPointMake(__MainScreen_Width/2, __MainScreen_Height-80);
//    [cancel_btn setBackgroundImage:[UIImage imageNamed:@"home_but_tem"] forState:UIControlStateNormal];
//    [cancel_btn setBackgroundImage:[UIImage imageNamed:@"home_but_tem_pressed"] forState:UIControlStateHighlighted];
//    [cancel_btn setTitle:@"暂不绑定" forState:UIControlStateNormal];
//    [cancel_btn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
//    [cancel_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [cancel_btn setTitleColor:[UIColor colorWithRed:63.0/255 green:153.0/255 blue:191.0/255 alpha:1] forState:UIControlStateHighlighted];
//    [self.view addSubview:cancel_btn];[cancel_btn release];
    
//    timer =  [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(loop) userInfo:nil repeats:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.devArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellStr = @"cellStr";
    devieseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"devieseTableViewCell" owner:self options:nil];
        cell = [array firstObject];
    }
    
    
    NSDictionary *dic = self.devArray[indexPath.row];
    CBPeripheral *per =dic[@"peripheral"];
    cell.name_lab.text = per.identifier.UUIDString;

    if (![cell.B_btn isTouchInside]) {
    
        [cell.B_btn addActionHandler:^(NSInteger tag) {
            
            //推到绑定设备控制器
            BangdingVC *bangDingVC = [[BangdingVC alloc] init];
            bangDingVC.needBandePerial = per;
            bangDingVC.bangdedSuceessBackVC = self.deviceChindVC;
            bangDingVC.backBlock = ^{
            
                [self.navigationController popToRootViewControllerAnimated:YES];
            };
            [self.navigationController pushViewController:bangDingVC animated:YES];
            
        }];
    }
    return cell;
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

static int ti = 0;

- (void)buttonClick
{
    _mylab.hidden = YES;
    timer =  [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(loop) userInfo:nil repeats:YES];
    top_img2.hidden = NO;
    button.userInteractionEnabled = NO;
    [button setTitle:@"扫描中" forState:UIControlStateNormal];
    ti = ti+1;
    [self _bgeinScan];
    /*
    double delayInSeconds2 = 5.0;//2秒之后发送反馈信息
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds2 * NSEC_PER_SEC);
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        [timer setFireDate:[NSDate distantFuture]];
        int b = ti%2;
        if (b == 1) {
            [self greatSearchVc];
            [self.devArray removeAllObjects];
            _myTableView.frame = CGRectMake(0, tableView_h, __MainScreen_Width, __mydeviese_tab_cell_h*(self.devArray.count));
            _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, _myTableView.frame.origin.y+_myTableView.frame.size.height+__Other_Height+10);
            [_myTableView reloadData];
        }else{
            self.devArray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
            _myTableView.frame = CGRectMake(0, tableView_h, __MainScreen_Width, __mydeviese_tab_cell_h*(self.devArray.count));
            _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, _myTableView.frame.origin.y+_myTableView.frame.size.height+__Other_Height+10);
            [_myTableView reloadData];
        }
        button.userInteractionEnabled = YES;
        [button setTitle:@"重新扫描" forState:UIControlStateNormal];
    });
     */
}


#pragma mark - 开启蓝牙扫描
-(void)_bgeinScan{
    
    //开始扫描返回设备列表
//    WEAK_SELF;
    [_jgBlueToothManager beginScanperipheralsWithResultPerials:^(NSArray *perialsArr) {
        [timer setFireDate:[NSDate distantFuture]];
        
//        top_img2.hidden = YES;
        _mylab.hidden = YES;
        self.devArray = [NSMutableArray arrayWithArray:perialsArr];
        _myTableView.frame = CGRectMake(0, tableView_h, __MainScreen_Width, __mydeviese_tab_cell_h*(self.devArray.count));
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, _myTableView.frame.origin.y+_myTableView.frame.size.height+__Other_Height+10);
        [_myTableView reloadData];
        button.userInteractionEnabled = YES;
        [button setTitle:@"重新扫描" forState:UIControlStateNormal];
        
    } falied:^(NSError *error) {
        
        [timer setFireDate:[NSDate distantFuture]];
        
        
        _mylab.hidden = NO;
        _mylab.text = error.domain;
        button.userInteractionEnabled = YES;
        if(error.code == 2)
        [button setTitle:@"重新扫描" forState:UIControlStateNormal];
        
        if (error.code == 1) {
            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"蓝牙已关闭，请开启蓝牙"];
        }
        

        NSLog(@"蓝牙设备错误:%@",error.domain);
        
    }];
    
//    [_jgBlueToothManager clearBanded];
}



//#pragma mark - 错误信息  懒加载
//-(UILabel *)blueToothErrorLabel{
//
//    if (_blueToothErrorLabel == nil) {
//        _blueToothErrorLabel = [[UILabel alloc] init];
//    }
//    
//    
//    return _blueToothErrorLabel;
//}


float angle=0;

-(void)loop
{
    x0 = button.center.x;
    y0= button.center.y;
    
    CGPoint sunPoint = CGPointMake(x0, y0);
    CGPoint point  = top_img2.center;
    
    
    button.center = sunPoint;
    
    int x=x0+R*sin(angle*3.1415/180);
    int y=y0-R*cos(angle*3.1415/180);
    
    angle+=5;
    
    if (angle >=360) {
        
        angle =0;
    }
    
    point.x =x;
    point.y =y;
    
    top_img2.center = point;
    
    //产生烟雾
    
    UIImageView *smoke=[[UIImageView alloc] initWithImage:top_img2.image];
    
    smoke.frame = top_img2.frame;
    
    smoke.alpha=0.5;
    
    [_myScrollView addSubview:smoke];
    
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
    
    RELEASE(smoke);
    
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imgv = (__bridge UIImageView*)context;
    
    [imgv removeFromSuperview];
    
//    [imgv release];
    
}

- (void)greatSearchVc
{
    _mylab.hidden = NO;
}

- (void)backToMain
{
//    _jgBlueToothManager.needToSyncState = DontNeedSyncState;
    [timer setFireDate:[NSDate distantFuture]];
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (self.isComminFromSelfVC) {//
        
        [app gogogoWithTag:2];
        
    }else if (self.isComminFromTheRing){
    
        [app gogogoWithTag:0];
    }
    else{
    
        if ([self.keyStr isEqualToString:@"oneVc"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if ([self.keyStr isEqualToString:@"setting"]){
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
