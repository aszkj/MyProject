//
//  LGCalendarView.m
//  TestArrayCalendar
//
//  Created by AQ on 15-1-18.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import "LGCalendarView.h"
#import "LGMonthModel.h"
#import "LGDayModel.h"
//#import "LGYearModel.h"
#import "LGMonthCell.h"
#import "LGDayButton.h"
#import "LGCancelDateButton.h"


@interface LGCalendarView()<LGCalendarCellDelegate>
{

    NSInteger _totalDays;
    
    NSInteger _cellBtns;

}
@property (nonatomic,strong) NSArray *houseStatusArray;
@end

@implementation LGCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        LGCalendarTableView *tableView = [[LGCalendarTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
//        tableView.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:223.0/255.0 blue:222.0/255.0 alpha:1.0];
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        self.tableView = tableView;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.btnPressCount = 0;
        _checkInTime = nil;
        _checkOutTime = nil;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    self.tableView.frame = self.bounds;
    [self.tableView reloadData];
}
- (void)loadDatas
{
    
    self.arrayMonths = [self createArrayMonths];
    NSLog(@"");
    [self.tableView reloadData];
    
}

- (NSArray *)createArrayMonths
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    _totalDays = 0;
    CGFloat deviceVersion = [[UIDevice currentDevice].systemVersion floatValue];
    NSInteger flag = 0;
    if(deviceVersion>=8.0)
    {
        flag = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekday|NSCalendarUnitDay;
    }
    else
    {
        flag = NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
    }
  
    
    self.lastDate = [NSDate dateWithTimeInterval:63072000 sinceDate:self.firstDate];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    NSDateComponents *components = [calendar components:flag fromDate:self.firstDate];
    
    NSInteger firstYear = [components year];
    NSInteger firstMonth = [components month];
//    NSInteger firstWeekDay = [components weekday];
    NSInteger firstDay = [components day];
    _totalDays = firstDay-1;
    NSDate *dateFirst = [NSDate dateWithTimeInterval:-86400*_totalDays sinceDate:self.firstDate];
    _totalDays = 0;
    NSDateComponents *componentLast = [calendar components:flag fromDate:self.lastDate];
    NSInteger lastYear = [componentLast year];
    NSInteger lastMonth = [componentLast month];
//    NSInteger lastWeekDay = [componentLast weekday];
//    NSInteger lastDay = [componentLast day];
//    
//    NSInteger years = lastYear - firstYear +1;
    
    for(NSInteger i = firstYear;i<=lastYear;i++)
    {
        
        if(i == firstYear)
        {
            for(NSInteger j = firstMonth;j<=12;j++)
            {
                LGMonthModel *monthModel = [[LGMonthModel alloc] init];
                monthModel.worldYear = i;
                monthModel.worldMoth = j;
                monthModel.daysCount = [self dayOfMonth:i and:j];
                NSMutableArray *arrayDaysTemp = [[NSMutableArray alloc] init];
                for(NSInteger k = 1;k<=monthModel.daysCount;k++)
                {
                    LGDayModel *dayModel = [[LGDayModel alloc] init];
                    
                    NSDate *date = [NSDate dateWithTimeInterval:86400*_totalDays sinceDate:dateFirst];
                    _totalDays++;
                    dayModel.weekDay = [self weekDayWithDate:date];
                    dayModel.worldDay = [self worldDayWithDate:date];
                    dayModel.dayDate = date;
                    dayModel.chiDay = [self chiDayWithDate:date];
                    dayModel.chiDayStr = [self getDayFromChiDay:dayModel.chiDay];
                    if(dayModel.chiDay == 1)
                    {
                        dayModel.chiDayStr = [self getMonthFromChiMonth:[self chiMonthWithDate:date]];
                    }
                    [arrayDaysTemp addObject:dayModel];
                    
                }
                
                monthModel.daysArray = arrayDaysTemp;
                [array addObject:monthModel];
            }
        }
        
        if(i!= firstYear && i!=lastYear)
        {
            for(NSInteger j = 1;j<=12;j++)
            {
                LGMonthModel *monthModel = [[LGMonthModel alloc] init];
                monthModel.worldYear = i;
                monthModel.worldMoth = j;
                monthModel.daysCount = [self dayOfMonth:i and:j];
                NSMutableArray *arrayDaysTemp = [[NSMutableArray alloc] init];
                for(NSInteger k = 1;k<=monthModel.daysCount;k++)
                {
                    LGDayModel *dayModel = [[LGDayModel alloc] init];
                    NSDate *date = [NSDate dateWithTimeInterval:86400*_totalDays sinceDate:dateFirst];
                    _totalDays++;
                    dayModel.weekDay = [self weekDayWithDate:date];
                    dayModel.worldDay = [self worldDayWithDate:date];
                    dayModel.dayDate = date;
                    dayModel.chiDay = [self chiDayWithDate:date];
                    dayModel.chiDayStr = [self getDayFromChiDay:dayModel.chiDay];
                    if(dayModel.chiDay == 1)
                    {
                        dayModel.chiDayStr = [self getMonthFromChiMonth:[self chiMonthWithDate:date]];
                    }
                    [arrayDaysTemp addObject:dayModel];
                }
                
                monthModel.daysArray = arrayDaysTemp;
                [array addObject:monthModel];
            }

        }
        
        if(i == lastYear)
        {
            for(NSInteger j = 1;j<=lastMonth;j++)
            {
            
                LGMonthModel *monthModel = [[LGMonthModel alloc] init];
                monthModel.worldYear = i;
                monthModel.worldMoth = j;
                monthModel.daysCount = [self dayOfMonth:i and:j];
                
                NSMutableArray *arrayDaysTemp = [[NSMutableArray alloc] init];
                for(NSInteger k = 1;k<=monthModel.daysCount;k++)
                {
                    LGDayModel *dayModel = [[LGDayModel alloc] init];
                    NSDate *date = [NSDate dateWithTimeInterval:86400*_totalDays sinceDate:dateFirst];
                    _totalDays++;
                    dayModel.weekDay = [self weekDayWithDate:date];
                    dayModel.worldDay = [self worldDayWithDate:date];
                    dayModel.dayDate = date;
                    dayModel.chiDay = [self chiDayWithDate:date];
                    dayModel.chiDayStr = [self getDayFromChiDay:dayModel.chiDay];
                    if(dayModel.chiDay == 1)
                    {
                        dayModel.chiDayStr = [self getMonthFromChiMonth:[self chiMonthWithDate:date]];
                    }
                    [arrayDaysTemp addObject:dayModel];
                }
                
                monthModel.daysArray = arrayDaysTemp;
                [array addObject:monthModel];
            }
            
        }
        
    }

    return array;
}

