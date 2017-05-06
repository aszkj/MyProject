//
//  JGUserValueBottomView.m
//  jingGang
//
//  Created by dengxf on 16/1/6.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGUserValueBottomView.h"
#import "GlobeObject.h"

@implementation JGModelButton

- (instancetype)initWithTitle:(NSString *)title titleFont:(UIFont *)font backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = font;
        self.backgroundColor = backgroundColor;
        self.layer.cornerRadius = cornerRadius;
    }
    return self;
}

@end

@interface JGUserValueBottomView ()

// 充值按钮
@property (strong,nonatomic) JGModelButton *payButton;

// 提现按钮
@property (strong,nonatomic) JGModelButton *cashButton;

// 立即兑换
@property (strong,nonatomic) JGModelButton *exchangeButton;

// 类型
@property (assign, nonatomic) ControllerValueType valueType;

@end


@implementation JGUserValueBottomView

- (instancetype)initWithType:(ControllerValueType)type clickButtonAction:(void (^)(BottomButtonType))action {
    if (self = [super init]) {
        [self setupWithType:type];
        self.bottomButtonClickBlock = action;
    }
    return self;
}

- (void)setupWithType:(ControllerValueType)type {
    self.valueType = type;
    UIView *sepLineView = [[UIView alloc] init];
    sepLineView.x = 0;
    sepLineView.y = 0;
    sepLineView.width = kScreenWidth;
    sepLineView.height = 1;
    sepLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.23];
    [self addSubview:sepLineView];
    
    switch (type) {
        case IntegralControllerType:
        {
            JGModelButton *exchangeButton = [[JGModelButton alloc] initWithTitle:@"立即兑换" titleFont:[UIFont systemFontOfSize:16] backgroundColor:status_color cornerRadius:3];
            [exchangeButton addTarget:self action:@selector(exchangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:exchangeButton];
            self.exchangeButton = exchangeButton;
        }
            break;
        case CloudValueControllerType:
        {
            // 我的云币
            JGModelButton *payButton = [[JGModelButton alloc] initWithTitle:@"充值" titleFont:[UIFont systemFontOfSize:16] backgroundColor:status_color cornerRadius:3];
            [payButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:payButton];
            self.payButton = payButton;
            
            JGModelButton *cashButton = [[JGModelButton alloc] initWithTitle:@"提现" titleFont:[UIFont systemFontOfSize:16] backgroundColor:kGetColor(170, 170, 170) cornerRadius:3];
            [cashButton addTarget:self action:@selector(cashAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cashButton];
            self.cashButton = cashButton;
        }
        default:
            break;
    }
}

- (void)setCloudValue:(NSInteger)cloudValue
{
    _cloudValue = cloudValue;
    if (cloudValue < 100) {
        
    }else{
        self.cashButton.backgroundColor = status_color;
    }
}

// 立即兑换
- (void)exchangeButtonAction:(UIButton *)btn {
    BLOCK_EXEC(self.bottomButtonClickBlock, BottomButtonExchangeType);
}

// 充值
- (void)payAction:(UIButton *)btn {
    BLOCK_EXEC(self.bottomButtonClickBlock, BottomButtonPayType);
}

// 提现
- (void)cashAction:(UIButton *)btn {
    BLOCK_EXEC(self.bottomButtonClickBlock, BottomButtonCashType);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonWidth = 188 / 2;
    CGFloat buttonHeight = 33;
    CGFloat buttonOriginY = 12;
    
    switch (self.valueType) {
        case IntegralControllerType:
        {
            self.exchangeButton.x = (kScreenWidth - buttonWidth) / 2;
            self.exchangeButton.y = buttonOriginY;
            self.exchangeButton.width = buttonWidth;
            self.exchangeButton.height = buttonHeight;
        }
            break;
        case CloudValueControllerType:
        {
            CGFloat buttonMargin = 40;
            self.payButton.x = (kScreenWidth - buttonMargin) / 2 - buttonWidth;
            self.payButton.y = buttonOriginY;
            self.payButton.width = buttonWidth;
            self.payButton.height = buttonHeight;
            self.cashButton.x = (kScreenWidth + buttonMargin) / 2;
            self.cashButton.y = self.payButton.y;
            self.cashButton.width = self.payButton.width;
            self.cashButton.height = self.payButton.height;
        }
            break;
        default:
            break;
    }
}

@end
