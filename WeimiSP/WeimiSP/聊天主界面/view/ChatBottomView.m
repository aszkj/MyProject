//
//  ChatBottomView.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "ChatBottomView.h"
#import "XKO_CreateUIViewHelper.h"
#import <AVFoundation/AVFoundation.h>
#import "RecordView.h"
#import <iflyMSC/iflyMSC.h>
#import "JSONKit.h"
#import "AudioConverter.h"
#import "NSString+Teshuzifu.h"
#import "UploadFile.h"
#import "ZYQAssetPickerController.h"
#import "UIImage+SizeAndTintColor.h"
#import "WEMEFileuploadcontrollerApi.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "UIButton+Block.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Reachability.h"
#import "UIView+BlockGesture.h"
#import "UIImage+ImageEffects.h"

#define KLeftContentMargin          40
#define KContentWidth               55
#define kContentHeight              32

@interface ChatBottomView()<IFlySpeechRecognizerDelegate,UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate, UIImagePickerControllerDelegate>
{
    AVAudioRecorder *_recorder;
    NSInteger currentTime;
}

@property(nonatomic, assign) int volume;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) NSMutableString *lastSpeekString;
@property(nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property(nonatomic, strong) ZYQAssetPickerController *picker;

@end

@implementation ChatBottomView

- (void)dealloc {
    [kNotification removeObserver:self];
    [_timer invalidate];
    _timer = nil;
}

- (id)initWithFrame:(CGRect)frame sendMessageBlock:(SendMessageBlock)messageBlock recordFinishBlock:(RecordFinishBlock)recordFinishBlock sartIFlySpeechBlock:(StartIFlySpeechBlock)startIFlySpeechBlock addPictureBlock:(AddPictureBlock)addPictureBlock getChannelBlock:(GetChannelBlock)getChannelBlock {
    
    if (self = [super initWithFrame:frame]) {
        
        _volume = 0;
        self.sendMessageBlock = messageBlock;
        self.recordFinishBlock = recordFinishBlock;
        self.startIFlySpeechBlock = startIFlySpeechBlock;
        self.addPictureBlock = addPictureBlock;
        self.getChannelBlock = getChannelBlock;
        
        [self addSubview:self.textBackgroundView];
        [self addSubview:self.voiceBackgroundView];
        [self addSubview:self.contentBackgroundView];
        
        self.textBackgroundView.backgroundColor = kWhiteColor;
        self.contentBackgroundView.backgroundColor = kWhiteColor;
        self.voiceBackgroundView.backgroundColor = kWhiteColor;
        
        self.layer.borderColor = kGetColor(202, 202, 202).CGColor;
        self.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
        //开启本地录音
        [self initRecord];
    }
    
    return self;
}

#pragma mark - getter/setter



- (NSTimer *)timer {
    
    if (!_timer) {
        currentTime = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        
    }
    
    return _timer;
}

- (UIView *)voiceBackgroundView {
    
    if (!_voiceBackgroundView) {
        
        _voiceBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KBottomHeight)];
        
        [_voiceBackgroundView addSubview:self.changeTextBtn];
        [_voiceBackgroundView addSubview:self.recordBtn];
        [_voiceBackgroundView addSubview:self.settingBtn];
        
        UIButton *addButton = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"add") highlightedImage:IMAGE(@"add_highed") radiusSize:0 frame:CGRectZero];
        [addButton addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_voiceBackgroundView addSubview:addButton];
        
        //        UIButton *emotionBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"emotion") highlightedImage:IMAGE(@"emotion_highed") radiusSize:0 frame:CGRectZero];
        //        [emotionBtn addTarget:self action:@selector(smileBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        [_voiceBackgroundView addSubview:emotionBtn];
        
        [_changeTextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@KLeftMargin);
            make.centerY.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(kContentHeight , kContentHeight));
        }];
        
        [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.changeTextBtn.mas_right).with.offset(KLeftMargin);
            make.right.equalTo(addButton.mas_left).with.offset(-KLeftMargin);
            make.centerY.equalTo(_voiceBackgroundView);
            make.height.equalTo(@40);
        }];
        
        
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_voiceBackgroundView).with.offset(-KLeftMargin);
            make.centerY.equalTo(_voiceBackgroundView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kContentHeight, kContentHeight));
        }];
        
        //        [emotionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(addButton.mas_left).with.offset(-KLeftMargin);
        //            make.centerY.equalTo(_voiceBackgroundView.mas_centerY);
        //            make.size.mas_equalTo(addButton);
        //        }];
        
        
    }
    
    return _voiceBackgroundView;
}

