//
//  JGMonthHistoryController.m
//  jingGang
//
//  Created by HanZhongchou on 16/2/26.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGMonthHistoryController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "NSDate+Utilities.h"
#import "UIViewExt.h"
#import "JGYearMonthDayCell.h"
#import "JGMonthHistoryController.h"
#import "historyViewController.h"

//static int weekData[8] = {0,0,0,0,0,0,0,0};

#define line_View_h     145

@interface JGMonthHistoryController ()
{
    UIScrollView     *_myScrollview;
    UILabel          *_dateLab;
    
    VApiManager      *_vapManager;
    
    NSMutableArray   *_monthStepArr;
    NSMutableArray   *_monthKaluoliArr;
    NSMutableArray   *_monthlichengArr;
    
    
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
/**
 *  步数最大值
 */
@property (nonatomic,assign) NSInteger stepMax;
/**
 *  里程最大值
 */
@property (nonatomic,assign) NSInteger kmMax;
/**
 *  卡路里最大值
 */
@property (nonatomic,assign) NSInteger calories;

@end

@implementation JGMonthHistoryController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _vapManager = [[VApiManager alloc] init];
    
    [self _requestSleepAndMotionData];

    self.navigationItem.title = [NSString stringWithFormat:@"%@记录",self.strTitle];
    
    
    
//    self.navigationItem.rightBarButtonItem = [self rightButton];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * date_View = [[UIView alloc]init];
    date_View.frame = CGRectMake(0, 0, __MainScreen_Width, 50);
    date_View.backgroundColor = [UIColor colorWithRed:90.0/255 green:196.0/255 blue:241.0/255 alpha:1];
    [self.view addSubview:date_View];
    
    
    _dateLab = [[UILabel alloc]init];
    _dateLab.font = [UIFont systemFontOfSize:15];
    _dateLab.frame = CGRectMake(15, 0, __MainScreen_Width, 15);
    
    
    NSDateComponents *comps = [self getDateInfo];
    NSInteger numberDayInMonth = [self getNumberOfDaysInMonth];
    _dateLab.text = [NSString stringWithFormat:@"%ld/%ld/01-%ld/%ld/%ld",comps.year,comps.month,comps.year,comps.month,numberDayInMonth];
    _dateLab.textColor = [UIColor whiteColor];
    [date_View addSubview:_dateLab];
    
    
    float spase_y = _dateLab.frame.origin.y+_dateLab.frame.size.height;
    NSArray * array;
    if (self.yearMonthHistoyeType == monthHistoryType) {
        //月记录
        array = [NSArray arrayWithObjects:@"1",@"5",@"10",@"15",@"20",@"25",@"30", nil];
        _dateLab.text = [NSString stringWithFormat:@"%ld/%ld/01-%ld/%ld/%ld",comps.year,comps.month,comps.year,comps.month,numberDayInMonth];

    }else{
        //年记录
        array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
        _dateLab.text = [NSString stringWithFormat:@"%ld/01/01-%ld/12/31",comps.year,comps.year];

    }
    float spase_x = __MainScreen_Width/array.count;
    for (int i = 0; i < array.count; i ++) {
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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.historyViewController.histoyeType == StepHistory_Type){//运动数据
        if (self.yearMonthHistoyeType == monthHistoryType) {
            [self _requestWeekStepData];
        }else{
            [self requestYearStepData];
        }
        
    }else{//睡眠数据
        [self _requestWeekSleepData];
    }
    
}
#pragma mark - 年运动数据
- (void)requestYearStepData
{
    EquipQueryMonByYearRequest *request = [[EquipQueryMonByYearRequest alloc]init:GetToken];
    //获取当前时间详情
    NSDateComponents *comps = [self getDateInfo];

    request.api_startDateStr = [NSString stringWithFormat:@"%ld-01-01",comps.year];
    request.api_endDateStr = [NSString stringWithFormat:@"%ld-12-31",comps.year];


    WeakSelf;
    [_vapManager equipQueryMonByYear:request success:^(AFHTTPRequestOperation *operation, EquipQueryMonByYearResponse *response) {
        StrongSelf;
        [strongSelf _dealWithResponseData:response.monthRecordList];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        StrongSelf;
        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        [MBProgressHUD showError:@"网络错误，请检查网络" toView:strongSelf.view delay:1];
    }];
}


