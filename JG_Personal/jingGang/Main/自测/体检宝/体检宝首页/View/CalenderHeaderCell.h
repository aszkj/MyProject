//
//  CalenderHeaderCell.h
//  jingGang
//
//  Created by 张康健 on 15/7/31.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DisplayCalenderBlock)(NSDate *currentDate);
@interface CalenderHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *timeButton;

//当前选择的日期
@property (nonatomic, strong)NSDate *currentDate;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
