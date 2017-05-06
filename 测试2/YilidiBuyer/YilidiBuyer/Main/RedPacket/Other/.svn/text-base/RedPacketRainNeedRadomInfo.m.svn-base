//
//  RedPacketRainNeedRadomInfo.m
//  工程红包雨测试
//
//  Created by mm on 16/10/20.
//  Copyright © 2016年 mm. All rights reserved.
//

#import "RedPacketRainNeedRadomInfo.h"
#import <UIKit/UIKit.h>

#define PerTimeRadomPacketMaxCount 5

@interface RedPacketRainNeedRadomInfo()

@property (nonatomic,strong)NSMutableArray *redPacketRadomPositionNumbers;

@property (nonatomic,assign)NSInteger pertimeRadomProducedRedPacketNumber;

@property (nonatomic,assign)NSInteger screenDivedRedPacketRoadCount;


@end

@implementation RedPacketRainNeedRadomInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pertimeRadomProducedRedPacketNumber = -1000;
        self.screenDivedRedPacketRoadCount = [[UIScreen mainScreen] bounds].size.width / IMAGE_WIDTH;
    }
    return self;
}

#pragma mark ---------------------Public Method------------------------------
- (NSInteger)getPertimeRadomProducedRedPacketNumber{
    
    self.pertimeRadomProducedRedPacketNumber = arc4random() % PerTimeRadomPacketMaxCount;
    return self.pertimeRadomProducedRedPacketNumber;
    
}

- (NSArray *)getPertimeRadomProducedRedPacketPositionNumbers {
    NSAssert(self.pertimeRadomProducedRedPacketNumber != -1000, @"红包个数还未生成");
    [self.redPacketRadomPositionNumbers removeAllObjects];
    return [self produceRadomPositionNumberForRedPacketN:0];
}

- (NSInteger)getScreenDivedRedPacketRoadCount {

    return self.screenDivedRedPacketRoadCount ? self.screenDivedRedPacketRoadCount : 10;

}


#pragma mark ---------------------ProduceRadomPositionNumber Method------------------------------
- (NSArray *)produceRadomPositionNumberForRedPacketN:(NSInteger)redPacketN {
    if (redPacketN == self.pertimeRadomProducedRedPacketNumber) {
        return [self.redPacketRadomPositionNumbers copy];
    }else {
        NSInteger perRedPacketRadomPositionNumber = arc4random() % self.screenDivedRedPacketRoadCount;
        if ([self _hasTheSamePositionNumberInProducedPositionNumbersOfPositionNumber:perRedPacketRadomPositionNumber] || [self intheWrongRoadAreaOfProducedPositionNumber:perRedPacketRadomPositionNumber]) {
            return [self produceRadomPositionNumberForRedPacketN:redPacketN];
        }else {
            [self.redPacketRadomPositionNumbers addObject:@(perRedPacketRadomPositionNumber)];
            return [self produceRadomPositionNumberForRedPacketN:redPacketN + 1];
        }
    }
}

- (BOOL)intheWrongRoadAreaOfProducedPositionNumber:(NSInteger)producedPostionNumber {
    return (producedPostionNumber == 0 || (producedPostionNumber<=self.screenDivedRedPacketRoadCount-1 && producedPostionNumber>=self.screenDivedRedPacketRoadCount-2));
}

- (BOOL)_hasTheSamePositionNumberInProducedPositionNumbersOfPositionNumber:(NSInteger)thisTimeProducedRedPacketPositionNumber{
    for (NSNumber *producedPositionNumber in self.redPacketRadomPositionNumbers) {
        if (producedPositionNumber.integerValue == thisTimeProducedRedPacketPositionNumber) {
            return YES;
            break;
        }
    }
    return NO;
}

#pragma mark ---------------------Setter/Getter Method------------------------------

- (NSMutableArray *)redPacketRadomPositionNumbers {

    if (!_redPacketRadomPositionNumbers) {
        _redPacketRadomPositionNumbers = [NSMutableArray arrayWithCapacity:PerTimeRadomPacketMaxCount];
    }
    return _redPacketRadomPositionNumbers;
}

- (void)printRedPacketRadomPositionNumber {
    for (NSNumber *radomPacketPostionNumber in self.redPacketRadomPositionNumbers) {
        NSLog(@"%@",radomPacketPostionNumber);
    }
}





@end
