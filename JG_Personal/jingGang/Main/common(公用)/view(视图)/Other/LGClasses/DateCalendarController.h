//
//  DateCalendarController.h
//  Mamahome
//
//  Created by AQ on 15-1-19.
//  Copyright (c) 2015年 OIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateCalendarDelegate <NSObject>


- (void)selectDate:(NSDate *)firstDate and:(NSDate *)lastDate;
- (void)dismissDateCalendarView;

@end

@interface DateCalendarController : UIViewController
@property (nonatomic,strong)NSDate *checkInDate;
@property (nonatomic,strong)NSDate *checkOutDate;
@property (nonatomic,strong)NSArray *arrayHouseStatus;
@property (nonatomic,assign)NSInteger houseId;
@property (nonatomic,assign) id<DateCalendarDelegate> delegate;

@end
