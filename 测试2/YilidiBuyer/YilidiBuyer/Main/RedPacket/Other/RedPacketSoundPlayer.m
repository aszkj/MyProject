//
//  RedPacketSoundPlayer.m
//  soundPlayTest
//
//  Created by mm on 16/11/15.
//  Copyright © 2016年 mm. All rights reserved.
//

#import "RedPacketSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface RedPacketSoundPlayer()

@property (nonatomic,strong) AVAudioPlayer *redPacketGameWillBeginSoundPalyer;

@property (nonatomic,strong) AVAudioPlayer *redPacketGameWillBeginLastSoundPalyer;

@property (nonatomic,strong) AVAudioPlayer *redPacketGamePlayingSoundPalyer;

@property (nonatomic,strong) AVAudioPlayer *clickNotGrabedRedPacketSoundPalyer;

@end

@implementation RedPacketSoundPlayer


#pragma mark ---------------------Public Method------------------------------
- (void)playRedPacketGameWillBeginSound {

    [self.redPacketGameWillBeginSoundPalyer play];
}

- (void)playRedPacketGameWillBeginLastSound {

    [self.redPacketGameWillBeginLastSoundPalyer play];
}

- (void)playRedPacketGamePlayingSound {

    [self.redPacketGamePlayingSoundPalyer play];
}

- (void)playClickNotGrabedRedPacketSound {

    [self.clickNotGrabedRedPacketSoundPalyer play];
}

- (void)playClickGrabedRedPacketSound {

    [self.redPacketGameWillBeginSoundPalyer play];
}


- (void)prepareAllSoundPlaer {
    [self.redPacketGameWillBeginSoundPalyer prepareToPlay];
    [self.redPacketGameWillBeginLastSoundPalyer prepareToPlay];
    [self.redPacketGamePlayingSoundPalyer prepareToPlay];
    [self.clickNotGrabedRedPacketSoundPalyer prepareToPlay];
}

- (void)stopAllSoundPlaer {
    [self.redPacketGameWillBeginSoundPalyer stop];
    [self.redPacketGameWillBeginLastSoundPalyer stop];
    [self.redPacketGamePlayingSoundPalyer stop];
    [self.clickNotGrabedRedPacketSoundPalyer stop];
}

- (void)clearAllSoundPlayer {
    [self stopAllSoundPlaer];
    [self _clearAllSoundPlayer];
}

- (void)_clearAllSoundPlayer {
    self.redPacketGameWillBeginSoundPalyer = nil;
    self.redPacketGameWillBeginLastSoundPalyer = nil;
    self.redPacketGamePlayingSoundPalyer = nil;
    self.clickNotGrabedRedPacketSoundPalyer = nil;
}

#pragma mark ---------------------Private Method------------------------------
- (void)_initCommonSoundPlayer:(AVAudioPlayer *)soundPlayer {
    soundPlayer.volume =1;//0.0-1.0之间
    [soundPlayer prepareToPlay];
}

#pragma mark ---------------------Setter/Getter Method------------------------------
-(AVAudioPlayer *)redPacketGameWillBeginSoundPalyer {

    if (!_redPacketGameWillBeginSoundPalyer) {
        _redPacketGameWillBeginSoundPalyer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"redPacketGameWillBeginSound" ofType:@"mp3"]] error:nil];
        [self _initCommonSoundPlayer:_redPacketGameWillBeginSoundPalyer];
    }
    return _redPacketGameWillBeginSoundPalyer;
}

-(AVAudioPlayer *)redPacketGameWillBeginLastSoundPalyer {
    
    if (!_redPacketGameWillBeginLastSoundPalyer) {
        _redPacketGameWillBeginLastSoundPalyer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"redPacketGameWillBeginLastSound" ofType:@"mp3"]] error:nil];
        [self _initCommonSoundPlayer:_redPacketGameWillBeginLastSoundPalyer];
    }
    return _redPacketGameWillBeginLastSoundPalyer;
}


-(AVAudioPlayer *)redPacketGamePlayingSoundPalyer {
    
    if (!_redPacketGamePlayingSoundPalyer) {
        _redPacketGamePlayingSoundPalyer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"redPacketGameBackgroundSound" ofType:@"mp3"]] error:nil];
        const NSInteger MAX_PLAY_CONUNT = 1000;
        _redPacketGamePlayingSoundPalyer.numberOfLoops = MAX_PLAY_CONUNT;
        [self _initCommonSoundPlayer:_redPacketGamePlayingSoundPalyer];
    }
    return _redPacketGamePlayingSoundPalyer;
}

-(AVAudioPlayer *)clickNotGrabedRedPacketSoundPalyer {
    
    if (!_clickNotGrabedRedPacketSoundPalyer) {
        _clickNotGrabedRedPacketSoundPalyer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"clickRedPacketNotGrabedSound" ofType:@"mp3"]] error:nil];
        [self _initCommonSoundPlayer:_clickNotGrabedRedPacketSoundPalyer];
    }
    return _clickNotGrabedRedPacketSoundPalyer;
}

@end
