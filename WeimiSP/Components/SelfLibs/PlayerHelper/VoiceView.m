//
//  VoiceView.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "VoiceView.h"

@implementation VoiceView

- (id)initWithFrame:(CGRect)frame type:(VoiceViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = type;
        _isAnimating = YES;
        if (type == VoiceViewTypeMy) {
            self.currentImgName = @"msg_my_voice_03";
        }
        else {
            self.currentImgName = @"msg_other_voice_03";
        }
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        iv.image = [UIImage imageNamed:_currentImgName];
        [self addSubview:iv];
        self.iv = iv;
    }
    return self;
}

- (void)startAnimate
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(animate) userInfo:nil repeats:YES];
}

- (void)animate
{
    _isAnimating = YES;
    
    if (_type == VoiceViewTypeMy) {
        if ([_currentImgName isEqualToString:@"msg_my_voice_03"]) {
            self.currentImgName = @"msg_my_voice_01";
        }
        else if ([_currentImgName isEqualToString:@"msg_my_voice_01"]) {
            self.currentImgName = @"msg_my_voice_02";
        }
        else {
            self.currentImgName = @"msg_my_voice_03";
        }
    }
    else {
        if ([_currentImgName isEqualToString:@"msg_other_voice_03"]) {
            self.currentImgName = @"msg_other_voice_01";
        }
        else if ([_currentImgName isEqualToString:@"msg_other_voice_01"]) {
            self.currentImgName = @"msg_other_voice_02";
        }
        else {
            self.currentImgName = @"msg_other_voice_03";
        }
    }
    
    self.iv.image = [UIImage imageNamed:_currentImgName];
}

- (void)stopAnimate
{
    _isAnimating = NO;
    
    [_timer invalidate];
    if (_type == VoiceViewTypeMy) {
        self.currentImgName = @"msg_my_voice_03";
    }
    else {
        self.currentImgName = @"msg_other_voice_03";
    }
    self.iv.image = [UIImage imageNamed:_currentImgName];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
