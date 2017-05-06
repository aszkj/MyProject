//
//  WEMEModelExtension.m
//  weimi
//
//  Created by ray on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "WEMEModelExtension.h"
#import "WEMECache.h"
#import <WEMEUsercontrollerApi.h>

@implementation WEMESimpleUser (Extension)

static NSString *SELFID = @"-1";

+ (void)getWithUID:(NSString *)uid completeBlock:(void (^)(WEMESimpleUser * user))completeBlock
{
    if (completeBlock == nil || [uid isEqualToString:@"0"]) return;
    
    NSDictionary *simpleUser = (NSDictionary *)[[WEMECache userCache] objectForKey:uid];
    if (simpleUser != nil) {
        completeBlock([WEMESimpleUser objectWithKeyValues:simpleUser]);
    } else {
        
        [[WEMEUsercontrollerApi sharedAPI] getUserProfileUsingGETWithCompletionBlock:[NSNumber numberWithLongLong:[uid longLongValue]] completionHandler:^(WEMESingleObjectValueResponseOfSimpleUser *output, NSError *error) {
            if (output.item == nil) return;
            completeBlock(output.item);
            [[WEMECache userCache] setObject:[output.item keyValues] forKey:uid];
        }];
    }
}

+ (void)getSelfSimpleUserCompleteBlock:(void (^)(WEMESimpleUser * user))completeBlock {
    
    if (completeBlock == nil) return;
    
    NSDictionary *simpleUser = (NSDictionary *)[[WEMECache userCache] objectForKey:SELFID];
    if (simpleUser != nil) {
        completeBlock([WEMESimpleUser objectWithKeyValues:simpleUser]);
    } else {
        [[WEMEUsercontrollerApi sharedAPI] getMyProfileUsingGETWithCompletionBlock:^(WEMESingleObjectValueResponseOfSimpleUser *output, NSError *error) {
            if (output.item == nil) return;
            completeBlock(output.item);
            [[WEMECache userCache] setObject:[output.item keyValues] forKey:SELFID];
        }];
    }
}

+ (void)updateSelfSimpleUser
{
    [[WEMEUsercontrollerApi sharedAPI] getMyProfileUsingGETWithCompletionBlock:^(WEMESingleObjectValueResponseOfSimpleUser *output, NSError *error) {
        
        if (output.item == nil) return;
        [[WEMECache userCache] setObject:[output.item keyValues] forKey:SELFID];
        [kNotification postNotificationName:KNotificationUpdateAvatar object:nil];
    }];
}

@end