- (void)_checkChatbottomPositionBlockCall {
    if (self.checkChatbottomPosionBlock) {
        self.checkChatbottomPosionBlock();
    }
}


- (UIView *)textBackgroundView {
    
    if (!_textBackgroundView) {
        
        _textBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KBottomHeight)];
        [_textBackgroundView addSubview:self.changeVoiceBtn];
        [_textBackgroundView addSubview:self.inputTextField];
        [_textBackgroundView addSubview:self.addBtn];
        //        [_textBackgroundView addSubview:self.expressionBtn];
        
        [self.changeVoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_textBackgroundView.mas_left).with.offset(KLeftMargin);
            make.centerY.equalTo(_textBackgroundView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kContentHeight, kContentHeight));
        }];
        
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(_textBackgroundView.mas_right).with.offset(-KLeftMargin);
            make.centerY.equalTo(_textBackgroundView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kContentHeight, kContentHeight));
        }];
        
        //        [self.expressionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(_addBtn.mas_left).with.offset(-KLeftMargin);
        //            make.centerY.equalTo(_textBackgroundView.mas_centerY);
        //            make.size.mas_equalTo(CGSizeMake(kContentHeight, kContentHeight));
        //        }];
        
        [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.changeVoiceBtn.mas_right).with.offset(KLeftMargin);
            make.right.equalTo(self.addBtn.mas_left).with.offset(-KLeftMargin);
            make.centerY.equalTo(_textBackgroundView.mas_centerY);
            make.height.equalTo(@(40));
        }];
        
        _textBackgroundView.hidden = YES;
    }
    
    return _textBackgroundView;
}

- (UIView *)contentBackgroundView {
    
    if (!_contentBackgroundView) {
        
        _contentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, KTextBottomHeight, kScreenWidth, KContentBottomHeight-KTextBottomHeight)];
        UIView *contentLine = [XKO_CreateUIViewHelper createUIViewWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5) backgroundColor:kGetColor(202, 202, 202)];
        [_contentBackgroundView addSubview:contentLine];
        
        [_contentBackgroundView addSubview:self.imageBtn];
        [_contentBackgroundView addSubview:self.shootBtn];
        //        [_contentBackgroundView addSubview:self.videoBtn];
        //        [_contentBackgroundView addSubview:self.emotionBtn];
        
        //        UIImageView *emotionAdd = [XKO_CreateUIViewHelper createUIImageViewWithFrame:CGRectMake(KContentWidth/2, 0, KContentWidth/2, KContentWidth/2) image:IMAGE(@"emotion_add")];
        //        [self.emotionBtn addSubview:emotionAdd];
        
        //        CGFloat marginWidth = (kScreenWidth - KMaxLeftMargin*2)/4;
        
        [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(_contentBackgroundView.mas_left).with.offset(KMaxLeftMargin + (marginWidth - KContentWidth)/2);
            make.centerX.equalTo(@( - kScreenWidth / 4));
            //            make.centerY.equalTo(_contentBackgroundView.mas_centerY);
            make.top.equalTo(@10);
            make.size.mas_equalTo(CGSizeMake(KContentWidth, KContentWidth));
        }];
        UILabel *photoLabel = [self creatLabelWithText:@"相册"];
        [_contentBackgroundView addSubview:photoLabel];
        [photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageBtn.mas_bottom).with.offset(5);
            make.centerX.equalTo(_imageBtn.mas_centerX);
        }];
        
        [self.shootBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(_imageBtn.mas_left).with.offset(marginWidth);
            make.centerX.equalTo(@(kScreenWidth/4));
            //            make.centerY.equalTo(_contentBackgroundView.mas_centerY);
            make.top.equalTo(@10);
            make.size.mas_equalTo(CGSizeMake(KContentWidth, KContentWidth));
        }];
        UILabel *shootLabel = [self creatLabelWithText:@"拍摄"];
        [_contentBackgroundView addSubview:shootLabel];
        [shootLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_shootBtn.mas_bottom).with.offset(5);
            make.centerX.equalTo(_shootBtn.mas_centerX);
        }];
        
        //        [self.videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(_shootBtn.mas_left).with.offset(marginWidth);
        //            make.centerY.equalTo(_contentBackgroundView.mas_centerY);
        //            make.size.mas_equalTo(CGSizeMake(KContentWidth, KContentWidth));
        //        }];
        //
        //        [self.emotionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(_videoBtn.mas_left).with.offset(marginWidth);
        //            make.centerY.equalTo(_contentBackgroundView.mas_centerY);
        //            make.size.mas_equalTo(CGSizeMake(KContentWidth, KContentWidth));
        //        }];
        
    }
    
    return _contentBackgroundView;
    
}
- (UILabel *)creatLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorFromRGB(0X000000);
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
    return label;
}

