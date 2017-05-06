//
//  RecordView.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "RecordView.h"
#import "XKO_CreateUIViewHelper.h"

@interface RecordView ()

@property (nonatomic, weak) CAShapeLayer *blueMaskLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation RecordView {
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
        
    }
    return self;
}

- (void)initView
{
    
//    [self addSubview:self.waver];
//    
//    UIView *headView = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
//    headView.layer.cornerRadius = 31;
//    headView.layer.masksToBounds = YES;
//    [self addSubview:headView];
//    
//    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.centerX.equalTo(self.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(62, 62));
//    }];
//    
//    [headView addSubview:self.headImg];
//    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(headView.mas_centerX);
//        make.centerY.equalTo(headView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(56, 56));
//    }];
//
//    [self addSubview:self.time];
//    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView.mas_bottom).offset(20);
//        make.centerX.equalTo(self.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(100, 18));
//    }];

    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.contentLabel = nil;
    self.title = nil;
    self.microphoneView = nil;
   
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(22);
        make.left.equalTo(self).with.offset(6);
        make.right.equalTo(self).with.offset(-6);
    }];
    
    [self addSubview:self.title];
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).with.offset(-12.5);
    }];

    [self addSubview:self.microphoneView];
    self.microphoneView.hidden = NO;
    [self.microphoneView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.title.mas_top).with.offset(-28);
        make.size.mas_equalTo(CGSizeMake(42.5, 62));
    }];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
//    [self.waver removeFromSuperview];
    if (self.displayLink != nil) {
        [self.displayLink invalidate];
    }
    self.contentLabel.text = @"";
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
//    if (!self.waver.superview) {
//        [self addSubview:self.waver];
//        [self sendSubviewToBack:self.waver];
//    }
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeVoiceCallback)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.displayLink.frameInterval = 3;
    
}

- (void)invokeVoiceCallback
{
    if (_updateVolumeBlock == nil) {
        return;
    }
    // 科大讯飞返回 0-30
    int volum = self.updateVolumeBlock();
    double level = 0.3 + volum / 30.0 * 0.7;
    CGRect maskFrame = self.microphoneView.bounds;
    maskFrame.origin.y += maskFrame.size.height * (1 - level);
    maskFrame.size.height *= level;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:maskFrame];
    _blueMaskLayer.path = path.CGPath;
}

- (void)recordFaile
{
    if ([self viewWithTag:errorImageTag] != nil) {
        
        [self viewWithTag:errorImageTag].hidden = NO;
    } else {
        
        UIImageView *informImage = [[UIImageView alloc] initWithImage:IMAGE(@"voiceError_main")];
        informImage.tag = errorImageTag;
        [self addSubview:informImage];
        
        informImage.frame = CGRectMake(0, 0, 62, 62);
        [self.contentLabel setNeedsLayout];
        [self.contentLabel layoutIfNeeded];
        informImage.center = CGPointMake(self.center.x, CGRectGetMaxY(self.contentLabel.frame)+28+31);
//        [informImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.microphoneView);
//            make.size.mas_equalTo(CGSizeMake(62, 62));
//        }];
    }
    
    self.title.hidden = YES;
    self.microphoneView.hidden = YES;
    [self.transformImage removeFromSuperview];
}

- (void)showMicrophoneView
{
    self.microphoneView.hidden = NO;
    self.contentLabel.text = @"";
    self.title.hidden = NO;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImageView class]] && obj != _microphoneView) {
            obj.hidden = YES;
        }
    }];
}

- (void)showRelaseView
{
    UIView *errorView = [self viewWithTag:errorImageTag];
    if (!errorView.isHidden && errorView.superview) {
        return;
    }
    self.title.backgroundColor = UIColorFromRGB(0x555555);
    self.title.textColor = [UIColor whiteColor];
    self.title.layer.cornerRadius = 4.0;
    self.title.layer.masksToBounds = YES;
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    UIImageView *informImage = [[UIImageView alloc] initWithImage:IMAGE(@"voiceInform_main")];
    informImage.tag = releaseImageTag;
    [self addSubview:informImage];
    [informImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 48));
        make.top.equalTo(self.title.mas_bottom).with.offset(15);
    }];
    
    self.contentLabel.textColor = UIColorFromRGB(0xd2d2d2);
    self.microphoneView.hidden = YES;
    [self.transformImage removeFromSuperview];
}

