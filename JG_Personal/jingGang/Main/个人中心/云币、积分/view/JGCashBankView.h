//
//  JGCashBankView.h
//  jingGang
//
//  Created by dengxf on 16/1/8.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGCashBankView : UIView

/**
 *  持卡人本人姓名 */
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

/**
 *  银行卡号 */
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumberTextField;

/**
 *  开户银行 */
@property (weak, nonatomic) IBOutlet UITextField *openAccountBankTextField;

/**
 *  开户支行 */
@property (weak, nonatomic) IBOutlet UITextField *branchBankTextField;

/**
 *  初始化银行卡视图 点击确定返回已选择的银行信息(是一个字典) */
- (instancetype)initWithCashBankViewForSelectedBankWithInfoBlock:(void(^)(NSDictionary *dic))infoDictBlock;

- (IBAction)selecteBankForCardAction:(id)sender;

@end
