//
//  LGCalendarView.h
//  TestArrayCalendar
//
//  Created by AQ on 15-1-18.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGCalendarTableView.h"

@protocol LGCalendarViewDelegate <NSObject>

- (void)selectedDate:(NSDate *)firstDate and:(NSDate *)lastDate;
- (void)changeTitle;
@end

@interface LGCalendarView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDate *firstDate;
@property (nonatomic,strong) NSDate *lastDate;
@property (nonatomic,strong) NSArray *arrayMonths;

@property (nonatomic,weak) LGCalendarTableView *tableView;
@property (nonatomic,strong) NSDate *checkInTime;
@property (nonatomic,strong) NSDate *checkOutTime;
@property (nonatomic,assign) NSInteger btnPressCount;
@property (nonatomic,assign)NSInteger houseId;
@property (nonatomic,assign) id<LGCalendarViewDelegate> delegate;
@property (nonatomic,strong) NSArray *arrayHouseStatus;
- (void)loadDatas;

@end
