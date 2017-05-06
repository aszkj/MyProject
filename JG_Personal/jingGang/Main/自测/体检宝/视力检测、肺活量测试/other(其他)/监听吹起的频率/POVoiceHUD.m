//
//  POVoiceHUD.m
//  POVoiceHUD
//
//  Created by Polat Olu on 18/04/2013.
//  Copyright (c) 2013 Polat Olu. All rights reserved.
//


// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2013 Polat Olu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "POVoiceHUD.h"

@implementation POVoiceHUD
{
    BOOL b;
    BOOL _isMonitor;
    NSInteger resultValue;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
        b = NO;
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];

		self.alpha = 0.0f;
        [self initData];
        for(int i=0; i<SOUND_METER_COUNT; i++) {
            soundMeters[i] = 0;
        }
    }
    
    return self;
}
//+ (id)sharedDefaults
//{
//    static dispatch_once_t onceToken;
//    static POVoiceHUD *hud;
//    dispatch_once(&onceToken, ^{
//        hud = [[POVoiceHUD alloc] init];
//        hud.contentMode = UIViewContentModeRedraw;
//        bb = NO;
//        hud.opaque = NO;
//        hud.backgroundColor = [UIColor clearColor];
//        
//        hud.alpha = 0.0f;
//        
//        for(int i=0; i<SOUND_METER_COUNT; i++) {
//            soundMeters[i] = 0;
//        }
//    });
//    return hud;
//}

- (id)initWithParentView:(UIView *)view {
    return [self initWithFrame:view.bounds];
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self commitRecording];
//}

- (void) initData
{
    recordTime = 0;
    
    self.alpha = 1.0f;
    //    [self setNeedsDisplay];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    [audioSession setActive:YES error:&err];
    err = nil;
    if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    recordSetting = [[NSMutableDictionary alloc] init];
    
    // 您可以更改声音质量的设置
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    //	[recordSetting setValue:[NSNumber numberWithFloat:16000000.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    
    // 如果你使用的是kaudioformatlinearpcm格式，激活这些设置
    //[recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //	[recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    //[recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    
    
    recorderFilePath = [NSString stringWithFormat:@"%@/Documents/MySound.caf", NSHomeDirectory()];
    NSLog(@"Recording at: %@", recorderFilePath);
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    
    err = nil;
    
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    if(audioData)
    {
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:[url path] error:&err];
    }
    
    err = nil;
    recorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    
    if(!recorder){
        NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: [err localizedDescription]
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [recorder setDelegate:self];
    [recorder prepareToRecord];
    recorder.meteringEnabled = YES;
    
    BOOL audioHWAvailable = audioSession.inputIsAvailable;
    if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: @"Audio input hardware not available"
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [cantRecordAlert show];
        return;
    }
    
//    [recorder recordForDuration:(NSTimeInterval) 3000];
    
}

- (void)startMonitor{
    if (! _isMonitor)
    {
        [recorder recordForDuration:(NSTimeInterval) 3000];
        timer = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
        _isMonitor = YES;
    }
}


- (void)updateMeters {
    [recorder updateMeters];

    
    //判断麦克风是否已经被打开
    if ((int)[recorder averagePowerForChannel:0] == -120)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请到系统设置打开麦克风" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [self stop];
        _isMonitor = NO;
        return;
    }
    
    
    
    NSLog(@"meter+:%5f", [recorder averagePowerForChannel:0]);
    if (([recorder averagePowerForChannel:0] > -10.0) && ([recorder averagePowerForChannel:0] < 0) && !b )
    {
        recordTime = 0;
        resultValue = 0;
        b = YES;
        [self.delegate start];
    }
    if (b)
    {
        if (([recorder averagePowerForChannel:0] > -14.0) && ([recorder averagePowerForChannel:0] < 0))
        {
            [self.delegate start];
        }
//        if (([recorder averagePowerForChannel:0] > -14.0) && ([recorder averagePowerForChannel:0] < 0))
//        {
//            [self.delegate start];
//        }
        if (([recorder averagePowerForChannel:0] > -8.0) && ([recorder averagePowerForChannel:0] < 0))
        {
            [self.delegate start];
        }
        if (([recorder averagePowerForChannel:0] > -5.0) && ([recorder averagePowerForChannel:0] < 0))
        {
            [self.delegate start];
        }
        if (([recorder averagePowerForChannel:0] < -20.0) || ([recorder averagePowerForChannel:0] > 0.0) ) {
            [self commitRecording];
            return;
        }
        resultValue = resultValue + (20 - [recorder averagePowerForChannel:0]);
//        当开始吹得时候，把音频值回传回去
        [self.delegate POVoiceHUD:[recorder averagePowerForChannel:0]];
    }
    //等待超时
    if (([recorder averagePowerForChannel:0] < - 159.0))
    {
        recordTime = 0;
        [self commitRecording];
        return;
    }
    recordTime += WAVE_UPDATE_FREQUENCY;
    [self addSoundMeterItem:[recorder averagePowerForChannel:0]];
    
}
- (void)stop
{
    _isMonitor = NO;
    [recorder pause];
    [timer invalidate];
}
#pragma mark - 监听结束，通过代理协议实现回调
- (void)commitRecording {
    [recorder pause];
    [timer invalidate];
    _isMonitor = NO;
    b= NO;
    if ([self.delegate respondsToSelector:@selector(POVoiceHUD:voiceRecorded:length:)]) {
        [self.delegate POVoiceHUD:self voiceRecorded:recorderFilePath length:resultValue];
    }
    self.alpha = 0.0;
}


#pragma mark - Sound meter operations

- (void)shiftSoundMeterLeft {
    for(int i=0; i<SOUND_METER_COUNT - 1; i++) {
        soundMeters[i] = soundMeters[i+1];
    }
}

- (void)addSoundMeterItem:(int)lastValue {
    [self shiftSoundMeterLeft];
    [self shiftSoundMeterLeft];
    soundMeters[SOUND_METER_COUNT - 1] = lastValue;
    soundMeters[SOUND_METER_COUNT - 2] = lastValue;
}
@end
