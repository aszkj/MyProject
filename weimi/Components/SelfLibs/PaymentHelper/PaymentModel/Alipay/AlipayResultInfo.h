//
//  AlipayResultInfo.h
//  XIXINProject
//
//  Created by apple_02 on 15/5/13.
//  Copyright (c) 2015年 ciwong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayResultInfo : NSObject

@property (nonatomic, strong) NSString *tradeNO;    //订单号
@property (nonatomic, strong) NSString *partner;    //商户号
@property (nonatomic, strong) NSString *seller;     //商家
@property (nonatomic, strong) NSString *privateKey; //私钥

@end
