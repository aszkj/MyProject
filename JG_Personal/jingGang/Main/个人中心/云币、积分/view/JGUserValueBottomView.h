//
//  JGUserValueBottomView.h
//  jingGang
//
//  Created by dengxf on 16/1/6.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGIntegralValueController.h"
typedef NS_ENUM(NSUInteger, BottomButtonType) {
    BottomButtonPayType = 0, // 充值
    BottomButtonCashType,    // 提现
    BottomButtonExchangeType // 立即兑换
};


typedef void(^BottomButtonClickBlock)(BottomButtonType type);

@interface JGModelButton : UIButton

- (instancetype)initWithTitle:(NSString *)title titleFont:(UIFont *)font backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

@end


@interface JGUserValueBottomView : UIView

@property (copy , nonatomic) BottomButtonClickBlock bottomButtonClickBlock;

- (instancetype)initWithType:(ControllerValueType)type clickButtonAction:(void(^)(BottomButtonType type))action;

@property (nonatomic,assign)NSInteger cloudValue;


@end
