//
//  JGUserSelectCashTypeController.h
//  jingGang
//
//  Created by dengxf on 16/1/8.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGBankInfoModel.h"
#import "JGAliInfoModel.h"

@interface JGUserSelectCashTypeController : UIViewController

/**
 *  默认提现表单
 */
@property (strong,nonatomic) id cloudPredepositCash;

/**
 *  选择支付方式信息实例
 *
 *  @param close 点击关闭，界面消失
 *  @param info  点击关闭，带有信息 */
- (instancetype)initWithSelecteCashControllerWithCloseBlock:(void(^)())close infoBlock:(void(^)(NSInteger selectPayType,id model))info;

@end