- (void)showTransforming
{
    if ([self viewWithTag:errorImageTag] == nil) {
        [self addSubview:self.transformImage];
        [self.transformImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.microphoneView);
            make.size.mas_equalTo(CGSizeMake(62, 62));
        }];
        self.microphoneView.hidden = YES;
    }
}

- (void)updateAnimateViewWithVolume:(CGFloat)volume
{
    
}

#pragma mark - getter

- (UIImageView *)transformImage {
    if (_transformImage == nil) {
        UIImageView *transformImage = [[UIImageView alloc] initWithImage:IMAGE(@"voiceTransing_main")];
        transformImage.tag = transImageTag;
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 2.0;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;
        [transformImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        _transformImage = transformImage;
    }
    return _transformImage;
}

- (UIImageView *)microphoneView {
    if (_microphoneView == nil) {
        _microphoneView = [[UIImageView alloc] initWithImage:IMAGE(@"microphoneDark_Main")];
        CALayer *blueMaskLayer = [CALayer layer];
        UIImage *blueImage = IMAGE(@"microphoneGreen_Main");
        blueMaskLayer.contents = (__bridge id _Nullable)(blueImage.CGImage);
        blueMaskLayer.frame = CGRectMake(0, 0, 42.5, 62);
        [_microphoneView.layer addSublayer:blueMaskLayer];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        CGRect maskFrame = blueMaskLayer.frame;
        maskFrame.origin.y += maskFrame.size.height * 0.7;
        maskFrame.size.height *= 0.3;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:maskFrame];
        maskLayer.path = path.CGPath;
        blueMaskLayer.mask = maskLayer;
        _blueMaskLayer = maskLayer;
    }
    return _microphoneView;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = KNormalFont;
        _contentLabel.textColor = UIColorFromRGB(0x000000);
        _contentLabel.numberOfLines = 2;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_contentLabel setLineBreakMode:NSLineBreakByTruncatingHead];
    }
    return _contentLabel;
}

- (UIImageView *)headImg {

    if (!_headImg) {
        _headImg = [XKO_CreateUIViewHelper createUIImageViewWithImage:IMAGE(@"head_default")];
    }
    
    return _headImg;
}

- (UILabel *)time {
    
    if (!_time) {
        _time = [XKO_CreateUIViewHelper createLabelWithFont:[UIFont boldSystemFontOfSize:18] fontColor:[UIColor whiteColor] text:@"00:10"];
        _time.textAlignment = NSTextAlignmentCenter;
    }
    
    return _time;
}


- (UILabel *)title {
    
    if (!_title) {
        _title = [XKO_CreateUIViewHelper createLabelWithFont:kFontSize14 fontColor:[UIColor lightGrayColor] text:@"上滑手指，取消发送"];
        _title.textAlignment = NSTextAlignmentCenter;

    }
    
    return _title;
}

- (Waver *)waver {
    
    if (!_waver) {
        
        _waver = [[Waver alloc] initWithFrame:CGRectMake(0, 31, self.frame.size.width, self.frame.size.height + KBottomHeight)];
        _waver.waveColor = [UIColorFromRGB(0x1a1c1f) colorWithAlphaComponent:0.8];
        _waver.needMask = YES;

        WEAK_SELF
        _waver.waverLevelCallback = ^(Waver * waver) {
            
            int volume = weak_self.updateVolumeBlock();
            if(volume > 0) {
                
                waver.level = 0.02*volume;
                
            } else {
                waver.level = 0.01;
            }
        };
    }
    
    return _waver;
}

@end
