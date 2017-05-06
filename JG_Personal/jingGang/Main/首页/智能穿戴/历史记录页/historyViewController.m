//
//  historyViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "historyViewController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "NSDate+Utilities.h"
#import "UIViewExt.h"
#import "JGYearMonthDayCell.h"
#import "JGMonthHistoryController.h"

static int weekData[8] = {0,0,0,0,0,0,0,0};

#define line_View_h     145

@interface historyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView     *_myScrollview;
    UILabel          *titleLabel;
    UILabel          *_dateLab;
    
    VApiManager      *_vapManager;
    
    NSMutableArray   *_weekStepArr;
    NSMutableArray   *_weekKaluoliArr;
    NSMutableArray   *_weeklichengArr;
    

    SHLineGraphView *_lineGraph4,*_lineGraph5,*_lineGraph6;
    SHPlot          *_plot4,*_plot5,*_plot6;
    

    NSInteger         _totalStep;
    NSInteger         _totalKm;
    NSInteger         _totalKaluoli;
    
    NSString          *_totalSleepStr;
    NSString          *_deepSleepStr;
    NSString          *_lightSleepStr;
    
    
    NSString        *beginDatestr;
    NSString        *endDateStr;
}
@property (nonatomic,strong) UITableView *tableView;
/**
 *  年月日数组
 */
@property (nonatomic,strong) NSArray *arrayYearMonthDay;
/**
 *  背景半透黑View
 */
@property (nonatomic,strong) UIView *bgBlackView;
@property (nonatomic,assign) BOOL isTableViewTypeDisplay;
@end

@implementation historyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    titleLabel.text = @"历史纪录";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _vapManager = [[VApiManager alloc] init];
    
    [self _requestSleepAndMotionData];
//    
//    weekData[7] = {0,0,0,0,0,0,0};
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, __NavScreen_Height-2, __MainScreen_Width, 3)];
    topView.backgroundColor = [UIColor colorWithRed:90.0/255 green:196.0/255 blue:241.0/255 alpha:1];
    [self.navigationController.navigationBar addSubview:topView];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    //    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;


    self.navigationItem.rightBarButtonItem = [self rightButton];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * date_View = [[UIView alloc]init];
    date_View.frame = CGRectMake(0, 0, __MainScreen_Width, 50);
    date_View.backgroundColor = [UIColor colorWithRed:90.0/255 green:196.0/255 blue:241.0/255 alpha:1];
    [self.view addSubview:date_View];

    
    _dateLab = [[UILabel alloc]init];
    _dateLab.font = [UIFont systemFontOfSize:15];
    _dateLab.frame = CGRectMake(15, 0, __MainScreen_Width, 15);
    _dateLab.text = @"2015/06/28-2015/07/04";
    _dateLab.textColor = [UIColor whiteColor];
    [date_View addSubview:_dateLab];
    
    float spase_x = __MainScreen_Width/7;
    float spase_y = _dateLab.frame.origin.y+_dateLab.frame.size.height;
    NSArray * array = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    for (int i = 0; i < 7; i ++) {
        UILabel * lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(spase_x*i, spase_y+10, spase_x, 20);
        lab.textColor = [UIColor whiteColor];
        lab.text = [array objectAtIndex:i];
        lab.textAlignment = NSTextAlignmentCenter;
        [date_View addSubview:lab];

    }
    
    float h1 = date_View.frame.size.height;
    
    _myScrollview = [[UIScrollView alloc]init];
    _myScrollview.frame = CGRectMake(0, h1, __MainScreen_Width, __MainScreen_Height);
    [self.view addSubview:_myScrollview];
    if (__MainScreen_Height == 480) {
        _myScrollview.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height+100);
    }else{
        _myScrollview.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height);
    }
}


#pragma mark - 请求运动，睡眠数据
-(void)_requestSleepAndMotionData{
    
    if (self.histoyeType == StepHistory_Type){//运动数据
        [self _requestWeekStepData];
    }else{//睡眠数据
        [self _requestWeekSleepData];
    }
}

