//
//  UserBodySyncInfoModel.m
//  WKLBle
//
//  Created by 张康健 on 15/6/9.
//  Copyright (c) 2015年 baoyx. All rights reserved.
//

#import "UserBodySyncInfoModel.h"
#import "UerBodyModel.h"
#import "NSDate+Utilities.h"
#import "NSDate+DateTools.h"

@interface UserBodySyncInfoModel(){

    NSDateFormatter *_dateFormatter;

}

@end


@implementation UserBodySyncInfoModel

-(id)init{

    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];


    }
    
    return self;
}
#pragma mark ------------------- 步数相关计算--------------------------------------------
//计算步数相关的，，包括，里程和卡洛里
-(void)culculateStepwithStepArr:(NSArray *)stepArr
{
     [_dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    //计算总步数
    NSInteger _totalSteps = 0;
    for (int i=0; i<stepArr.count; i++) {
        NSDictionary *step = stepArr[i];
        NSString *syncTime = step[@"sportTime"];
        NSDate *syncDate = [_dateFormatter dateFromString:syncTime];
        
        //只同步今天的
//        if ([syncDate isToday]) {
//            
//            NSInteger pSteps = [step[@"sportStep"] integerValue];
//            _totalSteps += pSteps;
//        }
        
        NSDate *date = [NSDate dateWithString:syncTime formatString:@"yyyyMMddHHmm"];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
        JGLog(@"loc:%@",localeDate);
        
        NSDate *nowDate = [NSDate date];
        nowDate = [nowDate dateByAddingTimeInterval:interval];
        NSString *nowDateString = [nowDate description];
        NSArray *nowDateArray = [nowDateString componentsSeparatedByString:@" "];
        if (nowDateArray.count) {
            nowDateString = [nowDateArray firstObject];
            nowDateArray = [nowDateString componentsSeparatedByString:@"-"];
            if (nowDateArray.count == 3) {
                NSString *y = nowDateArray[0];
                NSString *m = nowDateArray[1];
                NSString *d = nowDateArray[2];
                
                NSDate *nowBeginDate = [NSDate dateWithYear:[y integerValue] month:[m integerValue] day:[d integerValue] hour:0 minute:0 second:0];
                // 得到今天的日期
                nowDate = [nowBeginDate dateByAddingTimeInterval:interval];
                
                if ([self judgeTargetDate:localeDate isTodayDate:nowDate]) {

                }else {

                    // 同步今天运动数据
                    NSInteger pSteps = [step[@"sportStep"] integerValue];
                    _totalSteps += pSteps;
                }
            }
        }
        
        
        if (i == stepArr.count-1 && [syncDate isToday]) {//若是最后一个并且是今天的，记下时间
            self.perDaylastStepSyncTime = syncTime;
        }
    }
    
    self.steps = _totalSteps;
    //计算里程
    self.licheng =  [self getMileageWithSteps:self.steps];
    
    //计算卡洛里
    self.kaluoli = [self getCalorieWithSteps:self.steps];
}

- (BOOL)judgeTargetDate:(NSDate *)targetDate isTodayDate:(NSDate *)todayDate {
    NSComparisonResult early = [targetDate compare:todayDate];
    if (early == -1) {
        return YES;
    }
    return NO;
}

-(CGFloat)getMileageWithSteps:(NSInteger)steps
{
    NSInteger stepLength = [self readDisCMByHeight:self.userBodyModel.height];
    return (stepLength * steps)/100000.0;
}//计算里程


-(CGFloat)getCalorieWithSteps:(NSInteger)steps
{
    CGFloat mileage = [self getMileageWithSteps:steps];
    CGFloat Weight = self.userBodyModel.weight;
    return 0.6 * Weight * mileage;
}//计算卡洛里



-(int)readDisCMByHeight:(int)hei
{
    int tempHei = hei;
    
    if (tempHei < 50) {
        tempHei = 50;
    } else if (tempHei > 190) {
        tempHei = 190;
    } else {
        if (tempHei%10) {
            tempHei = (tempHei/10+1)*10;
        } else {
            tempHei = tempHei/10*10;
        }
    }
    
    int stepLength = 0;
    switch (tempHei) {
        case 50:
        {
            stepLength = 20;
        }
            break;
        case 60:
        {
            stepLength = 22;
        }
            break;
        case 70:
        {
            stepLength = 25;
        }
            break;
        case 80:
        {
            stepLength = 29;
        }
            break;
        case 90:
        {
            stepLength = 33;
        }
            break;
        case 100:
        {
            stepLength = 37;
        }
            break;
        case 110:
        {
            stepLength = 40;
        }
            break;
        case 120:
        {
            stepLength = 44;
        }
            break;
        case 130:
        {
            stepLength = 48;
        }
            break;
        case 140:
        {
            stepLength = 51;
        }
            break;
        case 150:
        {
            stepLength = 55;
        }
            break;
        case 160:
        {
            stepLength = 59;
        }
            break;
        case 170:
        {
            stepLength = 62;
        }
            break;
        case 180:
        {
            stepLength = 66;
        }
            break;
        case 190:
        {
            stepLength = 70;
        }
            break;
        default:
            break;
    }
    return stepLength;
}//计算步长










#pragma mark -------------------------------- 睡眠计算----------------------------------------
//计算深度，浅度睡眠
-(void)culculateSleepWithSleepArr:(NSArray *)sleepArr
{

    [_dateFormatter setDateFormat:@"yyyyMMdd"];
    //计算睡眠相关
    NSInteger _totalSleepTime1 = 0;
    NSInteger _deepSleepTime1 = 0;
    NSInteger _slightSleepTime1 = 0;
    for (int i=0; i<sleepArr.count; i++) {
        NSDictionary *sleep = sleepArr[i];
        
        NSString *syncTime = sleep[@"dateTime"];
        NSDate *syncDate = [_dateFormatter dateFromString:syncTime];
        
        if ([syncDate isToday]) {//只记录今天的
            
            NSInteger sleepTime = [sleep[@"sleepDuration"] integerValue];
            NSInteger sleepState = [sleep[@"sleepState"] integerValue];
            if (sleepState == 0) {//深度睡眠
                _deepSleepTime1 += sleepTime;
            }else{//浅度睡眠
                _slightSleepTime1 += sleepTime;
            }
            //总睡眠时间
            _totalSleepTime1 += sleepTime;
            
            if (i == sleepArr.count-1) {//若是最后一个，记下时间
                self.perDaylastSleepSyncTime = syncTime;
            }
        }

        
    }
    
//    NSLog(@"total---%ld",_totalSleepTime1);
//    NSLog(@"deep---%ld",_deepSleepTime1);
//    NSLog(@"slight---%ld",_slightSleepTime1);
//    
    
    self.totalSleepTime = _totalSleepTime1;
    self.deepSleepTime = _deepSleepTime1;
    self.lightSleepTime = _slightSleepTime1;
}





@end
