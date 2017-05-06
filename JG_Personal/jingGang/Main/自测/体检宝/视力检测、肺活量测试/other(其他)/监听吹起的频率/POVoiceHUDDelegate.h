//
//  POVoiceHUDDelegate.h
//  POVoiceHUD
//
//  Created by Polat Olu on 26/04/2013.
//  Copyright (c) 2013 Polat Olu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class POVoiceHUD;

@protocol POVoiceHUDDelegate <NSObject>

@optional

- (void)POVoiceHUD:(POVoiceHUD *)voiceHUD voiceRecorded:(NSString *)recordPath length:(float)recordLength;//吹起结束，或者超时回调
- (void) start;//吹起时回调

- (void)POVoiceHUD:(CGFloat)value; //当开始吹得时候，把音频值回传回去

@end

