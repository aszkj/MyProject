//
//  AFNHttpRequestOPManager+crupo.m
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+crupo.h"
#import "SUIUtils.h"
#import <MJExtension/MJExtension.h>
@implementation AFNHttpRequestOPManager (crupo)

+ (NSDictionary *)transferToBase64ParamWithTheBasicParam:(NSDictionary *)baseParam {
    
    NSString *base64EncodeParamStr = [[baseParam JSONString] sui_base64Encode];
    
    return @{@"param":[base64EncodeParamStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
}

+ (NSDictionary *)tranferToNormalResultWithTheBase64Result:(NSDictionary *)result{
    
    NSString *resultStr = [result[@"result"] sui_base64Decode];
    return (NSDictionary *)[resultStr JSONObject];
}



@end
