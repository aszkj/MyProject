//
//  IntegralTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralTableViewCell.h"
#import "Masonry.h"

@interface IntegralTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UILabel *firstIntegral;
@property (weak, nonatomic) IBOutlet UILabel *secondIntegral;
@property (weak, nonatomic) IBOutlet UIView *centerVIew;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation IntegralTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content


#pragma mark - event response

- (IBAction)selectIntegral:(UIButton *)sender {
    NSLog(@"sender state: %lu",(unsigned long)sender.state);
    if (sender.isSelected) {
        [sender setSelected:NO];
        if (sender == self.firstBtn) {
            _selectedJiFeng = YES;
        } else if (sender == self.secondBtn) {
            _selectedYunBi = YES;
        }

    } else {
        [sender setSelected:YES];
        if (sender == self.firstBtn) {
            _selectedJiFeng = NO;
        } else if (sender == self.secondBtn) {
            _selectedYunBi = NO;
        }
    }
    
}

#pragma mark - set UI init

- (void)setAppearence
{

}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@10);
    }];
    
    superView = self.backView;
    CGFloat onePXHeight = 1 / [UIScreen mainScreen].scale;
    [self.centerVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
        make.height.equalTo(@(onePXHeight));
        make.width.equalTo(superView);
    }];
    [self.firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView).multipliedBy(0.5);
        make.left.equalTo(superView).with.offset(20);
        make.top.equalTo(superView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.firstIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.firstBtn);
        make.left.equalTo(self.firstBtn.mas_right).with.offset(8);
    }];
    [self.secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView).multipliedBy(1.5);
        make.left.equalTo(self.firstBtn);
        make.size.mas_equalTo(self.firstBtn);
    }];
    [self.secondIntegral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstIntegral);
        make.centerY.equalTo(self.secondBtn);
    }];
}

@end
