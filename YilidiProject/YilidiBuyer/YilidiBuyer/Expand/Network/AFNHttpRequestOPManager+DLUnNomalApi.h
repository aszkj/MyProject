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

+ (void )postUserHeadImageData:(NSData *)data
                     imageUrl :(NSString *)headUrl
                        subUrl:(NSString *)suburl
                         block:(void (^)(NSDictionary *resultDic, NSError *error))block;

+ (void)requestNearbyShopWithlongtitude:(CGFloat)longtide
                               latitude:(CGFloat)latitude
                                  block:(void (^)(id result, NSError *error))block;

@end
