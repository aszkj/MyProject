//
//  JGInputPayPassword.h
//  jingGang
//
//  Created by dengxf on 16/1/11.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  输入支付密码界面 */
@interface JGInputPayPassword : UIViewController
/**
 *  提现金额 */
@property (weak, nonatomic) IBOutlet UILabel *amountLab;

- (instancetype)initWithInputPasswordCompleted:(void(^)(NSString *passwordKey))complete cancel:(void(^)())cancel;

@end
