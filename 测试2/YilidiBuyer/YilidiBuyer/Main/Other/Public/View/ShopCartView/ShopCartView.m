//
//  ShopCartView.m
//  YilidiBuyer
//
//  Created by yld on 16/6/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartView.h"
#import "ShopCartGoodsManager.h"
#import "ProjectRelativeDefineNotification.h"
#import "UIButton+Block.h"
#import "UIButton+Design.h"
#import <Masonry/Masonry.h>

@interface ShopCartView()



@end

@implementation ShopCartView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _setupUI];
        [self initShopCartGoods];
        [self _regiterNotification];
    }
    return self;
}

- (void)_regiterNotification {
    [kNotification addObserver:self selector:@selector(shopCartGoodsNumberChange:) name:KNotificationShopCartBadgeValueNeedChange object:nil];
}

-(void)initShopCartGoods {
    self.shopCartBadgeNumber = [ShopCartGoodsManager sharedManager].shopCartGoodsNumber;
}

- (void)_setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.bgView = [UIView new];
    [self addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
//    self.bgView.alpha = 1;
    //UIView设置阴影
    self.bgView.layer.shadowColor = UIColorFromRGB(0xacacac).CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 2);
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowRadius=3;
    self.bgView.layer.cornerRadius = 25;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.shopCartButton = [UIButton new];
    [self addSubview:self.shopCartButton];
    [self.shopCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(23, 23));
    }];
    [self.shopCartButton setImage:IMAGE(@"shoppingCart") forState:UIControlStateNormal];
    WEAK_SELF
    [self.shopCartButton addActionHandler:^(NSInteger tag) {
        emptyBlock(weak_self.gotoShopCartPageBlock);
    }];
    [self.shopCartButton setEnlargeEdge:5];
    self.messageLabel = [UILabel new];
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.shopCartButton.mas_right);
        make.centerY.mas_equalTo(self.shopCartButton.mas_top).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    self.messageLabel.textColor = [UIColor whiteColor];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.font = [UIFont boldSystemFontOfSize:8.0f];
    self.messageLabel.layer.masksToBounds = YES;
    self.messageLabel.layer.cornerRadius = 8.0f;
    self.messageLabel.backgroundColor = UIColorFromRGB(0xff3a30);
}

- (void)_showShopCartButtonAnimation {
    
    self.shopCartButton.transform = CGAffineTransformMakeTranslation(0, 3);
    [UIView animateWithDuration:0.8 delay:0.3 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.shopCartButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)_showShopCartMessageLabelScaleAnimation {
    self.messageLabel.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.8 delay:0.3 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.messageLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)_showShopCartMessageLabelShakingAnimation
{
    self.messageLabel.transform =  CGAffineTransformMakeTranslation(0, -3);
    [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.messageLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setShopCartBadgeNumber:(NSInteger)shopCartBadgeNumber {
    _shopCartBadgeNumber = shopCartBadgeNumber;
    self.messageLabel.hidden = !_shopCartBadgeNumber;
    if (_shopCartBadgeNumber) {
        self.messageLabel.text = jFormat(@"%ld",_shopCartBadgeNumber);
    }
}

- (void)_showShopCartItemAnimation {
    [self _showShopCartButtonAnimation];
    [self _showShopCartMessageLabelShakingAnimation];
    [self _showShopCartMessageLabelScaleAnimation];
}

- (void)_configureYellowBg {
    self.bgView.hidden = !self.neetoShowYellowBg;
}

- (void)setNeetoShowYellowBg:(BOOL)neetoShowYellowBg {
    _neetoShowYellowBg = neetoShowYellowBg;
    [self _configureYellowBg];
    
}

- (void)shopCartGoodsNumberChange:(NSNotification *)info {
    BOOL isAdd = [info.object boolValue];
    if (isAdd) {
        [self _showShopCartItemAnimation];
    }else {
        [self _showShopCartMessageLabelScaleAnimation];
    }
    self.shopCartBadgeNumber = [ShopCartGoodsManager sharedManager].shopCartGoodsNumber;
}

- (void)dealloc
{
    [kNotification removeObserver:self];
}

@end
