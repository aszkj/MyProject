//
//  CalenderView.m
//  jingGang
//
//  Created by 张康健 on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CalenderView.h"
#import "ClockPikcerView.h"

@interface CalenderView ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation CalenderView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.clipsToBounds = YES;
    
}

- (void)setCurrentDate:(NSDate *)date {
    [self.datePicker setDate:date animated:NO];
}

-(void)setSelectedRowWithYearNum:(NSInteger)yearNum monthNum:(NSInteger )monthNum dayNum:(NSInteger)dayNum {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[NSString stringWithFormat:@"yyyy MM dd"]];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%ld %ld %ld",yearNum,monthNum,dayNum]];
    [self.datePicker setDate:date];
}

- (IBAction)makeSureAction:(id)sender {
    
    if (self.selectBirthBlock) {
        NSDate *date = self.datePicker.date;
        self.selectBirthBlock([self integerToString:date.year],[self integerToString:date.month],[self integerToString:date.day]);
    }
}

- (NSString *)integerToString:(NSInteger)number {
    return [NSString stringWithFormat:@"%ld",number];
}

- (void)setMaxDate:(NSDate * _Nullable)MaxDate {
    _MaxDate = MaxDate;
    [self.datePicker setMaximumDate:MaxDate];
}

@end
