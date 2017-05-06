//
//  YilidiBuyerTests.m
//  YilidiBuyerTests
//
//  Created by yld on 16/4/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNHttpRequestOPManager.h"
#import "DLRequestUrl.h"
//waitForExpectationsWithTimeout是等待时间，超过了就不再等待往下执行。
#define WAIT do {\
[self expectationForNotification:@"RSBaseTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:60 handler:nil];\
} while (0);

#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"RSBaseTest" object:nil];

@interface YilidiBuyerTests : XCTestCase

@end

@implementation YilidiBuyerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_GetGrabRedPacketGameInfo block:^(NSDictionary *resultDic, NSError *error) {
        NSLog(@"TEST ---- %@",resultDic);
        NOTIFY
    }];
    WAIT
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
