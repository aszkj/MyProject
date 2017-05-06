//
//  PlayerHelper.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "PlayerHelper.h"
#import "amrFileCodec.h"

@implementation PlayerHelper

+ (instancetype)shared
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)playVoiceOfUrlString:(NSString *)urlString finishBlock:(FinishPlayBlock)finishBlk
{
    NSLog(@"urlString %@",urlString);
    self.finishBlk = finishBlk;
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        
        NSData *fileData = nil;
        if ([urlString hasPrefix:@"http"]) {
            fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            
        } else {
            fileData = [NSData dataWithContentsOfFile:urlString];
        }
        NSError *error = nil;
        // 初始化音频控制器
        
        if (!self.player) {
            
            self.player = [[AVAudioPlayer alloc] initWithData:fileData  error:&error];
            self.player.delegate = self;
            self.player.volume = 1.0f;
        }
        
        if(!error)
        {
            if([self.player prepareToPlay])
            {
                [self.player play];
            } else if ([urlString hasPrefix:@"http"]) {
                fileData = DecodeAMRToWAVE(fileData);
                self.player = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
                self.player.delegate = self;
                self.player.volume = 1.0f;
                [self.player play];
            }
            
        }
    });
}

- (void)playVoiceOfFileName:(NSString *)fileName finishBlock:(FinishPlayBlock)finishBlk
{
    self.finishBlk = finishBlk;
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        
        NSError *error = nil;
        // 初始化音频控制器
        
        if (!self.player) {
            
            self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"new_task_tone" ofType:@"mp3"]] error:&error];
            self.player.delegate = self;
            self.player.volume = 1.0f;
            self.player.numberOfLoops = 100;//一直循环
            
            if(!error && [self.player prepareToPlay])
            {
                [self.player play];
            }
        } else {
            
            if([self.player prepareToPlay])
            {
                [self.player play];
            }
        }
    });
}

#pragma mark - AVAudioPlayerDelegate

// 音频播放完成时
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_player stop];
    _player = nil;
    if (self.finishBlk) {
        self.finishBlk();
    }
}

// 解码错误
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"解码错误！");
    
    
}

// 当音频播放过程中被中断时
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    // 当音频播放过程中被中断时，执行该方法。比如：播放音频时，电话来了！
    // 这时候，音频播放将会被暂停。
}

// 当中断结束时
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    
    // AVAudioSessionInterruptionFlags_ShouldResume 表示被中断的音频可以恢复播放了。
    // 该标识在iOS 6.0 被废除。需要用flags参数，来表示视频的状态。
    
    NSLog(@"中断结束，恢复播放");
    if (flags == AVAudioSessionInterruptionOptionShouldResume && player != nil){
        [player play];
    }
    
}

-(void)start
{
    [_player play];
}
-(void)stop
{
    [_player stop];
    _player = nil;
    if (_finishBlk)
    {
        _finishBlk();
    }
}

@end
