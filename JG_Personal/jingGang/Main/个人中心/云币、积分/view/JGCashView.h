//
//  JGCashView.h
//  jingGang
//
//  Created by dengxf on 16/1/7.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKScrollView.h"
#import "JGUserSelectCashTypeController.h"
#import "JGCloudAndValueManager.h"

/**
 *  设置支付密码类型
 */
typedef NS_ENUM(NSUInteger, JGSettingPayPasswordType) {
    /**
     *  设置支付密码 */
    SettingPayPasswordType = 0,
    /**
     *  忘记密码去设置 */
    ForgetPayPasswordType
};

typedef void(^SettingPayPasswordAction)(JGSettingPayPasswordType type);

/***  云币提现视图 */
@interface JGCashView : UIView

/**
 *  用户可用云币 */
@property (copy , nonatomic) NSString *totleValue;

/**
 *  查询用户默认提现账户表单
 */
@property (strong,nonatomic) CloudForm *cloudPredepositCash;


@property (weak, nonatomic) IBOutlet UIView *valueView;

/**
 *  用户设置支付密码 */
@property (copy , nonatomic) SettingPayPasswordAction settingPayPasswordAction;

// 选择支付方式
- (IBAction)selecetPayTypeAction:(UIButton *)sender;

- (instancetype)initWithCashActionSuccess:(void(^)(CloudBuyerCashSaveResponse *))cashSuccess;

@end
