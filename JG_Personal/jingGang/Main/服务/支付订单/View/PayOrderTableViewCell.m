//
//  PayOrderTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PayOrderTableViewCell.h"
#import "Masonry.h"
#import "UIButton+Design.h"

@interface PayOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UIControl *tapControl;
@property (weak, nonatomic) IBOutlet UIButton *thirdPaySelectBgBtn;

@end


@implementation PayOrderTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content

- (IBAction)tapAction:(id)sender {
    [self selectPayWay:self.selectBtn];
}
- (IBAction)thirdPaySelectBtnAction:(id)sender {
    
    [self selectPayWay:self.selectBtn];
    
}

- (IBAction)selectPayWay:(UIButton *)sender {
    if (sender.isSelected) {
        [sender setSelected:NO];
        
    } else {
        [sender setSelected:YES];
        if (self.selectPayBlock) {
            self.selectPayBlock(self.selectBtn);
        }
    }

}


#pragma mark - event response


#pragma mark - set UI init

- (void)setAppearence
{
    [self.selectBtn setEnlargeEdgeWithTop:20 right:0 bottom:20 left:0];
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    CGFloat leftDis = 5;
    UIView *superView = self.contentView;
    [self.payImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62, 38));
        make.left.equalTo(superView).with.offset(leftDis);
        make.top.equalTo(superView).with.offset(8);
        make.centerY.equalTo(superView);
    }];
    [self.payTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payImage);
        make.left.equalTo(self.payImage.mas_right).with.offset(leftDis);
    }];
    [self.payInform mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.payImage);
        make.left.equalTo(self.payTitle);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.equalTo(superView).with.offset(-12);
    }];
    [self.tapControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.selectBtn).multipliedBy(2.0);
        make.right.equalTo(self.selectBtn);
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
    
    [self.thirdPaySelectBgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.edges.mas_equalTo(self.contentView);
        
    }];
}


@end