- (void)createMonthsExtract:(NSInteger) i andJ:(NSInteger)j andArray:(NSArray *)array
{
    
}

- (NSString *)getMonthFromChiMonth:(NSInteger)month
{
    NSArray *arrayTemp = [NSArray arrayWithObjects:
                          @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                          @"九月", @"十月", @"冬月", @"腊月", nil];
    NSString *str = nil;
    for(int i = 0;i<arrayTemp.count;i++)
    {
        if(month-1 == i)
        {
            str = [arrayTemp objectAtIndex:i];
            break;
        }
    }
    
    return str;
    
}

- (NSString *)getDayFromChiDay:(NSInteger)day
{
    NSArray *arrayTemp = [NSArray arrayWithObjects:
                                               @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                                               @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                                               @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    NSString *str = nil;
    for(int i = 0;i<arrayTemp.count;i++)
    {
        if(day-1 == i)
        {
            str = [arrayTemp objectAtIndex:i];
            break;
        }
    }
    
    return str;
    
}
- (NSDateComponents *)getCalendarComponents:(NSString *)identifier andDate:(NSDate *)date
{
    NSInteger flagChi = 0;
    NSInteger flag = 0;
    float deviceVersion = 0;
   
    if(deviceVersion>=8.0)
    {
        flagChi = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay;
        flag = NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekday|NSCalendarUnitDay;
    }
    else
    {
        flagChi = NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit;
        flag = NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
    }
    
    
   
    NSDateComponents *component = nil;
    if([identifier isEqualToString:NSCalendarIdentifierChinese])
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:identifier];
        component = [calendar components:flagChi fromDate:date];
    }
    else
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        component = [calendar components:flag fromDate:date];
    }
    
    return component;
}

- (NSInteger)chiDayWithDate:(NSDate *)date
{
    
    NSDateComponents *component = [self getCalendarComponents:NSCalendarIdentifierChinese andDate:date];
    
    NSInteger chiDay = [component day];
    
    return chiDay;
}


- (NSInteger)chiMonthWithDate:(NSDate *)date
{
    
    NSDateComponents *component = [self getCalendarComponents:NSCalendarIdentifierChinese andDate:date];
    
    NSInteger chiMonth = [component month];
    
    return chiMonth;
}
- (NSInteger)weekDayWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSInteger weekDayTemp = [component weekday];
    
    return weekDayTemp;
}

