//
//  DataManager+linkDataHandle.h
//  YilidiBuyer
//
//  Created by yld on 16/8/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DataManager.h"

@interface DataManager (linkDataHandle)
/**
 *  首页轮播广告，楼层广告跳转类型处理
 */
- (NSString *)transferTolinkNotificationNameWithlinkTypeNumber:(NSNumber *)linkTypeNumber
                                                   linkDataDic:(NSDictionary *)linkDataDic;
/**
 *  楼层跳转类型处理
 */
- (NSString *)transferTolinkNotificationNameWithFloorlinkTypeNumber:(NSNumber *)linkTypeNumber;
/**
 *  将linkData，key&value形式转成字典
 */
- (NSDictionary *)transferToDicWithLinkCodeStr:(NSString *)linkCodeStr
                                linkTypeNumber:(NSNumber *)linkTypeNumber;

- (NSString *)canLinkCodeStrJump:(NSString *)linkCodeStr
                  linkTypeNumber:(NSNumber *)linkTypeNumber;



@end
