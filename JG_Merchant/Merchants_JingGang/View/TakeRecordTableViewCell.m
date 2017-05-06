//
//  TakeRecordTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "TakeRecordTableViewCell.h"
#import "UPrepositLog.h"
#import "NSDate+Utilities.h"

@interface TakeRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation TakeRecordTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content
- (void)configData:(id)object {
    UPrepositLog *cashLog = (UPrepositLog *)object;
    [self setTakeStatus:cashLog.cashStatus.integerValue cause:cashLog.cashAdminInfo];
    [self setTakeRecordTime:(NSString *)cashLog.addTime amount:cashLog.cashAmount];
}

- (void)setTakeRecordTime:(NSString *)time amount:(NSNumber *)cashAmount {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:time];
    NSString *string = [NSString stringWithFormat:@"您于%ld年%ld月%ld日%ld:%ld 提现￥%@",
                        date.year,date.month,date.day,(long)date.hour,(long)date.minute,cashAmount.stringValue];
    NSMutableAttributedString *attributString = [[NSMutableAttributedString alloc] initWithString:string];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
//                                   [UIFont systemFontOfSize:14.0],NSFontAttributeName,
                                   status_color,NSForegroundColorAttributeName,
                                   nil
                                   ];
    NSRange range = [attributString.string rangeOfString:[@"￥" stringByAppendingString:cashAmount.stringValue]];
    [attributString addAttributes:attributeDict range:range];
    self.takeRecordLabel.attributedText = attributString.copy;
}

#pragma mark - set UI init

- (void)setAppearence
{
    self.backgroundColor = [UIColor clearColor];
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
    UIView *backView = [self lineView:[UIColor whiteColor]];
    [superView addSubview:backView];
    [superView sendSubviewToBack:backView];
    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(topLine.mas_bottom);
        make.bottom.equalTo(bottomLine.mas_top);
    }];
    
    [self.takeRecordLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.takeRecordLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.takeRecordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine).with.offset(13);
        make.left.equalTo(superView).with.offset(10);
        make.right.equalTo(superView).with.offset(-10);
    }];
    [self.statusImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.takeRecordLabel);
        make.top.equalTo(self.takeRecordLabel.mas_bottom).with.offset(7.5);

    }];
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusImageView.mas_right).with.offset(-6);
        make.top.equalTo(self.statusImageView);
        make.height.equalTo(self.statusImageView);
        make.centerY.equalTo(self.statusImageView);
        make.bottom.equalTo(superView).with.offset(-13);
    }];
    [superView bringSubviewToFront:self.statusImageView];
}

#pragma mark - getters and settters
- (UIView *)lineView:(UIColor *)color {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = color;
    return lineView;
}

- (void)setTakeStatus:(XKJHTakeStatus)takeStatus cause:(NSString *)cause {
    _takeStatus = takeStatus;
    if (takeStatus == XKJHTakeStatusFail) {
        self.statusImageView.image = [UIImage imageNamed:@"takeFail_icon"];
        self.statusLabel.text = [NSString stringWithFormat:@"   %@",cause];
    } else if (takeStatus == XKJHTakeStatusWait) {
        self.statusImageView.image = [UIImage imageNamed:@"under review"];
        self.statusLabel.text = @"  审核中  ";
    } else if (takeStatus == XKJHTakeStatusSuccess) {
        self.statusImageView.image = [UIImage imageNamed:@"Withdrawals success"];
        self.statusLabel.text = @"  提现成功  ";
    }
    
}

@end
