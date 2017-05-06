//
//  CollectionServerTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "CollectionServerTableViewCell.h"
#import "Masonry.h"
#import "PublicInfo.h"

@interface CollectionServerTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *optionButton;

@end


@implementation CollectionServerTableViewCell
- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content


#pragma mark - event response
- (IBAction)clickOption:(id)sender {
    if (self.optionBlock) {
        self.optionBlock(self.indexPath);
    }
}


#pragma mark - set UI init

- (void)setAppearence
{
    self.serverPrice.textColor = UIColorFromRGB(0x5ac4f1);
    self.serverName.textColor = textBlackColor;
    self.shopName.textColor = textGrayColor;
    self.contentView.backgroundColor = [UIColor clearColor];
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    UIView *topView = [self colorView:[UIColor lightGrayColor]];
    [superView addSubview:topView];
    UIView *bottomView = [self colorView:[UIColor lightGrayColor]];
    [superView addSubview:bottomView];
    UIView *whiteBackView = [self colorView:[UIColor whiteColor]];
    [superView addSubview:whiteBackView];
    [superView sendSubviewToBack:whiteBackView];
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(10);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(0.5));
    }];
    [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(0.5));
    }];
    [whiteBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
    superView = whiteBackView;
    [self.serverImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(125, 90));
        make.top.equalTo(superView).with.offset(10);
        make.left.equalTo(superView).with.offset(8);
        make.bottom.equalTo(superView).with.offset(-10);
    }];
    [self.serverName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverImage);
        make.left.equalTo(self.serverImage.mas_right).with.offset(10);
        make.right.equalTo(superView).with.offset(-10);
    }];
    [self.shopName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverName.mas_bottom).with.offset(4);
        make.left.equalTo(self.serverName);
        make.right.equalTo(self.serverName);
    }];
    [self.serverPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.serverImage).with.offset(-4);
        make.left.equalTo(self.shopName);
    }];
    [self.optionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.bottom.equalTo(self.serverPrice);
        make.right.equalTo(self.shopName);
    }];
}

#pragma mark - getters and settters
- (UIView *)colorView:(UIColor *)backgroundColor {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = backgroundColor;
    return view;
}

@end