- (NSInteger)worldDayWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitDay fromDate:date];
    
    NSInteger day = [component day];
    
    return day;
}
- (void)setArrayMonths:(NSArray *)arrayMonths
{
    if(_arrayMonths != arrayMonths)
    {
        _arrayMonths = arrayMonths;
    }
}


-(NSInteger) dayOfMonth:(NSInteger) year and:(NSInteger) imonth
{
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if(year%4==0 && year%100!=0)
        return 29;
    
    if(year%400 == 0)
        return 29;
    
    return 28;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayMonths.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.arrayMonths.count>0)
    {
        LGMonthModel *monthTemp = [self.arrayMonths objectAtIndex:indexPath.row];
        LGDayModel *dayTemp = [monthTemp.daysArray objectAtIndex:0];
        
        NSInteger totalTemp = dayTemp.weekDay-1+monthTemp.daysArray.count;
        CGFloat titleHeight = 25;
        CGFloat weekHeight = (self.frame.size.width-20)/7/2;
        CGFloat dayHeight = (self.frame.size.width-20)/7*2/3;
        
        if(totalTemp<=28)
        {
            return titleHeight+weekHeight+dayHeight*4;
        }
        else if(totalTemp>28&&totalTemp<=35)
        {
            return titleHeight+weekHeight+dayHeight*5;
        }
        else
        {
            return titleHeight+weekHeight+dayHeight*6;
        }
    }
    return self.frame.size.width*2/3+15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"monthCell"];
    if(cell == nil)
    {
        cell = [LGMonthCell monthCellWithTableView:tableView];
    }
    cell.delegate = self;
    cell.currentDate = self.firstDate;
    cell.firstSelectedDate = self.checkInTime;
    cell.lastSelectedDate = self.checkOutTime;
    cell.cancelBtn.date = self.checkInTime;
    cell.tableView = (LGCalendarTableView *)tableView;
    LGMonthModel *model = [self.arrayMonths objectAtIndex:indexPath.row];
    cell.arrayHouseStatus = self.arrayHouseStatus;
    _cellBtns =[cell showDataWith:model];
    
    return cell;



}
- (void)changeTitle
{
    [self.delegate changeTitle];
    [self.tableView reloadData];
}

- (void)clearDates
{
    self.checkInTime = nil;
    self.checkOutTime = nil;
    self.tableView.dateCheckIn = nil;
    self.tableView.dateCheckOut = nil;
    self.tableView.btnPressCount = 0;
}
- (void)chooseDate:(LGDayButton *)btn andCell:(LGMonthCell *)cell
{
#warning 待定（显示这天房源的房态）
    if(self.tableView.btnPressCount == 0)
    {
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:btn.date] ;
        NSTimeInterval timeInterval2 = [btn.date timeIntervalSinceDate:[NSDate date]];
        if((timeInterval>= 0&& [self worldDayWithDate:[NSDate date]] == [self worldDayWithDate:btn.date])||timeInterval2>0)
        {
            self.checkInTime = btn.date;
            self.tableView.btnPressCount ++;
            cell.cancelBtn.frame = CGRectMake(0, 0, btn.frame.size.width/3, btn.frame.size.width/3);
            cell.cancelBtn.center = CGPointMake(CGRectGetMaxX(btn.frame), CGRectGetMinY(btn.frame));
            cell.cancelBtn.hidden = NO;
            cell.cancelBtn.date = btn.date;
            cell.firstSelectedDate = btn.date;
            cell.firstSelectBtn = btn;
            self.tableView.dateCheckIn = self.checkInTime;

//            [self.delegate changeTitle];
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:167.0/255.0 blue:221.0/255.0 alpha:1.0]];
            return;
        }
        else
            return;
        
    }
    else
    {
        
        if([btn.date timeIntervalSinceDate:self.firstDate]>0)
        {
            
            
            if(self.checkInTime != nil && [btn.date timeIntervalSinceDate:self.checkInTime]>0)
            {
                self.checkOutTime = btn.date;
                self.tableView.dateCheckOut = self.checkOutTime;
                cell.lastSelectBtn = btn;
                [self.tableView reloadData];
                
//                [self.delegate selectedDate:self.checkInTime and:self.checkOutTime];
                
                
            }
        }
    }
    
}



- (void)setCheckInTime:(NSDate *)checkInTime
{
    _checkInTime = checkInTime;
    _tableView.dateCheckIn = checkInTime;
}

- (void)setCheckOutTime:(NSDate *)checkOutTime
{
    _checkOutTime = checkOutTime;
    _tableView.dateCheckOut = checkOutTime;
}

@end
