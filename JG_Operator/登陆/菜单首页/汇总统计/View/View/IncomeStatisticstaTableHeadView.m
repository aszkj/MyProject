//
//  IncomeStatisticstaTableHeadView.m
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/10/30.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "IncomeStatisticstaTableHeadView.h"
#import "Global.h"
#import "IncomeStatisticsViewController.h"




#define SelectWeek               7 *24 *60 * 60
//#define SelectMonth             30 *24 *60 * 60
//#define SelectQuarter           90 *24 *60 * 60
//#define SelectMidyear          180 *24 *60 * 60
//#define SelectYear             365 *24 *60 * 60

@interface IncomeStatisticstaTableHeadView()
@property (nonatomic,strong) UITextField *textFieldStartTime; //开始时间textfield
@property (nonatomic,strong) UITextField *textFieldOverTime;  //结束时间textField
@property (nonatomic,strong) UIDatePicker *datePickerStart;   //开始datePicker
@property (nonatomic,strong) UIDatePicker *datePickerOver;    //结束datePicker

;
@end
@implementation IncomeStatisticstaTableHeadView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self loadUI];
}
//#pragma mark - Delegate
//#pragma mark - UITableViewDelegate
//
//#pragma mark - private
//
//#pragma mark - action
//
//#pragma mark - getter