#pragma mark - 一周运动数据
-(void)_requestWeekStepData{

    EquipWeekQueryRequest *request = [[EquipWeekQueryRequest alloc] init:GetToken];
    [_vapManager equipWeekQuery:request success:^(AFHTTPRequestOperation *operation, EquipWeekQueryResponse *response) {
        
        _totalStep = [response.stepNumber integerValue];
        _totalKm = [response.distance integerValue];
        _totalKaluoli = [response.calories integerValue];

        NSLog(@"%@",response.weekStep);
        //对返回数据进行处理 100比
        [self _dealWithResponseData:response.weekStep];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        NSLog(@"呵呵");
    }];

}


#pragma mark - 一周睡眠数据
-(void)_requestWeekSleepData{
    EquipSleepWeekRequest *request = [[EquipSleepWeekRequest alloc] init:GetToken];
    [_vapManager equipSleepWeek:request success:^(AFHTTPRequestOperation *operation, EquipSleepWeekResponse *response) {
        NSLog(@"%@",response.sleeps);
        _totalSleepStr = [self getTimeBySecends:[response.sleepRecordBO.sleepSecond integerValue]];
        _deepSleepStr = [self getTimeBySecends:[response.sleepRecordBO.deepSleepSecond integerValue]];
        _lightSleepStr = [self getTimeBySecends:[response.sleepRecordBO.shallowSleepSecond integerValue]];
        
        [self _dealWithResponseData:response.sleeps];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

-(NSString *)getTimeBySecends:(NSInteger)secends{
    
    
    NSInteger hour = secends / 3600;
    NSInteger minute = secends / 60;

    return [NSString stringWithFormat:@"%02ld:%02ld:00",hour,minute];
    
}//根据分钟返回时间字符串


//@property (nonatomic, readonly, copy) NSNumber *apiId;
////用户id
//@property (nonatomic, readonly, copy) NSNumber *uid;
////步数
//@property (nonatomic, readonly, copy) NSNumber *stepNumber;
////时间
//@property (nonatomic, readonly, copy) NSDate *recordDate;
////里程
//@property (nonatomic, readonly, copy) NSNumber *totalKm;
////卡路里
//@property (nonatomic, readonly, copy) NSNumber *calories;
////星期
//@property (nonatomic, readonly, copy) NSNumber *week;
//

/*
 @property (nonatomic, readonly, copy) NSNumber *sleepSecond;
	//深睡时长
	@property (nonatomic, readonly, copy) NSNumber *deepSleepSecond;
	//浅睡时长
	@property (nonatomic, readonly, copy) NSNumber *shallowSleepSecond;
	//星期
 */


#pragma mark - 对返回数据进行处理
-(void)_dealWithResponseData:(NSArray *)arr{

    _weekKaluoliArr = [NSMutableArray arrayWithCapacity:7] ;
    _weeklichengArr = [NSMutableArray arrayWithCapacity:7] ;
    _weekStepArr    = [NSMutableArray arrayWithCapacity:7] ;
    
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithCapacity:7];
    NSDictionary *firstDic =  (NSDictionary *)arr[0];
    
//    NSDictionary *endDic = (NSDictionary *)[arr lastObject];
//    NSDate *firstdate = firstDic[@"recordDate"];
//    NSDate *enddate = endDic[@"recordDate"];
//    
//    
//    NSInteger week = [endDic[@"week"] integerValue];
//    if (week == 0) {
//        week = 7;
//    }
//
    
    
    NSString *startDate = firstDic[@"startDate"];
    NSString *endDate = firstDic[@"endDate"];
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
//    NSString *weekBeginStr  = [dateFormatter stringFromDate:startDate];
//    NSString *weekEndStr  = [dateFormatter stringFromDate:endDate];
    if (startDate) {
        _dateLab.text = [NSString stringWithFormat:@"%@-%@",startDate,endDate];
    }
    
    
    
    
    
    //先打标志，，那几个星期没有，有
    for (NSDictionary *userStepDic in arr) {
        NSNumber *weekNum = userStepDic[@"week"];
        if (weekNum.intValue == 0) {//如果是星期天，就把数字置7
            weekNum = @7;
        }
        
        int week = [weekNum intValue];
        //1表示有星期几
        weekData[week] = 1;
        NSString *key = [NSString stringWithFormat:@"%d",week];
        [muDic setObject:userStepDic forKey:key];
        
    }
    
    NSString *key1 = nil;
    NSString *key2 = nil;
    NSString *key3 = nil;
    
    if (self.histoyeType == StepHistory_Type) {
    
        key1 = @"stepNumber";
        key2 = @"totalKm";
        key3 = @"calories";
        
    }else{
        
        key1 = @"sleepSecond";
        key2 = @"deepSleepSecond";
        key3 = @"shallowSleepSecond";
    }
    
    
    NSInteger totalStep,totalkm,totalCaluoli;
    totalStep = totalkm = totalCaluoli = 0;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i=1; i<=7; i++) {
        
        if (weekData[i]==1) {
            NSString *key = [NSString stringWithFormat:@"%ld",i];
            NSDictionary *userStepDic = [muDic objectForKey:key];
            
            NSNumber *stepNumber = [self dealTheNumberwithNumber:userStepDic[key1]];
            NSNumber *totalKm = [self dealTheNumberwithNumber:userStepDic[key2]];
            NSNumber *calories = [self dealTheNumberwithNumber:userStepDic[key3]];
            
            
            
//            totalStep += [stepNumber intValue];
//            totalkm += [totalKm intValue];
//            totalCaluoli += [calories intValue];
            NSNumber *number = [NSNumber numberWithInteger:(i * 10)];
            [tempArray addObject:number];
//            
            NSDictionary *stepDic = @{@(i):stepNumber};
            NSDictionary *totalKmDic = @{@(i):totalKm};
            NSDictionary *caloriesDic = @{@(i):calories};
            
            [_weekStepArr addObject:stepDic];
            [_weeklichengArr addObject:totalKmDic];
            [_weekKaluoliArr addObject:caloriesDic];
            

        }else{
            
            NSDictionary *stepDic = @{@(i):@0};
            NSDictionary *totalKmDic = @{@(i):@0};
            NSDictionary *caloriesDic = @{@(i):@0};
            
            [_weekStepArr addObject:stepDic];
            [_weeklichengArr addObject:totalKmDic];
            [_weekKaluoliArr addObject:caloriesDic];
            
        }
    }
    

    
//    //总步数
//    _totalStep = totalStep;
//    //总km
//    _totalKm = totalkm;
//    //总卡洛里
//    _totalKaluoli = totalCaluoli;
    
    
    [self greatline];
    
    JGLog(@"%@",[self compositorArrayMostValus:tempArray]);

}



#pragma mark - 以100比例处理
-(NSNumber *)dealTheNumberwithNumber:(NSNumber *)number{

    NSInteger value = [number integerValue];
    if (value > 100 && value <= 1000) {
        value = (value * 1.0 / 1000 ) * 100;
    }else if (value > 1000 && value <= 10000 ){
        value = (value * 1.0 / 10000) * 100;
    }else if ( value > 10000 && value<= 100000){
        value = (value * 1.0/ 100000) * 100;
    }else if (value > 100000 && value <= 1000000){
        value = (value * 1.0/ 1000000) * 100;
    }
    
    NSNumber *newNumber = @(value);

    return newNumber;
}

- (void)greatline
{
    for (int i = 0; i < 3; i ++) {
        UIView * name_view = [[UIView alloc]init];//name_view-->每个折线图顶头view
        name_view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
        UIImageView * left_img = [[UIImageView alloc]init];
        left_img.frame = CGRectMake(10, 5, 20, 20);
        [name_view addSubview:left_img];

        UILabel * name_lab = [[UILabel alloc]init];
        name_lab.frame = CGRectMake(left_img.frame.origin.x+left_img.frame.size.width+10, 5, 60, 20);
    
        if (i == 2) {
            name_lab.frame = CGRectMake(left_img.frame.origin.x+left_img.frame.size.width+10, 5, 70, 20);
        }
        if (self.histoyeType == SleepHistory_Type) {//睡眠历史的话
            name_lab.width = 100;
        }
        [name_view addSubview:name_lab];

        
        UILabel * num_lab = [[UILabel alloc]init];
        num_lab.textColor = [UIColor colorWithRed:248.0/255 green:48.0/255 blue:48.0/255 alpha:0.8];
        num_lab.frame = CGRectMake(name_lab.frame.origin.x+name_lab.frame.size.width-10, 5, 200, 20);
        [name_view addSubview:num_lab];
        
        [_myScrollview addSubview:name_view];
        if (i == 0) {
            name_view.frame = CGRectMake(0, i*(30+line_View_h), __MainScreen_Width, 30);
            if (self.histoyeType == StepHistory_Type) {//运动
                
                left_img.image = [UIImage imageNamed:@"test_step"];
                name_lab.text = @"步数：";
                num_lab.text = [NSString stringWithFormat:@"%ldSteps",_totalStep];
            }else{
                //home_sleep03
                left_img.image = [UIImage imageNamed:@"home_sleep03"];
                name_lab.text = @"睡眠时长：";
                num_lab.text = _totalSleepStr;
        
            }
            _lineGraph4 = [[SHLineGraphView alloc] init];
            _lineGraph4.witch = 1;
            _lineGraph4.backgroundColor = [UIColor clearColor];
            _lineGraph4.frame = CGRectMake(-50, name_view.frame.origin.y+name_view.frame.size.height, __MainScreen_Width+50, line_View_h);
            NSDictionary *_themeAttributes = @{
                                               kXAxisLabelColorKey : [UIColor clearColor],
                                               kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelColorKey : [UIColor clearColor],
                                               kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelSideMarginsKey : @20,
                                               kPlotBackgroundLineColorKye : [UIColor clearColor]
                                               };
            _lineGraph4.themeAttributes = _themeAttributes;
            _lineGraph4.yAxisRange = @(98);
            _lineGraph4.yAxisSuffix = @"K";
            _lineGraph4.xAxisValues = _weekStepArr;
//  @[
//                                        @{ @1 : @"JAN" },
//                                        @{ @2 : @"FEB" },
//                                        @{ @3 : @"MAR" },
//                                        @{ @4 : @"APR" },
//                                        @{ @5 : @"MAY" },
//                                        @{ @6 : @"JUN" },
//                                        @{ @7 : @"JUL" },
//                                        @{ @8 : @"JUL" },
//                                        @{ @9 : @"JUL" },
//                                        ];
            _plot4 = [[SHPlot alloc] init];
            _plot4.plottingValues = _weekStepArr;
            NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7",];
            _plot4.plottingPointsLabels = arr;
            NSDictionary *_plotThemeAttributes = @{
                                                   kPlotFillColorKey : [UIColor colorWithRed:201.0/255 green:241.0/255 blue:238.0/255 alpha:1],
                                                   kPlotStrokeWidthKey : @2,
                                                   kPlotStrokeColorKey : status_color,
                                                   kPlotPointFillColorKey : [UIColor colorWithRed:77.0/255 green:208.0/255 blue:200.0/255 alpha:1],
                                                   kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                                   };
            
            _plot4.plotThemeAttributes = _plotThemeAttributes;
            [_lineGraph4 addPlot:_plot4];
            
            [_lineGraph4 setupTheView];
            
            [_myScrollview addSubview:_lineGraph4];
        }else if (i == 1)
        {
            name_view.frame = CGRectMake(0, i*(30+line_View_h)-30, __MainScreen_Width, 30);
            if (self.histoyeType == StepHistory_Type) {
                left_img.image = [UIImage imageNamed:@"test_km"];
                name_lab.text = @"里程：";
                num_lab.text = [NSString stringWithFormat:@"%ldKm",_totalKm];
            }else{
                left_img.image = [UIImage imageNamed:@"home_deep_sleep03"];
                name_lab.text = @"深度睡眠：";
                num_lab.text = _deepSleepStr;
            }
            
            
           
            _lineGraph5 = [[SHLineGraphView alloc] init];
            _lineGraph5.witch = 2;
            _lineGraph5.backgroundColor = [UIColor clearColor];
            _lineGraph5.frame = CGRectMake(-50, name_view.frame.origin.y+name_view.frame.size.height, __MainScreen_Width+50, line_View_h);
            NSDictionary *_themeAttributes = @{
                                               kXAxisLabelColorKey : [UIColor clearColor],
                                               kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelColorKey : [UIColor clearColor],
                                               kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelSideMarginsKey : @20,
                                               kPlotBackgroundLineColorKye : [UIColor clearColor]
                                               };
            _lineGraph5.themeAttributes = _themeAttributes;
            _lineGraph5.yAxisRange = @(98);
            _lineGraph5.yAxisSuffix = @"K";
            
            _plot5 = [[SHPlot alloc] init];
            _lineGraph5.xAxisValues = _weeklichengArr;
            _plot5.plottingValues = _weeklichengArr;
            NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7"];
            _plot5.plottingPointsLabels = arr;
            NSDictionary *_plotThemeAttributes = @{
                                                   kPlotFillColorKey : [UIColor colorWithRed:223.0/255 green:246.0/255 blue:237.0/255 alpha:1],
                                                   kPlotStrokeWidthKey : @2,
                                                   kPlotStrokeColorKey : [UIColor colorWithRed:131.0/255 green:223.0/255 blue:182.0/255 alpha:1],
                                                   kPlotPointFillColorKey : [UIColor colorWithRed:131.0/255 green:223.0/255 blue:182.0/255 alpha:1],
                                                   kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                                   };
            
            _plot5.plotThemeAttributes = _plotThemeAttributes;
            [_lineGraph5 addPlot:_plot5];
            
            [_lineGraph5 setupTheView];
            
            [_myScrollview addSubview:_lineGraph5];
        }else if (i == 2){
            name_view.frame = CGRectMake(0, i*(30+line_View_h)-60, __MainScreen_Width, 30);
           
            if (self.histoyeType == StepHistory_Type) {
                
                left_img.image = [UIImage imageNamed:@"test_kcal"];
                name_lab.text = @"卡路里：";
                num_lab.text = [NSString stringWithFormat:@"%ldKcal",_totalKaluoli];

            }else{
                
                left_img.image = [UIImage imageNamed:@"home_sha_sleep03"];
                name_lab.text = @"浅度睡眠：";
                num_lab.text = _lightSleepStr;
                
            }
            
            
            _lineGraph6 = [[SHLineGraphView alloc] init];
            _lineGraph6.witch = 3;
            _lineGraph6.backgroundColor = [UIColor clearColor];
            _lineGraph6.frame = CGRectMake(-50, name_view.frame.origin.y+name_view.frame.size.height, __MainScreen_Width+50, line_View_h);
            NSDictionary *_themeAttributes = @{
                                               kXAxisLabelColorKey : [UIColor clearColor],
                                               kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelColorKey : [UIColor clearColor],
                                               kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelSideMarginsKey : @20,
                                               kPlotBackgroundLineColorKye : [UIColor clearColor]
                                               };
            _lineGraph6.themeAttributes = _themeAttributes;
            _lineGraph6.yAxisRange = @(98);
            _lineGraph6.yAxisSuffix = @"K";
            _lineGraph6.xAxisValues = @[
                                        @{ @1 : @"JAN" },
                                        @{ @2 : @"FEB" },
                                        @{ @3 : @"MAR" },
                                        @{ @4 : @"APR" },
                                        @{ @5 : @"MAY" },
                                        @{ @6 : @"JUN" },
                                        @{ @7 : @"JUL" }
                                        ];
            _plot6 = [[SHPlot alloc] init];
            _plot6.plottingValues = _weekKaluoliArr;
            NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7"];
            _plot6.plottingPointsLabels = arr;
            NSDictionary *_plotThemeAttributes = @{
                                                   kPlotFillColorKey : [UIColor colorWithRed:253.0/255 green:231.0/255 blue:220.0/255 alpha:1],
                                                   kPlotStrokeWidthKey : @2,
                                                   kPlotStrokeColorKey : [UIColor colorWithRed:248.0/255 green:150.0/255 blue:121.0/255 alpha:1],
                                                   kPlotPointFillColorKey : [UIColor colorWithRed:248.0/255 green:150.0/255 blue:121.0/255 alpha:1],
                                                   kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                                   };
            
            _plot6.plotThemeAttributes = _plotThemeAttributes;
            [_lineGraph6 addPlot:_plot6];
            
            [_lineGraph6 setupTheView];
            
            [_myScrollview addSubview:_lineGraph6];
        }
        
        RELEASE(num_lab);
        RELEASE(name_view);
    }
}



#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayYearMonthDay.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifile = @"yearMonthDayCell";
    JGYearMonthDayCell *cell = (JGYearMonthDayCell *)[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JGYearMonthDayCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    
    cell.labelYearMonthDay.text = [self.arrayYearMonthDay xf_safeObjectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //年月记录共用一个Controller
    JGMonthHistoryController *monthHistoryVC = [[JGMonthHistoryController alloc]init];
    monthHistoryVC.historyViewController.histoyeType = self.histoyeType;
    monthHistoryVC.strTitle = self.arrayYearMonthDay[indexPath.row];
    if (indexPath.row == 0) {
        monthHistoryVC.yearMonthHistoyeType = yearHistoryType;
        [self.navigationController pushViewController:monthHistoryVC animated:YES];
    }else if (indexPath.row == 1){
        monthHistoryVC.yearMonthHistoyeType = monthHistoryType;
        [self.navigationController pushViewController:monthHistoryVC animated:YES];
    }else if (indexPath.row == 2){
    
    }
    [self removeTableViewType];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


//右侧按钮
- (UIBarButtonItem *)rightButton
{
    UIButton *navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightButton.frame= CGRectMake(0, 0, 70, 36);
    
    [navRightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 3, 17)];
    imageView.image = [UIImage imageNamed:@"icon_menu"];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 70, 36)];
    view.backgroundColor = [UIColor clearColor];
    
    [view addSubview:imageView];
    [view addSubview:navRightButton];
    //为了解决按钮过小问题，加了一个透明的大按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    return item;
}


