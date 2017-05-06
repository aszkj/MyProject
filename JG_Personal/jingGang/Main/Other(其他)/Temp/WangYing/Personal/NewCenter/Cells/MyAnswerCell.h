//
//  MyAnswerCell.h
//  jingGang
//
//  Created by wangying on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAnswerCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *iconImg;
@property (retain, nonatomic) IBOutlet UILabel *questText;
@property (retain, nonatomic) IBOutlet UILabel *AnswerText;
@property (retain, nonatomic) IBOutlet UILabel *timeText;

-(void)getData:(NSInteger)index;
@end
