//
//  AFNHttpRequestOPManager+log.h
//  YilidiBuyer
//
//  Created by mm on 17/1/22.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"

@interface AFNHttpRequestOPManager (log)

+(void)logWithRequestParam:(NSDictionary *)requestParam
                requestUrl:(NSString *)requestUrl;

+(void)logWithResponseObject:(id)responseObj
                htppResponse:(NSHTTPURLResponse *)htppResponse
           responseErrorInfo:(NSError *)responseErrorInfo
                  requestUrl:(NSString *)requestUrl
                requestParam:(NSDictionary *)requestParam;

@end