- (UIButton *)recordBtn {
    
    if (!_recordBtn) {
        
        UIButton *voiceButton = [XKO_CreateUIViewHelper createUIButtonBackNormalImage:IMAGE(@"whiteBack_Main") highlightedImage:IMAGE(@"darkBack_Main") radiusSize:5.0 frame:CGRectZero];
        _recordBtn = voiceButton;
        [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        [_recordBtn setTitle:@"松开结束" forState:UIControlStateHighlighted];
        [_recordBtn setTitleColor:UIColorFromRGB(0x4f525f) forState:UIControlStateNormal];
        _recordBtn.layer.borderColor = UIColorFromRGB(0xbfc1c8).CGColor;
        _recordBtn.layer.borderWidth = 1.0;
        [_recordBtn addTarget:self action:@selector(speakBtnDown:) forControlEvents:UIControlEventTouchDown];
        [_recordBtn addTarget:self action:@selector(speakBtnDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [_recordBtn addTarget:self action:@selector(speakBtnDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [_recordBtn addTarget:self action:@selector(speakBtnUpOut:) forControlEvents:UIControlEventTouchUpOutside];
        [_recordBtn addTarget:self action:@selector(speakBtnUp:) forControlEvents:UIControlEventTouchUpInside];
        [_recordBtn addTarget:self action:@selector(speakBtnUpOut:) forControlEvents:UIControlEventTouchCancel];
        
    }
    
    return _recordBtn;
}

- (UIButton *)settingBtn {
    
    if (!_settingBtn) {
        
        _settingBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"setup") highlightedImage:nil radiusSize:0 frame:CGRectZero];
        _settingBtn.hidden = YES;
        [_settingBtn addTarget:self action:@selector(settingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _settingBtn;
}

- (UIButton *)changeVoiceBtn {
    
    if (!_changeVoiceBtn) {
        
        _changeVoiceBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"voice") highlightedImage:IMAGE(@"voice_highed") radiusSize:0 frame:CGRectZero];
        [_changeVoiceBtn addTarget:self action:@selector(changeVoiceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _changeVoiceBtn;
}
-(UIButton *)changeTextBtn
{
    if (!_changeTextBtn) {
        _changeTextBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"keyboard") highlightedImage:IMAGE(@"keyboard_highed") radiusSize:0 frame:CGRectZero];
        [_changeTextBtn addTarget:self action:@selector(changeTextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeTextBtn;
}

//- (UIButton *)sendBtn {
//    
//    if (!_sendBtn) {
//        
//        _sendBtn = [XKO_CreateUIViewHelper createUIButtonWithTitle:@"发送" titleColor:[UIColor whiteColor] titleFont:kFontSize14 backgroundColor:kOrangeColor hasRadius:YES targetSelector:@selector(sendBtnClicked:) target:self];
//        
//        _sendBtn.hidden = YES;
//    }
//    
//    return _sendBtn;
//}

- (UIButton *)expressionBtn {
    
    if (!_expressionBtn) {
        
        _expressionBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"emotion") highlightedImage:IMAGE(@"emotion_highed") radiusSize:0 frame:CGRectZero];
        [_expressionBtn addTarget:self action:@selector(expressionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _expressionBtn;
}

- (UIButton *)addBtn {
    
    if (!_addBtn) {
        
        _addBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"add") highlightedImage:IMAGE(@"add_highed") radiusSize:0 frame:CGRectZero];
        [_addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addBtn;
}

- (UITextField *)inputTextField {
    
    if (!_inputTextField) {
        
        _inputTextField = [XKO_CreateUIViewHelper createUITextFieldWithFrame:CGRectZero placeholder:@"输入文字进行聊天" backgroundColor:kWhiteColor];
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.returnKeyType = UIReturnKeySend;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kEdgeInsetLeft, 1)];
        _inputTextField.leftView = paddingView;
        _inputTextField.layer.cornerRadius = 5;
        _inputTextField.layer.masksToBounds = YES;
        _inputTextField.delegate = self;
        _inputTextField.layer.borderWidth = 1;
        _inputTextField.layer.borderColor = UIColorFromRGB(0Xbfc1c8).CGColor;
    }
    return _inputTextField;
}

- (UIButton *)imageBtn {
    
    if (!_imageBtn) {
        _imageBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"chat_photo") highlightedImage:IMAGE(@"chat_photoHi") radiusSize:0 frame:CGRectZero];
        [_imageBtn addTarget:self action:@selector(imageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _imageBtn;
}

- (UIButton *)shootBtn {
    
    if (!_shootBtn) {
        _shootBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"chat_album") highlightedImage:IMAGE(@"chat_albumHi") radiusSize:0 frame:CGRectZero];
        [_shootBtn addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _shootBtn;
}

- (UIButton *)videoBtn {
    
    if (!_videoBtn) {
        
        _videoBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"vedio") highlightedImage:IMAGE(@"vedio_highed") radiusSize:0 frame:CGRectZero];
        [_videoBtn addTarget:self action:@selector(vedioBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _videoBtn;
}

- (UIButton *)emotionBtn {
    
    if (!_emotionBtn) {
        
        _emotionBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"smile") highlightedImage:IMAGE(@"smile_highed") radiusSize:0 frame:CGRectZero];
        [_emotionBtn addTarget:self action:@selector(smileBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _emotionBtn;
}

- (RecordView *)recordView {
    
    if (!_recordView) {
        _recordView = [[RecordView alloc] initWithFrame:CGRectMake(0, kScreenHeight - KTextBottomHeight - 160, kScreenWidth, 150)];
        
        WEAK_SELF
        _recordView.updateVolumeBlock = ^(void) {
            
            return weak_self.volume;
        };
    }
    
    return _recordView;
}

- (IFlySpeechRecognizer *)iFlySpeechRecognizer {
    
    if (!_iFlySpeechRecognizer) {
        //1.创建语音听写对象
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        _iFlySpeechRecognizer.delegate = self;
        
        //2.设置听写参数
        [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
        
        //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
        [_iFlySpeechRecognizer setParameter:@"luyin.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        //末端静音检测时间，用于检测到静音自动停止录音
        [_iFlySpeechRecognizer setParameter:@"5000" forKey:@"vad_eos"];
    }
    
    return _iFlySpeechRecognizer;
}

- (ZYQAssetPickerController *)picker {
    
    if (!_picker) {
        _picker = [[ZYQAssetPickerController alloc] init];
        _picker.maximumNumberOfSelection = 1;
        _picker.assetsFilter = [ALAssetsFilter allPhotos];
        _picker.showEmptyGroups=NO;
        _picker.delegate=self;
        _picker.navigationBar.barTintColor = chatStatus_Color;
        _picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                return duration >= 5;
            } else {
                return YES;
            }
        }];
    }
    
    return _picker;
}

#pragma mark - private methord

- (void)initRecord
{
    NSDictionary *recordSettings = @{AVFormatIDKey:[NSNumber numberWithInt:kAudioFormatLinearPCM],
                                     AVSampleRateKey:@11025.0,
                                     AVNumberOfChannelsKey:@2,
                                     AVLinearPCMBitDepthKey:@16,
                                     AVEncoderAudioQualityKey:[NSNumber numberWithInt:AVAudioQualityMin]};
    NSURL *recordedFile = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/luyin.caf"]];
    _recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:recordSettings error:nil];
    //开启音量检测
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
}

- (void)detectionVoice
{
    //刷新音量数据
    [_recorder updateMeters];
    double lowPassResults = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    [self.recordView updateAnimateViewWithVolume:lowPassResults];
}

- (void)updateTime {
    
    currentTime ++;
    
}

#pragma mark - event

- (void)changeFrameBlock:(CGFloat)duration {
    if (self.bottomViewHeightChangeBlock) {
        self.bottomViewHeightChangeBlock(self.frame,duration);
    }
}

- (void)changeTextBtnClicked:(UIButton *)sender {
    CGFloat duration = 0.2;
    [UIView animateWithDuration:duration animations:^{
        _textBackgroundView.hidden = NO;
        _voiceBackgroundView.hidden = YES;
        self.center = CGPointMake(self.center.x, self.center.y + (CGRectGetHeight(self.superview.frame) - KBottomHeight - CGRectGetMinY(self.frame)));
        [self changeFrameBlock:duration];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)changeVoiceBtnClicked:(UIButton *)sender {
    
    [_inputTextField resignFirstResponder];
    [self _checkChatbottomPositionBlockCall];
    
    CGFloat duration = 0.2;
    [UIView animateWithDuration:duration animations:^{
        
        _textBackgroundView.hidden = YES;
        _voiceBackgroundView.hidden = NO;
        self.center = CGPointMake(self.center.x, self.center.y + (CGRectGetHeight(self.superview.frame) - KBottomHeight - CGRectGetMinY(self.frame)));
        [self changeFrameBlock:duration];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)addBtnClicked:(UIButton *)sender {
    
    [_inputTextField resignFirstResponder];
    [self _checkChatbottomPositionBlockCall];
    if (self.frame.origin.y == CGRectGetHeight(self.superview.frame) - KContentBottomHeight) {
        
        [self changeTextBtnClicked:nil];
        
    } else {
        CGFloat duration = 0.2;
        [UIView animateWithDuration:duration animations:^{
            
            self.center = CGPointMake(self.center.x, self.center.y + (CGRectGetHeight(self.superview.frame) - KContentBottomHeight - CGRectGetMinY(self.frame)));
            [self changeFrameBlock:duration];
            _textBackgroundView.hidden = NO;
            _voiceBackgroundView.hidden = YES;
            
        } completion:^(BOOL finished) {
        }];
        
    }
}

- (void)settingBtnClicked:(UIButton *)sender {
    
    //    [self addPicture];
    
}

- (void)sendBtnClicked:(UIButton *)sender {
    
    if ( [_inputTextField.text isEqualToString:[self getSpaceWihtLength:_inputTextField.text.length]])
    {
        UIAlertView *alertView = [[UIAlertView alloc ]initWithTitle:@"不能发送空白消息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [_inputTextField resignFirstResponder];
        _inputTextField.text = @"";
        return;
    }
    
    if (_sendMessageBlock) {
        _sendMessageBlock(_inputTextField.text,AudioNormalType);
        _inputTextField.text = @"";
    }
}

- (void)expressionBtnClicked:(UIButton *)sender {
    
    
}

- (void)initAddBtnHeight {
    
    if (self.frame.origin.y == self.superview.frame.size.height - self.frame.size.height) {
        
        [self addBtnClicked:nil];
    }
}

- (void)imageBtnClicked:(UIButton *)sender {
    
    [self addPicture];
    
}
#pragma mark - 拍摄
- (void)photoBtnClicked:(UIButton *)sender {
#if TARGET_IPHONE_SIMULATOR//模拟器
    
#else
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self.VC presentViewController:picker animated:YES completion:nil];
    
#endif
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.VC dismissViewControllerAnimated:YES completion:nil];
    
    NSString* mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString*)kUTTypeImage])//@"public.image"
    {
        UIImage* image=[info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation=image.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            UIImage *selectImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *newImg = [selectImage imageCompress];
                //                NSData *data = UIImageJPEGRepresentation(selectImage, 0.01);
                //                UIImage *newImg = [UIImage imageWithData:data];
                NSString *fileName = [[FileMangeHelper shareInstance] saveUploadImageWithImage:newImg];
                CGSize imgRect = [Util resetImageSizeFromSourceSize:newImg.size maxWidth:KImageWidth maxHeight:KImageHeight];
                
                if (_startIFlySpeechBlock) {
                    _startIFlySpeechBlock(@"图片",0,UploadFileImageType,nil,[fileName lastPathComponent],imgRect);
                }
            });
        }
    }
}

- (void)vedioBtnClicked:(UIButton *)sender {
    
    
}

- (void)smileBtnClicked:(UIButton *)sender {
    
    
}

- (void)startAnimator {
    
    [self recordView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.superview addSubview:self.recordView];
        self.recordView.frame = CGRectMake(0, CGRectGetMinY(self.frame) - 190, kScreenWidth, 190);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.iFlySpeechRecognizer.isListening) {
                [self.recordView showMicrophoneView];
            }
        });
        [self.timer fire];
    });
    
}

- (void)endAnimator {
    
    if (self.recordView && self.recordView.superview) {
        currentTime = 0;
        [self.recordView removeFromSuperview];
        self.recordView = nil;
        
        [self.timer invalidate];
        self.timer = nil;
    };
    
}


- (void)speakBtnDown:(UIButton *)button
{
    //科大讯飞录音
    [self.iFlySpeechRecognizer startListening];
    [self startAnimator];
    //    //本地录音
    //    AVAudioSession *session = [AVAudioSession sharedInstance];
    //    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    //    [session setActive:YES error:nil];
    //
    //    [_recorder record];
    //    _timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    
}

- (void)speakBtnDragEnter:(UIButton *)button
{
    [self.recordView initView];
}

- (void)speakBtnDragExit:(UIButton *)button
{
    if ([kAppDelegate.reach isReachable]) {
        [self.recordView showRelaseView];
    }
}

- (void)speakBtnUpOut:(UIButton *)button
{
    if (!button.isTouchInside) {
        [self.iFlySpeechRecognizer stopListening];
        [self endAnimator];
        self.lastSpeekString = nil;
    };
}

- (void)speakBtnUp:(UIButton *)button
{
    if (self.iFlySpeechRecognizer.isListening) {
        //开始语音转化进度
        [self.recordView showTransforming];
        //科大讯飞停止录音
        [self.iFlySpeechRecognizer stopListening];
    }
    
    if (_recordFinishBlock) {
        _recordFinishBlock(currentTime);
    }
}

- (void)resetBackImg {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.recordBtn setBackgroundImage:IMAGE(@"whiteBack_Main") forState:UIControlStateNormal];
        
    });
}

