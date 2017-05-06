//
//  JGHealthTaskManager.m
//  jingGang
//
//  Created by 张康健 on 15/6/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "JGHealthTaskManager.h"
#import "TMCache.h"
#import "NSDate+Utilities.h"
#define Eye_task_key @"Eye_task_key"
#define Hearing_task_key @"Hearing_task_key"
#define Blood_task_key @"Blood_task_key"
#define Weight_task_key @"Weight_task_key"
#define Lunch_cache_time @"Lunch_cache_time"


static JGHealthTaskManager *_JGHealthTaskManager;

@interface JGHealthTaskManager(){

    TMCache *_cache;
}

@end

@implementation JGHealthTaskManager


+ (id)shareInstances
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _JGHealthTaskManager = [[JGHealthTaskManager alloc] init];
        
    });
    
    return _JGHealthTaskManager;
}



- (id)init
{
    self = [super init];
    
    if (self) {
        _cache = [TMCache sharedCache];
        
        //初始化每个大任务数组
        [self _initPerBigTask];
        
        //每天app第一次启动重置
        [self resetTaskFirstLunchTimeEveryDay];
    }
    return self;
}

#pragma mark - 每天app第一次启动重置
- (void)resetTaskFirstLunchTimeEveryDay {
    
    //拿出app上次启动时间
    NSDate *lasteLunchTime = [_cache objectForKey:Lunch_cache_time];
    //因为时区错误导致了任务没有重置
//    lasteLunchTime = [self getNowDateFromatAnDate:lasteLunchTime];
    if (lasteLunchTime) {
        if (![self isToday:lasteLunchTime]) {//上次启动的不是今天，那肯定是今天以前，重置
            [self allTaskReset];
        }
    }
    if(lasteLunchTime){
//        [lasteLunchTime isToday:]
        
    }
    //缓存这次启动的时间
//    NSDate *currentLunchDate = [self getNowDateFromatAnDate:[NSDate date]];
    NSDate *currentLunchDate = [NSDate date];
//    currentLunchDate = [self getNowDateFromatAnDate:currentLunchDate];
    [_cache setObject:currentLunchDate forKey:Lunch_cache_time];
    
}
//距上次登陆时间判断
- (BOOL)isToday:(NSDate *)dat {
    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
//    NSDate *today = [cal dateFromComponents:components];
    NSDateComponents *currentComponents = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour) fromDate:[NSDate date]];
    NSDateComponents *beforeComponents = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour) fromDate:dat];
//    当前时间
    NSInteger currentYear = [currentComponents year];
    NSInteger currentMonth = [currentComponents month];
    NSInteger currentDay = [currentComponents day];
    NSInteger currentHour = [currentComponents hour];
//    上次登陆时间
    NSInteger beforeYear = [beforeComponents year];
    NSInteger beforeMonth = [beforeComponents month];
    NSInteger beforeDay = [beforeComponents day];
    NSInteger beforeHour = [beforeComponents hour];
    if(beforeDay !=currentDay){
        return NO;
    }
    else if(beforeMonth !=currentMonth){
        return NO;
    }
    else if(beforeYear !=currentYear){
        return NO;
    }
    else{
        return YES;
    }
//    NSDate *today = [cal dateFromComponents:components];
    
//    return [dat isEqualToDate:today];
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
#pragma mark - 初始化每个大任务的完成情况
-(void)_initPerBigTask{
    

    //开始初始化未都没完成，，先不从缓存中初始化
    if (![_cache objectForKey:Eye_task_key]) {//如果一个缓存没有，那么肯定是都没有
    
        //重置所有任务
        [self allTaskReset];
        
    }
    else{//有缓存的
       
        //从缓存中读
        [self taskReadRromDisk];
        
        //对有缓存的进行处理，若完成个数等于总数，则重置
        [self _retainOrResetCachedTaskArr];
    }
}

