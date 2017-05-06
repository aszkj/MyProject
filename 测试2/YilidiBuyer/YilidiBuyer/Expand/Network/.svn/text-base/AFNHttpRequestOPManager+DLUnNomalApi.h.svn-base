//
//  AFNHttpRequestOPManager+DLUnNomalApi.h
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager.h"
/**
 *  请求一些特殊接口
 */
@interface AFNHttpRequestOPManager (DLUnNomalApi)

+ (void)loginWithAcount:(NSString *)accountName
                 passwd:(NSString *)passwd
                  block:(void (^)(id result, NSError *error))block;

+ (void)wechatAndlogin:(NSDictionary *)loginParam
             submitUrl:(NSString *)url
                 block:(void (^)(id result, NSError *error))block;

+ (void)loginWithPhoneNumber:(NSString *)phoneNumber
                 varyCode:(NSString *)varyCode
                  block:(void (^)(id result, NSError *error))block;

+ (void )postUserHeadImageData:(NSData *)data
                     imageUrl :(NSString *)headUrl
                        subUrl:(NSString *)suburl
                         block:(void (^)(NSDictionary *resultDic, NSError *error))block;

+ (void)bingdingPhoneLogin:(NSDictionary *)dic
                     block:(void (^)(id result, NSError *error))block;

+ (void)requestVaryCodeForPhoneNumber:(NSString *)phoneNumber
                         varyCodeType:(NSNumber *)varyCodeType
                                block:(void (^)(id result, NSError *error))block;


+ (void)requestNearbyShopWithlongtitude:(CGFloat)longtide
                               latitude:(CGFloat)latitude
                                  block:(void (^)(id result, NSError *error))block;

@end
