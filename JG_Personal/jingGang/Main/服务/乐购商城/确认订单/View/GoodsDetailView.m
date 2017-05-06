//
//  GoodsDetailView.m
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsDetailView.h"
#import "Masonry.h"

@interface GoodsDetailView ()

@property (weak, nonatomic) IBOutlet UIView *jifengView;
@property (weak, nonatomic) IBOutlet UIButton *selecBtn;


@end

@implementation GoodsDetailView


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content


#pragma mark - event response

- (IBAction)selectAction:(UIButton *)sender {
    if (sender.isSelected) {
        [sender setSelected:NO];
    } else {
        [sender setSelected:YES];
    }
    if (self.selectedBlock) {
        self.selectedBlock(sender.isSelected);
    }
}

#pragma mark - set UI init

- (void)setAppearence
{
    self.clipsToBounds = YES;
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self;
    CGFloat leftDis = 8;
    [self.goodsLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(7.5);
        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.left.equalTo(superView).with.offset(leftDis);
    }];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsLogo);
        make.left.equalTo(self.goodsLogo.mas_right).with.offset(leftDis);
        make.right.equalTo(superView).with.offset(-leftDis);
    }];
    [self.goodsSpecInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsName.mas_bottom).with.offset(5);
        make.left.equalTo(self.goodsName);
        make.right.equalTo(superView).with.offset(-4);
    }];
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodsLogo);
        make.left.equalTo(self.goodsName);
    }];
    [self.phoneVIP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16.5);
        make.width.equalTo(@60);
        make.centerY.equalTo(self.goodsPrice);
        make.left.equalTo(self.goodsPrice.mas_right).with.offset(2);
    }];
    [self.goodsNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodsPrice);
        make.right.equalTo(superView).with.offset(-6);
    }];
    [self.jifengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(self.goodsLogo.mas_bottom).with.offset(7.5);
    }];
    [self.selecBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.jifengView);
        make.left.equalTo(self.goodsLogo);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.jifengLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selecBtn);
        make.left.equalTo(self.selecBtn.mas_right);
        make.right.equalTo(superView);
    }];
    self.jifengLB.adjustsFontSizeToFitWidth = YES;
    self.jifengLB.minimumScaleFactor = 0.5;
}

@end
