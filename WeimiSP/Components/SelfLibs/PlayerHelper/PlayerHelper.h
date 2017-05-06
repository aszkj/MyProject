//
//  PlayerHelper.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^FinishPlayBlock)(void);

@interface PlayerHelper : NSObject<AVAudioPlayerDelegate>
{
    AVAudioPlayer *_player;
}
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) FinishPlayBlock finishBlk;

+ (PlayerHelper *)shared;
- (void)playVoiceOfUrlString:(NSString *)urlString finishBlock:(FinishPlayBlock)finishBlk;
- (void)playVoiceOfFileName:(NSString *)fileName finishBlock:(FinishPlayBlock)finishBlk;
- (void)stop;
- (void)start;
@end
