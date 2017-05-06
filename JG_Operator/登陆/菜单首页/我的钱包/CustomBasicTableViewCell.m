//
//  CustomBasicTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "CustomBasicTableViewCell.h"

@interface CustomBasicTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *topLine;

@end


@implementation CustomBasicTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content


#pragma mark - event response


#pragma mark - set UI init

- (void)setAppearence
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(changeFrames:)
//                                                 name:UIDeviceOrientationDidChangeNotification
//                                               object:nil];
}

#pragma mark - set Constraint
- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    [superView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@(48));
        make.width.greaterThanOrEqualTo(@(CGRectGetWidth([UIScreen mainScreen].bounds)));
        make.left.equalTo(self);
    }];
    [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(10);
        make.centerY.equalTo(superView);
    }];
    [self.basicTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).with.offset(10);
        make.centerY.equalTo(superView);
    }];
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView).with.offset(-10);
        make.centerY.equalTo(superView);
    }];
    [self.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.top.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
}

#pragma mark - getters and settters
- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    if (accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        self.rightImageView.image = [UIImage imageNamed:@"Haircut"];
    }
}

- (UIView *)lineView:(UIColor *)color {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = color;
    return lineView;
}

@end
