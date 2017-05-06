//
//  SubRunDetailTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "SubRunDetailTableViewCell.h"
#import <NIAttributedLabel.h>
#import "Rebate.h"
#import "NSDate+Utilities.h"

@interface SubRunDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet NIAttributedLabel *serverName;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end

@implementation SubRunDetailTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content
- (void)configData:(id)object {
    Rebate *rebate = (Rebate *)object;
    [self setServerNameWithString:rebate.ggName];
    self.usrMessage.text = [NSString stringWithFormat:@"%@ %@",rebate.userNickName,rebate.mobile];
    self.serverCode.text = [NSString stringWithFormat:@"消费码:%@",rebate.groupSn==nil? @"无": rebate.groupSn];
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date = [dateFormatter dateFromString:(NSString *)rebate.createTime];
//    self.upTime.text = [@"结算时间:" stringByAppendingString:[NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",date.year,(long)date.month,(long)date.day,(long)date.hour,(long)date.minute]];
    self.upTime.text = [@"结算时间:" stringByAppendingString:[Util getStringFormaDate:(NSString *)rebate.createTime]];
    self.recommendMoney.text = [NSString stringWithFormat:@"%@：¥%@",rebate.rabate,rebate.rebateAmount.stringValue];
}


#pragma mark - event response


#pragma mark - set UI init

- (void)setAppearence
{
    self.contentView.backgroundColor = [UIColor clearColor];
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    UIView *topLine = [self lineView:[UIColor grayColor]];
    [superView addSubview:topLine];
    [topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.top.equalTo(superView).with.offset(5);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    UIView *bottomLine = [self lineView:[UIColor grayColor]];
    [superView addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    UIView *topView = [self lineView:[UIColor whiteColor]];
    [superView addSubview:topView];
    [superView sendSubviewToBack:topView];
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.serverName mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(topLine).with.offset(15);
        make.centerY.equalTo(topView);
        make.right.equalTo(superView).with.offset(-10);
        make.left.equalTo(superView).with.offset(10);

    }];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(49.0);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(63));
        make.bottom.equalTo(superView);
    }];
    
    superView = self.bottomView;
    [self.usrMessage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(10);
        make.right.equalTo(superView.mas_centerX).with.offset(3);
        make.top.equalTo(superView).with.offset(12);
    }];
    [self.recommendMoney mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usrMessage);
        make.right.equalTo(superView).with.offset(-10);
        make.left.equalTo(superView.mas_centerX).with.offset(3);
    }];
    [self.serverCode mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usrMessage.mas_bottom).with.offset(13.5);
        make.left.equalTo(self.usrMessage);
        make.right.equalTo(self.usrMessage).with.offset(-10);
    }];
    [self.upTime mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recommendMoney).with.offset(-10);
        make.right.equalTo(self.recommendMoney);
        make.top.equalTo(self.serverCode);
    }];
//    self.recommendMoney.backgroundColor = [UIColor redColor];
//    self.upTime.backgroundColor = [UIColor blackColor];
}

- (void)setServerNameWithString:(NSString *)name {
    if (name == nil) {  name = @"";  }
    name = [@" " stringByAppendingString:name];
    self.serverName.text = name;
    [self.serverName insertImage:[UIImage imageNamed:@"Heart"]
                       atIndex:0];
}

#pragma mark - getters and settters
- (UIView *)lineView:(UIColor *)color {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = color;
    return lineView;
}

@end
