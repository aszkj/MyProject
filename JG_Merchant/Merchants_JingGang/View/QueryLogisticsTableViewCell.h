//
//  QueryLogisticsTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryLogisticsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *detailTitle;

- (void)setMessage:(NSString *)message;

- (void)isFirstObjectLineColor:(UIColor *)lineColor pointColor:(UIColor *)pointColor;
- (void)isLastObjecLineColor:(UIColor *)lineColor pointColor:(UIColor *)pointColor;
- (void)setheadColor:(UIColor *)headColor pointColor:(UIColor *)pointColor footColor:(UIColor *)footColor;
@end