#pragma mark - 月运动数据
-(void)_requestWeekStepData{

    EquipQueryByRangeRequest *request = [[EquipQueryByRangeRequest alloc]init:GetToken];
    //获取当前时间详情
    NSDateComponents *comps = [self getDateInfo];
    //获取当月总天数
    NSInteger numberDayInMonth = [self getNumberOfDaysInMonth];
    
    request.api_startDateStr = [NSString stringWithFormat:@"%ld-%ld-01",comps.year,comps.month];
    request.api_endDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",comps.year,comps.month,numberDayInMonth];

    
    WEAK_SELF
    [_vapManager equipQueryByRange:request success:^(AFHTTPRequestOperation *operation, EquipQueryByRangeResponse *response) {
        
        _totalStep = [response.totalStepNumber integerValue];
        _totalKm = [response.totalDistance integerValue];
        _totalKaluoli = [response.totalCalories integerValue];
        

        [weak_self _dealWithResponseData:response.rangeSteps];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        [MBProgressHUD showSuccess:@"网络错误，请检查网络后重试" toView:weak_self.view delay:1];
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



#pragma mark - 对返回数据进行处理
-(void)_dealWithResponseData:(NSArray *)arr{
    
    _monthKaluoliArr = [NSMutableArray array];
    _monthlichengArr = [NSMutableArray array];
    _monthStepArr    = [NSMutableArray array];
    
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    
    
    
    NSString *key1 = nil;
    NSString *key2 = nil;
    NSString *key3 = nil;
    
    if (self.historyViewController.histoyeType == StepHistory_Type) {
        
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
    
    NSMutableArray *tempStepNumberArray = [NSMutableArray array];
    NSMutableArray *tempTotalKmArray = [NSMutableArray array];
    NSMutableArray *tempCaloriesArray = [NSMutableArray array];
    for (NSInteger i=1; i<=arr.count; i++) {
        
        NSString *key = [NSString stringWithFormat:@"%ld",i];
        NSDictionary *userStepDic = [muDic objectForKey:key];
        
        //取出每一条数据
        NSNumber *stepNumber = [self dealTheNumberwithNumber:userStepDic[key1]];
        NSNumber *totalKm = [self dealTheNumberwithNumber:userStepDic[key2]];
        NSNumber *calories = [self dealTheNumberwithNumber:userStepDic[key3]];
        
        
        //把每条数据加入临时数组，为了找出记录中最大的数值，以供折线图设置最大值,防止折线图跑出屏幕
        [tempStepNumberArray addObject:stepNumber];
        [tempTotalKmArray addObject:totalKm];
        [tempCaloriesArray addObject:calories];
        
        
        
        //把每一条数据做成字典加入数组，这样才能添加到折线图数组显示出来
        NSDictionary *stepDic = @{@(i):stepNumber};
        NSDictionary *totalKmDic = @{@(i):totalKm};
        NSDictionary *caloriesDic = @{@(i):calories};
            
        [_monthStepArr addObject:stepDic];
        [_monthlichengArr addObject:totalKmDic];
        [_monthKaluoliArr addObject:caloriesDic];
            
    }
    
    //算出三种记录中最大的一条数据
    self.stepMax = [self compositorArrayMostValus:tempStepNumberArray];
    self.kmMax = [self compositorArrayMostValus:tempTotalKmArray];
    self.calories = [self compositorArrayMostValus:tempCaloriesArray];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self greatline];
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
        if (self.historyViewController.histoyeType == SleepHistory_Type) {//睡眠历史的话
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
            if (self.historyViewController.histoyeType == StepHistory_Type) {//运动
                
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
            if (self.stepMax < 98) {
                _lineGraph4.yAxisRange = @(98);
            }else{
                _lineGraph4.yAxisRange = @(self.stepMax);
            }
            
            _lineGraph4.yAxisSuffix = @"K";
            _lineGraph4.xAxisValues = _monthStepArr;
            _plot4 = [[SHPlot alloc] init];
            _plot4.plottingValues = _monthStepArr;
            NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
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
            if (self.historyViewController.histoyeType == StepHistory_Type) {
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
            if (self.kmMax < 98) {
                _lineGraph5.yAxisRange = @(98);
            }else{
                _lineGraph5.yAxisRange = @(self.kmMax);
            }
            
            _lineGraph5.yAxisSuffix = @"K";
            
            _plot5 = [[SHPlot alloc] init];
            _lineGraph5.xAxisValues = _monthlichengArr;
            _plot5.plottingValues = _monthlichengArr;
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
            
            if (self.historyViewController.histoyeType == StepHistory_Type) {
                
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
            if (self.calories < 98) {
                _lineGraph6.yAxisRange = @(98);
            }else{
                _lineGraph6.yAxisRange = @(self.calories);
            }
            
            _lineGraph6.yAxisSuffix = @"K";
            _lineGraph6.xAxisValues = _monthKaluoliArr;
            _plot6 = [[SHPlot alloc] init];
            _plot6.plottingValues = _monthKaluoliArr;
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
#pragma mark -- 获取指定日期的年，月，日，星期，时,分,秒信息
- (NSDateComponents *)getDateInfo
{

    NSDate * date  = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    return comps;
}
#pragma mark --算出当前月一共有多少天
- (NSInteger)getNumberOfDaysInMonth
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDate * currentDate = [NSDate date];
    // 只要个时间给日历,就会帮你计算出来。这里的时间取当前的时间。
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit: NSMonthCalendarUnit
                                  forDate:currentDate];
    return range.length;
}

//算出数组中最大的数值并返回
- (NSInteger)compositorArrayMostValus:(NSArray *)array
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
    
    NSInteger resutlsInteger = [[array lastObject] integerValue];
    
    return resutlsInteger;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
