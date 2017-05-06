//
//  AddressBookHelper.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/20.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookHelper : NSObject

+ (NSDictionary *)getAllContact;
+ (NSString *)getPhones;
+ (void)addPeopleWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber companyName:(NSString *)companyName department:(NSString *)department email:(NSString *)email headImg:(UIImage *)headImg;

@end
