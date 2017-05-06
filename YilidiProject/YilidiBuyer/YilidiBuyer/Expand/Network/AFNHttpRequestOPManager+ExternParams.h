//
//  AFNHttpRequestOPManager+ExternParams.h
//  YilidiBuyer
//
//  Created by yld on 16/6/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"

@interface AFNHttpRequestOPManager (ExternParams)

/**
 *  设置通用的扩展参数
 *
 *  @param baseParam 基础参数
 *
 *  @return 添加扩展参数后的参数
 */
+ (NSDictionary *)setNormExternParamAtBaseParam:(NSDictionary *)baseParam;

/**
 *  设置特殊的扩展参数，比如验证码
 *
 *  @param veryCode  验证码
 *  @param baseParam 基础参数
 *
 *  @return  添加扩展参数后的参数
 */
+ (NSDictionary *)setSpecitalExternParmOfVeryCode:(NSString *)veryCode
                                     atBaseParam:(NSDictionary *)baseParam;

@end
