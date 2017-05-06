//
//  VoiceView.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VoiceViewType) {
    VoiceViewTypeMy = 0,
    VoiceViewTypeOthers
};

@interface VoiceView : UIView
{
    NSTimer *_timer;
}

@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) NSString *currentImgName;
@property (nonatomic, assign) VoiceViewType type;

@property (nonatomic, assign) BOOL isAnimating;

- (id)initWithFrame:(CGRect)frame type:(VoiceViewType)type;
- (void)startAnimate;
- (void)stopAnimate;

@end
