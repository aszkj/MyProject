//
//  NSError+weimiError.h
//  weimi
//
//  Created by 张康健 on 16/2/23.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (weimiError)


/**
 *  统一处理服务端错误
 *
 *  @param error            后台生成的error,优先处理
 *  @param response         后台返回可能包含自定义的errorDescription,当error == nil 时处理
 */
+ (NSString *)checkErrorFromServer:(NSError *)error response:(id)output;

/**
 *  处理登陆错误
 */
+ (NSString *)errorStrWithError:(NSError *)error;


@end

//@interface WEMEApiClient (errorHandle)
//@end