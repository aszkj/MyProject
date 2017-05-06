//
//  RedPacketModel.h
//  工程红包雨测试
//
//  Created by mm on 16/10/22.
//  Copyright © 2016年 mm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedPacketAnimateRelatedModel : NSObject

@property (nonatomic,assign)double redPacketAnimateBeginTime;

@property (nonatomic,assign)double redPacketAnimateDuration;

@property (nonatomic,assign)double redPacketAnimateEndTime;

@property (nonatomic,assign)double redPacketAnimateAverageSpeed;

@property (nonatomic,assign)double redPacketAnimateTotalDistance;

@property (nonatomic,assign)double redPacketAnimatePositionX;

@property (nonatomic,assign)double redPacketAnimateEndPositionY;

//红包最初位于第几条道
@property (nonatomic,assign)NSInteger redPacketAnimatePostionNumber;


@property (nonatomic,copy)NSString *redPacketIdentifier;

@end