#pragma mark - private
- (void)loadUI
{
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
//    
//    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
//    
//    NSInteger iCurYear = [components year];  //当前的年份
//    
//    NSInteger iCurMonth = [components month];  //当前的月份
//    
//    NSInteger iCurDay = [components day];  // 当前的号数
//    
//    NSString  *dateStr = nil;
//    NSMutableArray *arr = [NSMutableArray array];
//    
//    for (NSInteger i = 1; i <= iCurDay; i++) {
//        dateStr  = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)iCurYear, (long)iCurMonth, (long)i];
//        [arr addObject:dateStr];
//    }
//    NSLog(@"%@",arr);
    
    //单位
    UILabel *labelUnits = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 140, 17)];
    labelUnits.textColor = KColorText666666;
    labelUnits.text = @"统计信息 (单位：云币)";
    labelUnits.font = kFontSize13;
    [self addSubview:labelUnits];
    
    //时间段统计label
    CGFloat labelTimeStatisticsY = CGRectGetMaxY(labelUnits.frame) + 6;
    UILabel *labelTimeStatistics = [[UILabel alloc]initWithFrame:CGRectMake(10, labelTimeStatisticsY, 66, 17)];
    labelTimeStatistics.text = @"时间段统计";
    labelTimeStatistics.textColor = KColorText666666;
    labelTimeStatistics.font = kFontSize13;
    [self addSubview:labelTimeStatistics];
    
    //时间段选择BgView
    CGFloat viewSelectTimeX = CGRectGetMaxX(labelTimeStatistics.frame) + 4;
    UIView *viewSelectTime = [[UIView alloc]initWithFrame:CGRectMake(viewSelectTimeX, labelTimeStatisticsY, kScreenWidth - viewSelectTimeX - 67, 27)];
    viewSelectTime.backgroundColor = rgb(241, 242, 244, 1);
    viewSelectTime.layer.borderWidth = 1;
    viewSelectTime.layer.borderColor = [rgb(215, 217, 218, 1) CGColor];
    [self addSubview:viewSelectTime];
    //设置时间段统计label的center.x
    CGPoint labelTimeStatusticsPoint = labelTimeStatistics.center;
    labelTimeStatusticsPoint.y = viewSelectTime.center.y;
    labelTimeStatistics.center = labelTimeStatusticsPoint;
    
    //选择后设置的时间段label
    self.labelSelectLater = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, viewSelectTime.frame.size.width - 8 - 22, 27)
                                 ];
    self.labelSelectLater.text = @"本周统计";
    self.labelSelectLater.font = kFontSize13;
    self.labelSelectLater.textColor = KColorText666666;
    [viewSelectTime addSubview:self.labelSelectLater];
    
    //向下的小箭头
    UIImageView *imageViewArrDown = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelSelectLater.frame) - 4 , 0, 24, 27)];
    imageViewArrDown.image = [UIImage imageNamed:@"arr_dowe_icon"];
    [viewSelectTime addSubview:imageViewArrDown];
    
    //选择时间段的button
    UIButton *buttonSelectTime = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSelectTime.frame = CGRectMake(0, 0, viewSelectTime.frame.size.width, viewSelectTime.frame.size.height);
    [buttonSelectTime addTarget:self action:@selector(selectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [viewSelectTime addSubview:buttonSelectTime];
    
    
    
    //确定按钮
    UIButton *buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonConfirmX = CGRectGetMaxX(viewSelectTime.frame) + 6;
    buttonConfirm.frame = CGRectMake(buttonConfirmX, viewSelectTime.frame.origin.y, 52, 60);
    buttonConfirm.backgroundColor = KColorText59C4F0;
    [buttonConfirm setTitle:@"确定" forState:UIControlStateNormal];
    [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonConfirm.titleLabel.font = kFontSize15;
    [buttonConfirm addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonConfirm];
    
    //开始时间textfield
    CGFloat textFieldY = CGRectGetMaxY(viewSelectTime.frame) + 5;
    //6为确定按钮与统计View的距离，7为两个时间选择textfield的距离，20是开始时间textfield的x与确定按钮距离右边屏幕边的距离。除2=textfield的宽度，此目的是为了保持两个textfield宽度保持一致
    CGFloat textFieldWidth = (kScreenWidth - buttonConfirm.frame.size.width - 6 - 7 - 20) / 2;
    self.textFieldStartTime = [[UITextField alloc]initWithFrame:CGRectMake(10, textFieldY, textFieldWidth, 27)];
    self.textFieldStartTime.layer.borderWidth = 1;
    self.textFieldStartTime.layer.borderColor = [rgb(215, 217, 218, 1) CGColor];
    self.textFieldStartTime.backgroundColor = rgb(241, 242, 244, 1);
    self.textFieldStartTime.text = [self stringFromDate:[[NSDate date] initWithTimeInterval:-(SelectWeek)  sinceDate:self.datePickerStart.date]];
    
    self.textFieldStartTime.textColor = KColorText666666;
    self.textFieldStartTime.textAlignment = NSTextAlignmentCenter;
    self.textFieldStartTime.font = kFontSize13;

    self.textFieldStartTime.inputView = self.datePickerStart;
    [self addSubview:self.textFieldStartTime];
    
    //结束时间
    CGFloat textFieldOverTimeX = CGRectGetMaxX(self.textFieldStartTime.frame) + 7;
    self.textFieldOverTime = [[UITextField alloc]initWithFrame:CGRectMake(textFieldOverTimeX, textFieldY, textFieldWidth, 27)];
    self.textFieldOverTime.layer.borderWidth = 1;
    self.textFieldOverTime.layer.borderColor = [rgb(215, 217, 218, 1) CGColor];
    self.textFieldOverTime.backgroundColor = rgb(241, 242, 244, 1);
    //默认比初始日期多7天
    self.textFieldOverTime.text = [self stringFromDate:[NSDate date]];
    self.textFieldOverTime.textColor = KColorText666666;
    self.textFieldOverTime.textAlignment = NSTextAlignmentCenter;
    self.textFieldOverTime.font = kFontSize13;
    
    self.textFieldOverTime.inputView = self.datePickerOver;
    [self addSubview:self.textFieldOverTime];
    
    
}

/**
 *  转换日期为字符串类型
 *
 */
#warning 可以后写到NSString分类
- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}

#pragma mark - action
/**
 *  开始时间datePicker时间变动调用方法
 */
- (void)datePickerStartValueChanged
{
    self.textFieldStartTime.text = [self stringFromDate:self.datePickerStart.date];
}
/**
 *  结束时间datePickerOver时间变动调用方法
 */
- (void)datePickerOverValueChanged
{
    self.textFieldOverTime.text = [self stringFromDate:self.datePickerOver.date];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
/**
 *  选择时段按钮
 */
- (void)selectButtonClick
{
    if([self.delegate respondsToSelector:@selector(NofitiCationSelectButtonClick)])
    {
        return [self.delegate NofitiCationSelectButtonClick];
    }
}
/**
 *  确定按钮
 */
- (void)confirmButtonClick
{
    if ([self.delegate respondsToSelector:@selector(NofitiCationConfirmButtonClikStartTimeWith:overTime:)]) {
        NSString *strStartTime = [NSString stringWithFormat:@"%@",self.textFieldStartTime.text];
        NSString *strOverTime  = [NSString stringWithFormat:@"%@",self.textFieldOverTime.text];
        return [self.delegate NofitiCationConfirmButtonClikStartTimeWith:strStartTime overTime:strOverTime];
    }
    

}

//- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
//{
//    //设置源日期时区
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
//    //设置转换后的目标日期时区
//    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    //得到源日期与世界标准时间的偏移量
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
//    //目标日期与本地时区的偏移量
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
//    //得到时间偏移量的差值
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    //转为现在时间
//    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate] ;
//    return destinationDateNow;
//}


#pragma mark - getter
/**
 *  初始化datePicker
 */
- (UIDatePicker *)datePickerStart
{
    if (!_datePickerStart) {
        _datePickerStart = [[UIDatePicker alloc]init];
        _datePickerStart.datePickerMode = UIDatePickerModeDate;
        _datePickerStart.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        [_datePickerStart addTarget:self action:@selector(datePickerStartValueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _datePickerStart;
}
/**
 *  初始化datePicker
 */
- (UIDatePicker *)datePickerOver
{
    if (!_datePickerOver) {
        _datePickerOver = [[UIDatePicker alloc]init];
        _datePickerOver.datePickerMode = UIDatePickerModeDate;
        _datePickerOver.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        [_datePickerOver addTarget:self action:@selector(datePickerOverValueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _datePickerOver;
}
//
//- (void)nofiticationViewSelectTime
//{
//}


@end
