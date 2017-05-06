//
//  UManager.h
//  YilidiBuyer
//
//  Created by mm on 17/1/18.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UManager : NSObject

+(instancetype)shareManager;

+ (void)testUM;

+ (void)configureUM;

+ (void)enterPage:(NSString *)page;

+ (void)leavePage:(NSString *)page;

@end