- (void)convertToMp3WithSpeekString:(NSString *)speekString {
    if (IsEmpty(speekString)) {
        return;
    }
    NSString *file = kPathOfPCM;
    NSData *data = [AudioConverter convertToMp3OfPath:file];
    
    if (data) {
        
        NSString *fileName = [NSString getUniqueStrByUUID] ;
        NSString *filePath = [[FileMangeHelper shareInstance] getUploadPathFromFileType:UploadFileAudioType];
        
        [[FileMangeHelper shareInstance] copyFileWithFromPath:kPathOfMP3 toPath:filePath fileName:fileName];
        
        NSString *channel = @"";
        if (_getChannelBlock) {
            channel = _getChannelBlock();
        }
        NSError *error = nil;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:kPathOfMP3] error:&error];
        if (IsEmpty(error)) { currentTime = player.duration; }
        //转化成毫秒单位,与安卓保持一致
        currentTime == 0 ? currentTime++ : currentTime;
        NSInteger duration = currentTime*1000;
        if (_startIFlySpeechBlock) {
            _startIFlySpeechBlock(speekString,duration,UploadFileAudioType,nil,[NSString stringWithFormat:@"%@.mp3",fileName],CGSizeZero);
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self sendBtnClicked:nil];
    
    return YES;
}
//- (void)textFieldDidChangeNotification
//{
//    if (IsEmpty(_inputTextField.text))
//    {
//        self.sendBtn.hidden = YES;
//        self.addBtn.hidden = NO;
//    }
//    else
//    {
//        self.sendBtn.hidden = NO;
//        self.addBtn.hidden = YES;
//    }
//}
-(NSString *)getSpaceWihtLength:(NSUInteger)length
{
    NSMutableString *str = [NSMutableString string];
    for (NSInteger i = 0; i < length;  i++) {
        [str appendString:@" "];
    }
    return str;
}



