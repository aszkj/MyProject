//
//  LGMonthCell.h
//  TestArrayCalendar
//
//  Created by AQ on 15-1-18.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import <UIKit/UIKit.h>



@class LGMonthModel;
@class LGDayButton;
@class LGMonthCell;
@class LGCalendarTableView;
@class LGCancelDateButton;

@protocol LGCalendarCellDelegate <NSObject>

- (void)chooseDate:(LGDayButton *)btn andCell:(LGMonthCell *)cell;
- (void)cancelBtn:(LGDayButton *)btn andCell:(LGMonthCell *)cell;
- (void)changeTitle;
- (void)clearDates;
@end

@interface LGMonthCell : UITableViewCell
{
    BOOL isCanBeCancel;
    NSInteger btnsCount;
    CGRect cancelBtnFrame;
}
@property (strong,nonatomic) NSArray *arrayDayBtns;
@property (strong,nonatomic) NSArray *arrayWeekLabels;

@property (weak,nonatomic) UILabel *labelTitle;
@property (strong,nonatomic) NSDate *currentDate;
@property (strong,nonatomic) NSDate *firstSelectedDate;
@property (strong,nonatomic) NSDate *lastSelectedDate;
@property (weak,nonatomic) LGDayButton *firstSelectBtn;
@property (weak,nonatomic) LGDayButton *lastSelectBtn;
@property (weak,nonatomic) LGCancelDateButton *cancelBtn;
@property (weak,nonatomic) LGCalendarTableView *tableView;
@property (assign,nonatomic) id<LGCalendarCellDelegate>delegate;
@property (nonatomic,strong) NSArray *arrayHouseStatus;
+ (instancetype)monthCellWithTableView:(UITableView *)tableView;

- (NSInteger)showDataWith:(LGMonthModel *)model;
@end
