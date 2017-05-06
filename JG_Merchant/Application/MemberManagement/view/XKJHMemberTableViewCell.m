//
//  XKJHMemberTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHMemberTableViewCell.h"

@interface XKJHMemberTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation XKJHMemberTableViewCell

- (void)awakeFromNib {

}

- (void)willCustomCellWith:(NSDictionary *)dict
{
    self.nickNameLabel.text = dict[@"nickname"];
    self.mobileLabel.text = dict[@"mobile"];
//    self.createTimeLabel.text = [NSString stringWithFormat:@"注册时间：%@",[Util getStringFormaDate:dict[@"accountCreateTime"]]];
    self.createTimeLabel.text = [NSString stringWithFormat:@"注册时间：%@",[Util getStringFormaDateWithTailSecond:dict[@"accountCreateTime"]]];
    //0邀请码1首次消费
    self.typeLabel.text = [NSString stringWithFormat:@"来源：%@",[dict[@"relationType"] intValue] ? @"首次消费":@"邀请码"];
}


@end
