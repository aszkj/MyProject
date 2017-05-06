//
//  DLCustomCalendar.m
//  YilidiSeller
//
//  Created by yld on 16/6/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCustomCalendar.h"
#import "ZFChooseTimeCollectionViewCell.h"
#import "ZFTimerCollectionReusableView.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
static NSString * const reuseIdentifier = @"ChooseTimeCell";
static NSString * const headerIdentifier = @"headerIdentifier";



@interface DLCustomCalendar ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateComponents *comps;
@property (nonatomic, strong) NSCalendar *calender;
@property (nonatomic, strong) NSArray * weekdays;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic, strong) NSArray *OutDateArray;
@property (nonatomic, strong) NSArray *selectedData;
@property (nonatomic,strong)  NSString *starTime;
@property (nonatomic,strong)  NSString *endTime;
@end

@implementation DLCustomCalendar

@synthesize date = newDate;
@synthesize collectionView = datecollectionView;

#pragma mark ---
#pragma mark --- 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
    
    
    return self;
}

- (void)_init {
    
    self.alpha=1;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.70;
    
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_onClick)];
    singleTap.numberOfTouchesRequired = 1;
    [bgView addGestureRecognizer:singleTap];
    
    [self addSubview:bgView];
    
    
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time = 365/2 * 24 * 60 * 60;//一年的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即去年），如果没有，则表示向后的时间间隔（即明年））
    
    NSDate * lastYear = [date dateByAddingTimeInterval:-time];
    
    //转化为字符串
    //    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    //    NSLog(@"startDate:%@",startDate);
    newDate =lastYear;
    
    
    
    
    float cellw =(kScreenWidth/2+100)/7;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(cellw, cellw*4/3)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    [flowLayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, 50)];
    [flowLayout setMinimumInteritemSpacing:0]; //设置 y 间距
    [flowLayout setMinimumLineSpacing:0]; //设置 x 间距
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 10, 0);//设置其边界
    //UIEdgeInsetsMake(设置上下cell的上间距,设置cell左距离,设置上下cell的下间距,设置cell右距离);
    
    //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
    
    
    
    datecollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kScreenWidth/4-100/2, kScreenHeight/4-100, kScreenWidth/2+100, kScreenHeight/2+100)collectionViewLayout:flowLayout];
    datecollectionView.dataSource = self;
    datecollectionView.delegate = self;
    datecollectionView.backgroundColor = [UIColor whiteColor];
    CGColorRef cgColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor;
    datecollectionView.layer.borderColor = cgColor;
    datecollectionView.layer.borderWidth = 2.0;
    datecollectionView.layer.cornerRadius = 8;
    datecollectionView.layer.masksToBounds = YES;
    
    
    //    注册cell
    [datecollectionView registerNib:[UINib nibWithNibName:@"ZFTimerCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [datecollectionView registerNib:[UINib nibWithNibName:@"ZFChooseTimeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    datecollectionView.contentOffset = CGPointMake(0,datecollectionView.frame.size.height*6);
//    [datecollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:6] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self addSubview:datecollectionView];
    
}

- (void)_onClick {

    WEAK_SELF
    [UIView animateWithDuration:1 animations:^{
    weak_self.alpha=0;
    } completion:^(BOOL finished) {
        
    }];
}



- (NSTimeZone*)timeZone
{
    
    if (_timeZone == nil) {
        [UIColor blueColor];
        _timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        
        
        
    }
    return _timeZone;
}


- (NSArray*)weekdays
{
    
    if (_weekdays == nil) {
        
        _weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
        
    }
    return _weekdays;
}
- (NSCalendar*)calender
{
    
    if (_calender == nil) {
        
        _calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _calender;
}
- (NSDateComponents*)comps
{
    
    if (_comps == nil) {
        
        _comps = [[NSDateComponents alloc] init];
        
    }
    
    return _comps;
}
- (NSDateFormatter*)formatter
{
    
    if (_formatter == nil) {
        
        _formatter =[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _formatter;
}


#pragma mark ---
#pragma mark --- 各种方法
/**
 *  根据当前月获取有多少天
 *
 *  @param dayDate 但前时间
 *
 *  @return 天数
 */
- (NSInteger)getNumberOfDays:(NSDate *)dayDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dayDate];
    
    return range.length;
    
}
/**
 *  根据前几月获取时间
 *
 *  @param date  当前时间
 *  @param month 第几个月 正数为前  负数为后
 *
 *  @return 获得时间
 */
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month

{
    [self.comps setMonth:month];
    
    NSDate *mDate = [self.calender dateByAddingComponents:self.comps toDate:date options:0];
    return mDate;
    
}



/**
 *  根据时间获取周几
 *
 *  @param inputDate 输入参数是NSDate，
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    
    
    
    [self.calender setTimeZone: self.timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [self.calender components:calendarUnit fromDate:inputDate];
    
    return [self.weekdays objectAtIndex:theComponents.weekday];
    
}
/**
 *  获取第N个月的时间
 *
 *  @param currentDate 当前时间
 *  @param index 第几个月 正数为前  负数为后
 *
 *  @return @“2016年3月”
 */
- (NSArray*)timeString:(NSDate*)currentDate many:(NSInteger)index;
{
    
    NSDate *getDate =[self getPriousorLaterDateFromDate:currentDate withMonth:index];
    
    NSString  *str =  [self.formatter stringFromDate:getDate];
    
    return [str componentsSeparatedByString:@"-"];
}

/**
 *  根据时间获取第一天周几
 *
 *  @param dateStr 时间
 *
 *  @return 周几
 */
- (NSString*)getMonthBeginAndEndWith:(NSDate *)dateStr{
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:dateStr];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    
    return   [self weekdayStringFromDate:beginDate];
}


#pragma mark ---
#pragma mark --- 视图初始化






#pragma mark ---
#pragma mark --- <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size={kScreenWidth,50};
    return size;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 7;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSDate *dateList = [self getPriousorLaterDateFromDate:newDate withMonth:section];
    
    NSString *timerNsstring = [self getMonthBeginAndEndWith:dateList];
    NSInteger p_0 = [timerNsstring integerValue];
    NSInteger p_1 = [self getNumberOfDays:dateList] + p_0;
    
    return p_1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFChooseTimeCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDate*dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section];
    
    NSArray*array = [self timeString:newDate many:indexPath.section];
    
    NSInteger p = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
    
    NSString *str;
    
    if (p<10)
    {
        
        str = p > 0 ? [NSString stringWithFormat:@"0%ld",(long)p]:[NSString stringWithFormat:@"-0%ld",(long)-p];
        
    }
    else
    {
        
        str = [NSString stringWithFormat:@"%ld",(long)p];
    }
    
    
    NSArray *list = @[ array[0], array[1], str];
    //    NSLog(@"list:%@",list);
    [cell updateDay:list outDate:self.OutDateArray selected:[self.selectedData componentsJoinedByString:@""].integerValue currentDate:[self timeString:newDate many:0]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDate*dateList = [self getPriousorLaterDateFromDate:newDate withMonth:indexPath.section];
    NSInteger p = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
    NSArray *array = [self timeString:newDate many:indexPath.section];
    
    NSString *str = p < 10 ? [NSString stringWithFormat:@"0%ld",(long)p]:[NSString stringWithFormat:@"%ld",(long)p];
    
    if (self.OutDateArray.count == 0)
    {
        /**
         *  选择开始
         */
        self.OutDateArray =@[array[0],array[1],str];
        [self.collectionView reloadData];
        _starTime = [NSString stringWithFormat:@"%@-%@-%@",array[0],array[1],str];
    }else{
        /**
         *  选择结束
         */
        NSArray *listArray = @[ array[0], array[1], str];
        NSInteger p_0 = [listArray componentsJoinedByString:@""].intValue;
        NSInteger p_1 = [_OutDateArray componentsJoinedByString:@""].intValue;
        _endTime =  [NSString stringWithFormat:@"%@-%@-%@",array[0],array[1],str];
        //        NSLog(@"返%d",p_0);
        //        NSLog(@"出%d",p_1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate* date1 = [formatter dateFromString:_starTime];
        
        
        NSDate* date2 = [formatter dateFromString:_endTime];
        //        NSLog(@"date1%@",date1);
        //        NSLog(@"date2%@",date2);
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date1 toDate:date2  options:0];
        int days = [comps day];
        
        
        if (p_0 < p_1)
        {
            
            [SVProgressHUD showErrorWithStatus:@"选择结束时间不能小于开始时间!" duration:1.5];
            return;
            
        }
        
        if (days>30){
            
            [SVProgressHUD showErrorWithStatus:@"开始时间与结束时间不能超过一个月" duration:1.5];
            
            return;
            
            
        }else{
            
            self.selectedData = listArray;
            
            [self.collectionView reloadData];
            if (_OutDateArray.count > 0 && _selectedData.count > 0) {
                
                if (self.selectedDate) {
                    
                    self.selectedDate(_OutDateArray,_selectedData);
                    
                }
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ZFTimerCollectionReusableView * headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        [headerCell updateTimer:[self timeString:newDate many:indexPath.section]];
        
        return headerCell;
    }
    return nil;
}


#pragma mark ---
#pragma mark --- block



#pragma mark ---
#pragma mark --- 提示框

@end