#pragma mark - IFlySpeechRecognizerDelegate

/*识别结果返回代理
 @param :results识别结果
 @ param :isLast 表示是否最后一次结果
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast {
    
    NSLog(@"ifReadOnly value: %@" ,isLast?@"YES":@"NO");
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *firstDic = results [0];
    for (NSString *key in firstDic) {
        
        NSDictionary *secondDic = [key objectFromJSONString];
        NSArray *firstList = secondDic[@"ws"];
        for (NSDictionary *thirdDic in firstList) {
            
            NSArray *secondList = thirdDic[@"cw"];
            for (NSDictionary *fourthDic in secondList) {
                if (fourthDic[@"w"]) {
                    [resultString appendFormat:@"%@",fourthDic[@"w"]];
                }
            }
        }
    }
    
    if (!IsEmpty(resultString)) {
        [self.lastSpeekString appendString:resultString];
    }
    
    self.recordView.contentLabel.text = self.lastSpeekString;
}

/**
 *  识别会话结束返回代理
 *
 *  @param error 错误码,error.errorCode=0表示正常结束,非0表示发生错误。
 */
- (void)onError: (IFlySpeechError *)error{
    
    if (error.errorCode == 0 && !IsEmpty(self.lastSpeekString)) {
        
        NSLog(@"录音成功!");
        double duration = 0.6;
        if (IsEmpty(self.recordView.contentLabel.text)) {
            duration = 0.0;
        }
        self.recordView.transformImage.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endAnimator];
        });
    } else {
        if (![kAppDelegate.reach isReachable]) {
            self.recordView.contentLabel.text = @"网络不可用\n请检查网络设置";
        } else if (IsEmpty(self.lastSpeekString)) {
            self.recordView.contentLabel.text = @"说话时间太短了\n请勿在说话过程中离开此界面";
        }
        
        if ([self.recordView.microphoneView isHidden]) {
            
            [self.recordBtn setBackgroundImage:IMAGE(@"darkBack_Main") forState:UIControlStateNormal];
            
            [self performSelector:@selector(resetBackImg) withObject:nil afterDelay:0.3];
        }
        
        [self.recordView recordFaile];
        
        @weakify(self);
        [self.recordView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            @strongify(self);
            [self endAnimator];
            [self.recordView removeGestureRecognizer:gestureRecoginzer];
        }];
    }
    
    if (!IsEmpty(self.lastSpeekString)) {
        [self convertToMp3WithSpeekString:self.lastSpeekString];
        self.lastSpeekString = [[NSMutableString alloc] init];
    }
    _volume = 0;
    currentTime = 0;
}

