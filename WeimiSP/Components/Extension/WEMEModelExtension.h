//
//  WEMEModelExtension.h
//  weimi
//
//  Created by ray on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WEMESimpleUser.h>

@interface WEMESimpleUser (Extension)

+ (void)getWithUID:(NSString *)uid completeBlock:(void (^)(WEMESimpleUser * user))completeBlock;
+ (void)getSelfSimpleUserCompleteBlock:(void (^)(WEMESimpleUser * user))completeBlock;
+ (void)updateSelfSimpleUser;

@end