#pragma mark - 重置所有任务
-(void)allTaskReset {

    _eyesightMaintainceCompletedArr = [@[@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    _hearingMaintainceCompletedArr = [@[@0,@0,@0,@0,@0] mutableCopy];
    _blooControlceCompletedArr = [@[@0] mutableCopy];
    _weightControlCompletedArr = [@[@0,@0] mutableCopy];
}

#pragma mark - 从缓存中读取
-(void)taskReadRromDisk {
    
    _eyesightMaintainceCompletedArr = [_cache objectForKey:Eye_task_key];
    _hearingMaintainceCompletedArr = [_cache objectForKey:Hearing_task_key];
    _blooControlceCompletedArr = [_cache objectForKey:Blood_task_key];
    _weightControlCompletedArr = [_cache objectForKey:Weight_task_key];
}


#pragma mark -//对有缓存的进行处理，若完成个数等于总数，则重置
-(void)_retainOrResetCachedTaskArr{
   
    if ([self completeCountOfTaskArr:_eyesightMaintainceCompletedArr] > _eyesightMaintainceCompletedArr.count) {
        _eyesightMaintainceCompletedArr = [@[@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    }
    
    if ([self completeCountOfTaskArr:_hearingMaintainceCompletedArr] > _hearingMaintainceCompletedArr.count) {
        _hearingMaintainceCompletedArr = [@[@0,@0,@0,@0,@0] mutableCopy];
    }
    
    if ([self completeCountOfTaskArr:_blooControlceCompletedArr] > _blooControlceCompletedArr.count) {
        _blooControlceCompletedArr = [@[@0] mutableCopy];
    }
    
    if ([self completeCountOfTaskArr:_weightControlCompletedArr] > _weightControlCompletedArr.count) {
        _weightControlCompletedArr = [@[@0,@0] mutableCopy];
    }
}



#pragma mark - 视力完成个数
-(NSInteger)eyeCompletedCount {

    return [self completeCountOfTaskArr:_eyesightMaintainceCompletedArr];
}


#pragma mark - 听力完成个数
-(NSInteger)hearingCompletedCount {

    return [self completeCountOfTaskArr:_hearingMaintainceCompletedArr];

}

#pragma mark - 血压完成个数
-(NSInteger)bloodControlCompletedCount {

    return [self completeCountOfTaskArr:_blooControlceCompletedArr];

}

#pragma mark - 体重完成个数
-(NSInteger)weightControlCompletedCount {


    return [self completeCountOfTaskArr:_weightControlCompletedArr];

}

#pragma mark - 根据大任务和小任务的num设置完成
- (void)setTaskCompletedBybigTaskNum:(NSInteger)bigTaskNum
                     andSmallTaskNum:(NSInteger)smallTaskNum
{

    switch (bigTaskNum) {
        case 0://眼部任务

            [self setCompletedOfTaskArr:_eyesightMaintainceCompletedArr  atNum:smallTaskNum];
            break;
        case 1://耳部任务
            
            [self setCompletedOfTaskArr:_hearingMaintainceCompletedArr   atNum:smallTaskNum];
            break;
        case 2://血压控制
            
            [self setCompletedOfTaskArr:_blooControlceCompletedArr   atNum:smallTaskNum];
            break;
        case 3://体重任务
            
            [self setCompletedOfTaskArr:_weightControlCompletedArr  atNum:smallTaskNum];
            break;
            
        default:
            break;
    }
    
}


- (void)setCompletedOfTaskArr:(NSMutableArray *)taskArr atNum:(NSInteger)num{

    for (int i=0; i<taskArr.count; i ++) {
        if (i==num) {//设置为完成
            taskArr[i] = @1;
        }
        
    }

}



-(NSInteger)completeCountOfTaskArr:(NSMutableArray *)taskArr{

    NSInteger count = 0;
    for (NSNumber *completedNum in taskArr) {
        if (completedNum.integerValue == 1) {
            count ++;
        }
    }
    
    return count;
}


#pragma mark - 保存任务信息
-(void)saveTaskInfo{

    [_cache setObject:_eyesightMaintainceCompletedArr forKey:Eye_task_key];
    [_cache setObject:_hearingMaintainceCompletedArr forKey:Hearing_task_key];
    [_cache setObject:_blooControlceCompletedArr forKey:Blood_task_key];
    [_cache setObject:_weightControlCompletedArr forKey:Weight_task_key];

}





@end
