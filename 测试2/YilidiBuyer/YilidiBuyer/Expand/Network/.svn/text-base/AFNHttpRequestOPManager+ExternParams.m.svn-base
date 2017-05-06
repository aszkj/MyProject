//
//  AFNHttpRequestOPManager+ExternParams.m
//  YilidiBuyer
//
//  Created by yld on 16/6/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+ExternParams.h"
#import "Util.h"
#import "CHKeychain.h"
 

@implementation AFNHttpRequestOPManager (ExternParams)

+ (NSDictionary *)setNormExternParamAtBaseParam:(NSDictionary *)baseParam
{
    NSMutableDictionary *newParamDic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (baseParam) {
        [newParamDic addEntriesFromDictionary:baseParam];
    }
    NSString *deviceId = [[self class] _dealDeviceId];
    NSString *appBuidlVersion = [Util appVersion];
    NSNumber *appChannelNumber = @2;
    
    [newParamDic setObject:deviceId forKey:@"deviceId"];
    [newParamDic setObject:appBuidlVersion forKey:@"versionCode"];
    [newParamDic setObject:appChannelNumber forKey:@"intfCallChannel"];

    return [newParamDic copy];
}


+ (NSString *)_dealDeviceId {
    
    NSString *deviceId = nil;
    NSMutableDictionary *deviceIdDic = (NSMutableDictionary *)[CHKeychain load:DEVICEID_IN_KECHAIN];
    NSString *deviceIdInKeyChain = deviceIdDic[DEVICEIDKEY];
    if (isEmpty(deviceIdInKeyChain)) {
        deviceId = [Util deviceID];
        NSMutableDictionary *tempdeviceIdDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [tempdeviceIdDic setObject:deviceId forKey:DEVICEIDKEY];
        [CHKeychain save:DEVICEID_IN_KECHAIN data:tempdeviceIdDic];
    }else {
        deviceId = deviceIdInKeyChain;
    }
    return deviceId;
}


+ (NSDictionary *)setSpecitalExternParmOfVeryCode:(NSString *)veryCode
                                     atBaseParam:(NSDictionary *)baseParam
{

    NSMutableDictionary *newParamDic = [NSMutableDictionary dictionaryWithDictionary:baseParam];
    [newParamDic setObject:veryCode forKey:@"key"];
    return [newParamDic copy];
}


@end
