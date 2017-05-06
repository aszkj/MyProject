//
//  UnderLineOrderManagerTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UnderLineOrderManagerTableViewCell.h"
#import "PublicInfo.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "APIManager.h"
#import "UIImageView+WebCache.h"

@interface UnderLineOrderManagerTableViewCell ()
@property (nonatomic) UIButton *cancelButton;

@end

@implementation UnderLineOrderManagerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content
- (void)configWithObject:(id)object {
    MyselfGroupOrder *orderDetail = object;
    [self.serverImage sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(orderDetail.service.goodsMainphotoPath,CGRectGetWidth(self.serverImage.frame),CGRectGetHeight(self.serverImage.frame))] placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];
    [self.shopName setText:orderDetail.ggName];
    [self.serverPriceAndNumber setText:[NSString stringWithFormat:@"总价: %.2f元 数量: %@",orderDetail.totalPrice.floatValue,orderDetail.service.goodsCount]];
    [self setOrderStatusWithNumber:orderDetail.orderStatus.integerValue];
}

/**
 *  由订单状态设置相应的操作
 *
 *  @param orderStatus 订单状态  订单状态，0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,60卖家已评价,65订单不可评价
 */
- (void)setOrderStatusWithNumber:(NSInteger)orderStatus {
    self.actionButton.hidden = YES;
    self.cancelButton.hidden = YES;
    [self.actionButton removeTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    [self.actionButton removeTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    self.actionButton.backgroundColor = [UIColor whiteColor];
    self.actionButton.layer.borderColor = status_color.CGColor;
    [self.actionButton setTitleColor:status_color forState:UIControlStateNormal];
    if (orderStatus == 20) {
        self.orderStatus.text = @"未消费";
    } else if (orderStatus == 10) {
        self.actionButton.hidden = NO;
        self.cancelButton.hidden = NO;
        self.orderStatus.text = @"待付款";
        [self.actionButton setTitle:@"去付款" forState:UIControlStateNormal];
        [self.actionButton addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
        [self MASUpdateConstraints];
    } else if (orderStatus == 30) {
        self.actionButton.hidden = NO;
        self.orderStatus.text = @"已完成";
        [self.actionButton setTitle:@"评论" forState:UIControlStateNormal];
        [self.actionButton addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    } else if (orderStatus == 50 || orderStatus == 60 || orderStatus == 65) {
        self.actionButton.hidden = NO;
        self.orderStatus.text = @"已完成";
        [self.actionButton setTitle:@"已评论" forState:UIControlStateNormal];
        [self.actionButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        self.actionButton.backgroundColor = UIColorFromRGB(0xf7f7f7);
        self.actionButton.layer.borderColor = [UIColor clearColor].CGColor;
    } else if (orderStatus == 0) {
        self.orderStatus.text = @"已取消";
    } else if (orderStatus == 100) {
        self.orderStatus.text = @"已退款";
    }
}

#pragma mark - event response
- (void)cancelAction {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)payAction {
    if (self.payBlock) {
        self.payBlock();
    }
}

- (void)commentAction {
    if (self.commentBlock) {
        self.commentBlock();
    }
}

#pragma mark - set UI init

- (void)setAppearence
{
    self.shopName.textColor = textBlackColor;
    self.serverPriceAndNumber.textColor = textGrayColor;
    self.orderStatus.textColor = textLightGrayColor;
}

#pragma mark - set Constraint
- (void)MASUpdateConstraints
{
    UIView *superView = self.contentView;
    [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverImage);
        make.right.equalTo(superView).with.offset(-4);
//        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
}

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
    [self.shopName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverImage);
        make.left.equalTo(self.serverImage.mas_right).with.offset(10);
        make.right.equalTo(self.cancelButton.mas_left);
    }];
    [self.cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverImage);
        make.right.equalTo(superView).with.offset(-4);
        make.size.mas_equalTo(CGSizeMake(0, 30));
    }];
    [self.serverPriceAndNumber mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopName.mas_bottom).with.offset(4);
        make.left.equalTo(self.shopName);
        make.right.equalTo(self.shopName);
    }];
    [self.orderStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.serverImage).with.offset(-4);
        make.left.equalTo(self.shopName);
    }];
    [self.actionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.orderStatus);
        make.right.equalTo(superView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];
}

#pragma mark - getters and settters
- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_cancelButton setTitleColor:status_color forState:UIControlStateNormal];
        _cancelButton.hidden = YES;
        [self.contentView addSubview:_cancelButton];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIView *)colorView:(UIColor *)backgroundColor {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = backgroundColor;
    return view;
}

@end
