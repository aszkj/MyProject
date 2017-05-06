//
//  LGCalendarTableView.h
//  TestArrayCalendar
//
//  Created by AQ on 15-1-18.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGCalendarTableView : UITableView
@property (strong,nonatomic)NSDate *dateCheckIn;
@property (strong,nonatomic)NSDate *dateCheckOut;
@property (nonatomic,assign) NSInteger btnPressCount;

@end
