//
//  ClockPikcerView.m
//  picker测试
//
//  Created by 张康健 on 15/6/12.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import "ClockPikcerView.h"

@implementation ClockPikcerView


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init{

    self.delegate = self;
    self.dataSource = self;
    
//    NSInteger selectedRow = [self selectedRowInComponent:0];
   
//    NSString *selectedStr = self.data[0];
    self.selectedTimeStr = @"00";
    
    
}


#pragma mark - delegate & datasource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.data.count;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return 74;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 39;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"costomView" owner:nil options:nil];
    UIView *viw = [nibs lastObject];
    UILabel *timeLabel = (UILabel *)[viw viewWithTag:1001];
    NSString *timeStr = self.data[row];
    timeLabel.text = timeStr;
    
    return viw;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectedTimeStr = self.data[row];
//    if (self.selectTimeBlock!=nil) {
//        self.selectTimeBlock(selectedTimeStr);
//        
//    }
    self.selectedTimeStr = selectedTimeStr;
    
}








@end