/**
 *  开始录音回调
 */
- (void) onBeginOfSpeech {
    self.lastSpeekString = [[NSMutableString alloc] init];
    
}

/**
 *  停止录音回调
 */
- (void)onEndOfSpeech {
    
}

/**
 *  音量回调函数
 *
 *  @param volume volume 0-30
 */
- (void)onVolumeChanged:(int)volume {
    
    if (_volume != volume) {
        _volume = volume;
    }
}

#pragma mark - 从相册获取图片
#pragma mark - ZYQAssetPickerControllerDelegate

- (void)addPicture
{
    _picker = nil;
    [kCurrentKeyWindow addSubview:self.picker.view];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (IsEmpty(assets)) {
        
        [picker.view removeFromSuperview];
        return;
    }
    ALAsset *asset=assets[0];
    UIImage *selectedImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    [picker.view removeFromSuperview];
    
    selectedImg = [selectedImg imageCompress];
    
    NSData *data = UIImageJPEGRepresentation(selectedImg, 1);
    UIImage *newImg = [UIImage imageWithData:data];
    NSString *fileName = [[FileMangeHelper shareInstance] saveUploadImageWithImage:newImg];
    CGSize imgRect = [Util resetImageSizeFromSourceSize:newImg.size maxWidth:KImageWidth maxHeight:KImageHeight];
    
    if (_startIFlySpeechBlock) {
        _startIFlySpeechBlock(@"图片",0,UploadFileImageType,nil,[fileName lastPathComponent],imgRect);
    }
}

-(void)assetPickerControllerDidCancel:(ZYQAssetPickerController *)picker {
    
    [picker.view removeFromSuperview];
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
    UIView *superView = self.superview;
    [self removeFromSuperview];
    
    ChatBottomView *chatView = [[ChatBottomView alloc] initWithFrame:self.frame sendMessageBlock:nil recordFinishBlock:nil sartIFlySpeechBlock:nil addPictureBlock:nil getChannelBlock:nil];
    [superView addSubview:chatView];
}

@end
