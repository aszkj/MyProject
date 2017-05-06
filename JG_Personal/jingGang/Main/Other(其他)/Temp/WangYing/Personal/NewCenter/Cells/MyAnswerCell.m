//
//  MyAnswerCell.m
//  jingGang
//
//  Created by wangying on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "MyAnswerCell.h"

@interface MyAnswerCell ()

@end
@implementation MyAnswerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)getData:(NSInteger)index
{
    self.iconImg.image = [UIImage imageNamed:@"AnswerIcon"];
    self.iconImg.layer.cornerRadius = self.iconImg.frame.size.width/2;
    self.iconImg.layer.borderWidth = 3;
    self.iconImg.clipsToBounds = YES;
    self.iconImg.layer.borderColor = [[UIColor colorWithRed:89/255.0 green:196/255.0 blue:241/255.0 alpha:1]CGColor];
    self.questText.text =  @"回答专家：妇科医生韩定心";
    self.AnswerText.text =@"涨了豆豆怎么办";
    self.timeText.text = @"最后回答时间：2015.5.21 16:37";
}
@end
