//
//  JGBankInfoModel.h
//  jingGang
//
//  Created by dengxf on 16/1/11.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 银行信息模型  */
@interface JGBankInfoModel : NSObject
/**
 *  银行图标 */
@property (strong,nonatomic) NSString *bankIncoImageName;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *cardNumber;
@property (strong,nonatomic) NSString *openAccoutBank;
@property (strong,nonatomic) NSString *branchBank;
@end