#pragma mark - private
//tableview的线补齐
- (void)tableViewLineRepair:(UITableView *)tableView{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)rightButtonClick
{
    

    if (!self.isTableViewTypeDisplay) {
        [self.view addSubview:self.bgBlackView];
        [self.view addSubview:self.tableView];
        [self popupTableViewType];
        
    }else{
        [self removeTableViewType];
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeTableViewType];
}

//弹出类型选择tableview
- (void)popupTableViewType
{

    WEAK_SELF
    [UIView transitionWithView:self.tableView duration:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        weak_self.tableView.frame = CGRectMake(kScreenWidth - kScreenWidth/5, 0, kScreenWidth/5, 44 * weak_self.arrayYearMonthDay.count);
    } completion:^(BOOL finished) {
        weak_self.isTableViewTypeDisplay = YES;
    }];
    
}
//移除类型选择tableview
- (void)removeTableViewType
{
    WEAK_SELF
    [UIView transitionWithView:self.tableView duration:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        weak_self.tableView.frame = CGRectMake(kScreenWidth - kScreenWidth/5, 0, kScreenWidth/5, 0);
    } completion:^(BOOL finished) {
        [weak_self.bgBlackView removeFromSuperview];
        [weak_self.tableView removeFromSuperview];
        weak_self.isTableViewTypeDisplay = NO;
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth - kScreenWidth/5, 0, kScreenWidth/4, 0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.scrollEnabled = NO;

    }
    return _tableView;
}
- (NSArray *)arrayYearMonthDay
{

    if (!_arrayYearMonthDay) {
        _arrayYearMonthDay = [NSArray arrayWithObjects:@"年",@"月",@"日", nil];
}
    return _arrayYearMonthDay;
}
- (UIView *)bgBlackView
{
    if (!_bgBlackView) {
        _bgBlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgBlackView.backgroundColor = [UIColor blackColor];
        _bgBlackView.alpha = 0.5;
    }
    return _bgBlackView;
}

//算出数组中最大的数值并返回
- (NSNumber *)compositorArrayMostValus:(NSArray *)array
{
    NSMutableArray *arrayCompositor = array.copy;
    for (NSInteger i = 0; i<[arrayCompositor count]; i++)
    {
        for (NSInteger j=i+1; j<[arrayCompositor count]; j++)
        {
            NSInteger a = [[arrayCompositor objectAtIndex:i] integerValue];
            
            NSInteger b = [[arrayCompositor objectAtIndex:j] integerValue];
            if (a > b)
            {
                [arrayCompositor replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%ld",b]];
                [arrayCompositor replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%ld",a]];
            }
            
        }
        
    }
    for (NSInteger i = 0; i<array.count; i++)
    {
        NSLog(@"%@",[array objectAtIndex:i]);
    }
    
    NSInteger resutlsInteger = [[array lastObject] integerValue];
    
    return [NSNumber numberWithInteger:resutlsInteger];

    
}

- (void)backToMain
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
