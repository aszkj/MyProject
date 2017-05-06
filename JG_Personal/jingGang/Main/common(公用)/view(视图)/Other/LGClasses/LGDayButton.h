//
//  LGDayButton.h
//  TestArrayCalendar
//
//  Created by AQ on 15-1-18.
//  Copyright (c) 2015年 AQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDayButton : UIButton
@property (nonatomic,strong)NSDate *date;

@property (nonatomic,weak)UILabel *worldDayLabel;
@property (nonatomic,weak)UILabel *chiDayLabel;
//@property (nonatomic,weak) UIButton *cancelBtn;
@end
