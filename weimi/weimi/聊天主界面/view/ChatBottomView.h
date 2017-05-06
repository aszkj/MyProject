//
//  ChatBottomView.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileMangeHelper.h"

@class RecordView;

typedef void (^SendMessageBlock)(NSString *,UploadFileType);
typedef void (^StartIFlySpeechBlock)(NSString*,NSInteger,UploadFileType,NSString *,NSString *,CGSize);
typedef void (^RecordFinishBlock)(NSTimeInterval);
typedef void (^AddPictureBlock)(UIImage *);
typedef NSString* (^GetChannelBlock)(void);
typedef void(^CheckChatbottomPosionBlock)(void);
typedef void (^BottomViewHeightChangeBlock)(CGRect endFrame, CGFloat duration);

@interface ChatBottomView : UIView <UITextFieldDelegate>

@property(nonatomic, strong) UIView *textBackgroundView;
@property(nonatomic, strong) UIView *voiceBackgroundView;
@property(nonatomic, strong) UIView *contentBackgroundView;
@property(nonatomic, strong) UIButton *changeTextBtn;
@property(nonatomic, strong) UIButton *recordBtn;
@property(nonatomic, strong) UIButton *settingBtn;
@property(nonatomic, strong) UIButton *changeVoiceBtn;
@property(nonatomic, strong) UITextField *inputTextField;
@property(nonatomic, strong) UIButton *expressionBtn;
@property(nonatomic, strong) UIButton *addBtn;
//@property(nonatomic, strong) UIButton *sendBtn;
@property(nonatomic, strong) UIButton *imageBtn;
@property(nonatomic, strong) UIButton *videoBtn;
@property(nonatomic, strong) UIButton *shootBtn;
@property(nonatomic, strong) UIButton *emotionBtn;
@property(nonatomic, strong) NSString *channel;

@property(nonatomic, strong) RecordView *recordView;
@property (nonatomic,copy) SendMessageBlock sendMessageBlock;
@property (nonatomic,copy) RecordFinishBlock recordFinishBlock;
@property (nonatomic,copy) StartIFlySpeechBlock  startIFlySpeechBlock;
@property (nonatomic,copy) AddPictureBlock addPictureBlock;
@property (nonatomic,copy) GetChannelBlock getChannelBlock;
@property (nonatomic,copy) CheckChatbottomPosionBlock checkChatbottomPosionBlock;

@property (nonatomic,strong) UIViewController *VC;

//视图高度变化回调
@property (nonatomic,copy) BottomViewHeightChangeBlock bottomViewHeightChangeBlock;

- (id)initWithFrame:(CGRect)frame sendMessageBlock:(SendMessageBlock)messageBlock recordFinishBlock:(RecordFinishBlock)recordFinishBlock sartIFlySpeechBlock:(StartIFlySpeechBlock)startIFlySpeechBlock addPictureBlock:(AddPictureBlock)addPictureBlock getChannelBlock:(GetChannelBlock)getChannelBlock;

- (void)initAddBtnHeight;
- (void)changeTextBtnClicked:(UIButton *)sender;

@end
