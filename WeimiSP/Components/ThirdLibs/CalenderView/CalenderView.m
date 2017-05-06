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

+ (CalenderView *)showInView:(UIView *)contentView {
    CalenderView *calenderView = [[[NSBundle mainBundle] loadNibNamed:@"CalenderView" owner:nil options:nil] lastObject];
    calenderView.frame = contentView.bounds;
    calenderView.center = CGPointMake(contentView.center.x,contentView.center.y + CGRectGetHeight(contentView.bounds));
    [contentView addSubview:calenderView];
    [UIView animateWithDuration:0.25 animations:^{
        calenderView.frame = contentView.bounds;
    }];
    
    UIView *blackView = calenderView;
    blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    UITapGestureRecognizer *disappearTap = [[UITapGestureRecognizer alloc] initWithTarget:calenderView action:@selector(disappearAction)];
    [blackView addGestureRecognizer:disappearTap];
    return calenderView;
}

- (void)disappearAction {
    if (self.superview) {
        [self removeFromSuperview];
    }
}

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
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%ld %ld %ld",(long)yearNum,(long)monthNum,(long)dayNum]];
    [self.datePicker setDate:date];
}

- (IBAction)makeSureAction:(id)sender {
    
    if (self.selectBirthBlock) {
        NSDate *date = self.datePicker.date;
        self.selectBirthBlock([self integerToString:date.year],[self integerToString:date.month],[self integerToString:date.day]);
    }
}

- (NSString *)integerToString:(NSInteger)number {
    return [NSString stringWithFormat:@"%ld",(long)number];
}

- (void)setMaxDate:(NSDate * _Nullable)MaxDate {
    _MaxDate = MaxDate;
    [self.datePicker setMaximumDate:MaxDate];
}

@end
