//
//  RedPacketSoundPlayerTest.m
//  soundPlayTest
//
//  Created by mm on 16/11/16.
//  Copyright © 2016年 mm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RedPacketSoundPlayer.h"

@interface RedPacketSoundPlayerTest : XCTestCase

@property (nonatomic,strong) RedPacketSoundPlayer *redPacketSoundPlayer;

@end

@implementation RedPacketSoundPlayerTest

- (void)setUp {
    [super setUp];
    self.redPacketSoundPlayer = [[RedPacketSoundPlayer alloc] init];
  
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
  
}

- (void)testplayRedPacketGameWillBeginSound {
    [self.redPacketSoundPlayer playRedPacketGameWillBeginSound];
}

- (void)testplayRedPacketGamePlayingSound {
    [self.redPacketSoundPlayer playRedPacketGamePlayingSound];
}

- (void)testplayClickNotGrabedRedPacketSound {
    [self.redPacketSoundPlayer playClickNotGrabedRedPacketSound];
}

- (void)testplayClickGrabedRedPacketSound {
    [self.redPacketSoundPlayer playClickGrabedRedPacketSound];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
