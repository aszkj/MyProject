//
//  DateCalendarController.m
//  Mamahome
//
//  Created by AQ on 15-1-19.
//  Copyright (c) 2015年 OIT. All rights reserved.
//

#import "DateCalendarController.h"
#import "LGCalendarView.h"

//#import "ASIFormDataRequest.h"
//#import "StringConvert.h"
//#import "HouseManage.h"

@interface DateCalendarController ()<LGCalendarViewDelegate>
{
    UILabel *titleLabel;
    LGCalendarView *calendarView;

}
@end

@implementation DateCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat fontSize = 17.0;
//    UIImage*    image = [UIImage imageNamed:@"return"];
//    UIButton*   leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, fontSize*image.size.width/image.size.height, fontSize);
//    [leftBtn setImage:image forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(leftBarAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    // title
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100., 44)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    [titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
//    titleLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0];
//    titleLabel.text = @"选择入住日期";
//    self.navigationItem.titleView = titleLabel;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"顶部背景白色.png"] forBarMetrics:UIBarMetricsDefault];
    
    calendarView = [[LGCalendarView alloc] initWithFrame:self.view.bounds];
    calendarView.opaque = NO;
    
    calendarView.backgroundColor = [UIColor clearColor];
    calendarView.delegate = self;
    calendarView.firstDate = [NSDate date];
    [calendarView loadDatas];
    [self.view addSubview:calendarView];
}
- (void)selectedDate:(NSDate *)firstDate and:(NSDate *)lastDate
{
    self.checkInDate = firstDate;
    self.checkOutDate = lastDate;

    [self.delegate selectDate:self.checkInDate and:self.checkOutDate];
}

- (void)changeTitle
{
    if([titleLabel.text isEqualToString:@"选择离开日期"])
        titleLabel.text = @"选择入住日期";
    else
        titleLabel.text = @"选择离开日期";
}
- (void)leftBarAction
{
    [self.delegate dismissDateCalendarView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setCheckInDate:(NSDate *)checkInDate
{
    _checkInDate = checkInDate;
    calendarView.checkInTime = _checkInDate;
}

- (void)setCheckOutDate:(NSDate *)checkOutDate
{
    _checkOutDate = checkOutDate;
    calendarView.checkOutTime = _checkOutDate;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
