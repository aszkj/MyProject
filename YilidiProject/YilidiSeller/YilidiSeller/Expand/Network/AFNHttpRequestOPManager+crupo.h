//
//  AFNHttpRequestOPManager+crupo.h
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"

@interface AFNHttpRequestOPManager (crupo)

/**
 *  将基本输入参数转换为base64加密的参数
 */
+ (NSDictionary *)transferToBase64ParamWithTheBasicParam:(NSDictionary *)baseParam;
/**
 *  将输出参数进行base64解密变成普通返回值
 */
+ (NSDictionary *)tranferToNormalResultWithTheBase64Result:(NSDictionary *)result;

@end
