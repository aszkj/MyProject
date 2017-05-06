//
//  ChatViewCell.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/11/4.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "ChatViewCell.h"
#import "XKO_CreateUIViewHelper.h"
#import "UIColor+UIImage.h"
#import "NSDate+Utilities.h"
#import "FileMangeHelper.h"
//#import "SDWebImageManager+MJ.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PlayerHelper.h"
#import "UIImage+ImageEffects.h"
#import "NSDate+Addition.h"
#import "DatabaseCache.h"
#import "SessonContentModel.h"
#import "UIColor+UIImage.h"
#import <WEMEFeedcontrollerApi.h>
#import <WEMESimpleMyFeed.h>
#import "WEMEModelExtension.h"
#import "UIView+YYText.h"
#import "UIView+BlockGesture.h"
#import "ChatViewController.h"
#import "AppDelegate.h"
#import "PersonalCenterViewController.h"

#define kHeaderImageHeight 66
#define KDelayTime         30 //发送超时时间（秒）

@interface ChatViewCell()<UIAlertViewDelegate,RTLabelDelegate>

//组件文字显示
@property (nonatomic, strong) UIButton *pluginText;
@property (nonatomic, strong) UILabel *pluginDesc;
@property (nonatomic, strong) NSTextAttachment *attch;
@property (nonatomic) UIImageView *voiceAnimatedImage;
@property (nonatomic) UILabel *voiceTimeLabel;
/**
 *  聊天信息背景图
 */
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation ChatViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.backgroundImageView];
        [self.contentView addSubview:self.textContent];
//        [self.contentView addSubview:self.headerBtn];
        [self.contentView addSubview:self.headerImg];
        [self.contentView addSubview:self.imageContent];
        
        [self.backgroundImageView addSubview:self.voiceAnimatedImage];
        [self.backgroundImageView addSubview:self.voiceTimeLabel];
        
        [self.contentView addSubview:self.errorButton];
        [self.contentView addSubview:self.activityView];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@-5);
            make.height.equalTo(@18);
//            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
//            make.size.mas_equalTo(CGSizeMake(140, 20));
        }];
    }
    
    return self;
}

- (void)setDataModelType:(ProtoMessageContentType)dataModelType
{
    _dataModelType = dataModelType;
    _backgroundImageView.hidden = YES;
    _textContent.hidden = YES;
    _imageContent.hidden = YES;
    _voiceAnimatedImage.hidden = YES;
    _voiceTimeLabel.hidden = YES;
    
    if (dataModelType == ProtoMessageContentTypeText) {
        
        _backgroundImageView.userInteractionEnabled = NO;
        _backgroundImageView.hidden = NO;
        _textContent.hidden = NO;
//        _textContent.hidden = NO;
//        [self.contentView addSubview:self.textContent];
        
    } else if (dataModelType == ProtoMessageContentTypeImage) {

        _imageContent.hidden = NO;
//        _textContent.hidden = YES;
//        _backgroundImageView.hidden = YES;
//        [self.contentView addSubview:self.imageContent];
        
    }  else if (dataModelType == ProtoMessageContentTypeVoice) {
        
        _backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView.hidden = NO;
        _voiceAnimatedImage.hidden = NO;
        _voiceTimeLabel.hidden = NO;
//        _textContent.hidden = YES;
//        [self.contentView addSubview:self.voiceAnimatedImage];
        
    } else if (dataModelType == ProtoMessageContentTypeCompoment) {
        
        [self.contentView addSubview:self.webContent];
        [self.contentView addSubview:self.pluginText];
        
    }
}

#pragma mark - 点击头像
- (void)tapAvatarAction
{
    if (![self.yy_viewController isKindOfClass:[ChatViewController class]]) return;
    ChatViewController *vc = (ChatViewController *)self.yy_viewController;
    if (self.messageModel.isMyself) {
        PersonalCenterViewController *pCenterVC = [[PersonalCenterViewController alloc ]init];
        [vc.navigationController pushViewController:pCenterVC animated:YES];
    } else {
        [vc pushToPersoncenter];
    }
}

#pragma mark - 信息发错   点击事件
-(void)errorAction:(UIButton *)errorBtn
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"重发该消息？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重发", nil];
    [alertView show];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVoiceImages {

    if (!_messageModel.isMyself) {
        _voiceAnimatedImage.animationImages = @[IMAGE(@"msg_other_voice_01"),IMAGE(@"msg_other_voice_02"),IMAGE(@"msg_other_voice_03")];
        _voiceAnimatedImage.image = IMAGE(@"msg_other_voice_03");
    }
    else
    {
        NSArray *imagesArray = @[IMAGE(@"msg_my_voice_01"),IMAGE(@"msg_my_voice_02"),IMAGE(@"msg_my_voice_03")];
        _voiceAnimatedImage.animationImages = imagesArray;
        _voiceAnimatedImage.image = IMAGE(@"msg_my_voice_03");
    }
}

// 更新组件状态并刷新
- (void)componentReloadDataWithMessage:(SessonContentModel *)message desc:(NSString *)desc {
    
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
}

-(void)setMessageModel:(SessonContentModel *)messageModel
{
    _messageModel = messageModel;
    //判断信息是否发送成功
    if (messageModel.isMyself)
    {
        if (!IsEmpty(messageModel.key_id))
        {
            [self ActivityAnimatinWithBOOL:NO];
            self.errorButton.hidden = YES;
        }
        else
        {
            if (messageModel.isSendError) //发送失败
            {
                _errorButton.hidden = NO;
                [self ActivityAnimatinWithBOOL:NO];
            }
            else
            {
                _errorButton.hidden = YES;
                [self ActivityAnimatinWithBOOL:YES];
                [self performSelector:@selector(reloadDataAfterTime:) withObject:messageModel afterDelay:KDelayTime];
            }
        }
    }
    
    
    if (_messageModel.isHiddenTime)
    {
        _timeLabel.hidden = NO;
        [self setTimeWith:_messageModel.contentTimestamp / 1000];
    }
    else
    {
        _timeLabel.hidden = YES;
    }
    
    
    _cellFrame = [[ChatViewCellFrame alloc] initWithDateModel:messageModel];
    _cellFrame.dataModelType = _dataModelType;
    
    self.errorButton.center = _cellFrame.errorPoint;
    self.activityView.center = _cellFrame.activityPoint;
    
    [self.headerImg setFrame:_cellFrame.headImageRect];
    _headerImg.layer.cornerRadius = CGRectGetHeight(_headerImg.frame)/2;
    _headerImg.image = IMAGE(@"default_head");
    if (messageModel.isMyself) {
        
        
        [_headerImg sd_setImageWithURL:[NSURL URLWithString:kAppDelegate.userInfo.headImgPath] placeholderImage:_headerImg.image];

    } else {
        [WEMESimpleUser getWithUID:messageModel.uid completeBlock:^(WEMESimpleUser *user) {
            [_headerImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:_headerImg.image];
        }];
    }
   
    
    switch (_dataModelType) {
        case ProtoMessageContentTypeText: //文字
        {
            [self setChantViewBackgroundImageWithRight:messageModel.isMyself withFrame:_cellFrame.backImageRect];
            self.textContent.frame = _cellFrame.textRect;
            self.textContent.text = messageModel.contentText;
            
            
            if (messageModel.isMyself)
            {
                self.textContent.textColor = [UIColor whiteColor];
            }
            else
            {
                [self ActivityAnimatinWithBOOL:NO];
                self.textContent.textColor = [UIColor blackColor];
            }
        }
            break;
        case ProtoMessageContentTypeVoice: //语音
        {
            self.voiceAnimatedImage.frame = _cellFrame.voiceImageRect;
            self.backgroundImageView.frame = _cellFrame.backImageRect;
            self.voiceTimeLabel.frame = _cellFrame.voiceTimeRect;
            self.voiceTimeLabel.text = [NSString stringWithFormat:@"%d\"",(int)_messageModel.contentDuration/1000];//毫秒转秒
            
            if (messageModel.isMyself)
            {
                self.backgroundImageView.image = [UIImage imageNamed:@"chat_green"];
                self.voiceTimeLabel.textColor = kWhiteColor;
                self.voiceTimeLabel.textAlignment = NSTextAlignmentLeft;
            }
            else
            {
                self.backgroundImageView.image = [UIImage imageNamed:@"chat_white"];
                self.voiceTimeLabel.textColor = UIColorFromRGB(0Xc2c2c7);
                self.voiceTimeLabel.textAlignment = NSTextAlignmentRight;
            }
            UIImage *img = _backgroundImageView.image;
            _backgroundImageView.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
            [self setVoiceImages];
        }
            break;
        case ProtoMessageContentTypeImage://图片
        {
            self.imageContent.frame = _cellFrame.imageRect;
            if (IsEmpty(messageModel.localFileName))
            {
                NSURL *urlImage = TwiceImgUrl(messageModel.contentUrl, _cellFrame.imageRect.size.width, _cellFrame.imageRect.size.height);
                [self.imageContent sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"loaded"]];
            }
            else
            {
                NSString *localPath = [[FileMangeHelper shareInstance] getUploadFilePathFromFileType:UploadFileImageType fileName:messageModel.localFileName];
                UIImage *image = [UIImage imageWithContentsOfFile:localPath];
                [self.imageContent setImage:image];
            }
        }
        default:
            break;
    }
}

/**
 *  点击放大图片
 *
 *  @param tap 手势view
 */
- (void)magnifyImage:(UITapGestureRecognizer*)tap
{
    // 1.封装图片数据
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    MJPhoto *photo = [[MJPhoto alloc] init];
    
    if (IsEmpty(_messageModel.localFileName)) {
        photo.url = [NSURL URLWithString:_messageModel.contentUrl]; // 图片路径
    } else {
        NSString *localPath = [[FileMangeHelper shareInstance] getUploadFilePathFromFileType:UploadFileImageType fileName:_messageModel.localFileName];
        UIImage *image = [UIImage imageWithContentsOfFile:localPath];
        photo.image = image;
    }
    photo.srcImageView = (UIImageView *)tap.view; // 来源于哪个UIImageView
    [photos addObject:photo];
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.showSaveBtn = 0;
    browser.currentPhotoIndex = tap.view.tag - 100; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (void)didSelectedTableViewRow {
    
    WEAK_SELF
    switch (_dataModelType) {
        case ProtoMessageContentTypeVoice:
        {
            [[PlayerHelper shared] stop];
            [self.voiceAnimatedImage startAnimating];
            NSString *url = _messageModel.contentUrl;
            if (!IsEmpty(_messageModel.localFileName))
            {
                url = AliFile(_messageModel.localFileName);
            }
            [[PlayerHelper shared] playVoiceOfUrlString:url finishBlock:^{
                [weak_self.voiceAnimatedImage stopAnimating];
            }];
        }
            break;
            
        default:
            break;
    }
    
    return;
    /*
    //播放声音
    if (_messageModel.isMyself) {
        
        if (IsEmpty(_messageModel.localFileName)) {
            
            if (_pictureDidSelectedBlock) {
                _pictureDidSelectedBlock(_messageModel.contentText);
            }
            
//            AVSpeechUtterance *utterance = [AVSpeechUtterance
//                                            speechUtteranceWithString:_message.message.content.text];
//            AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
//            [synth speakUtterance:utterance];
            
        } else {
            NSString *localUrl = AliFile(_messageModel.localFileName);
            
//            if (_dataModelType == MessageContentTypeAudio) {
//                [self.voiceAnimatedImage startAnimating];
//            }
            [[PlayerHelper shared] playVoiceOfUrlString:localUrl finishBlock:^{
//                if (_dataModelType == MessageContentTypeAudio) {
//                    [self.voiceAnimatedImage stopAnimating];
//                }
            }];
            
        }
        
    } else if (_dataModelType == ProtoMessageContentTypeCompoment) {
        
        
        
    } else {
        
        if (IsEmpty(_messageModel.contentUrl)) {
            
            if (_pictureDidSelectedBlock) {
//                _pictureDidSelectedBlock(_message.message.content.text);
                _pictureDidSelectedBlock(_textContent.plainText);
            }
            
        } else {
//            if (_dataModelType == MessageContentTypeAudio) {
//                [self.voiceAnimatedImage startAnimating];
//            }
            [[PlayerHelper shared] playVoiceOfUrlString:_messageModel.contentUrl finishBlock:^{
//                if (_dataModelType == MessageContentTypeAudio) {
//                    [self.voiceAnimatedImage stopAnimating];
//                }
            }];
            
        }
    }*/
}

/**
 *  设置聊天消息背景图片
 *
 *  @param right 是否是右边消息
 */
- (void)setChantViewBackgroundImageWithRight:(BOOL)right withFrame:(CGRect)frame
{
    self.backgroundImageView.frame = frame;
    UIImage *img;
    if (right) {
        img = [UIImage imageNamed:@"chat_blue"];
    } else {
        img = [UIImage imageNamed:@"chat_white"];
    }
    _backgroundImageView.image = img;
    _backgroundImageView.layer.contentsCenter = CGRectMake(0.5, 0.7, 0, 0);
}
//设置时间
-(void)setTimeText:(NSString *)timeStr
{
    if (_timeLabel.hidden == NO)
    {
        NSString *currentDateStr = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd"];
        CGFloat width;
        if ([timeStr rangeOfString:currentDateStr].length > 1)
        {
            width = 70;
            _timeLabel.text = [timeStr componentsSeparatedByString:@" "][1];
        }
        else
        {
            width = 140;
            _timeLabel.text = timeStr;
        }
        [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(width));
        }];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && _resendContentBlock)
    {
        _resendContentBlock(_indexPath);
    }
}

#pragma mark - RTLabelDelegate

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    [[UIApplication sharedApplication] openURL:url];
}

/**
 *  正在发送中提示UI
 *
 *  @param b YES为提示发送 NO为不提示发送
 */
-(void)ActivityAnimatinWithBOOL:(BOOL)b
{
    if (b)
    {
        _activityView.hidden = NO;
        [_activityView startAnimating];
    }
    else
    {
        _activityView.hidden = YES;
        [_activityView stopAnimating];
    }
}
/**
 *  发送信息超时提示发送失败
 *
 *  @param index <#index description#>
 */
- (void)reloadDataAfterTime:(SessonContentModel *)messageModel
{    
    if (IsEmpty(messageModel.key_id) && messageModel.isMyself && [_activityView isAnimating] && [messageModel.localId isEqualToString:self.messageModel.localId])
    {
        _errorButton.hidden = NO;
        [self ActivityAnimatinWithBOOL:NO];
        self.messageModel.isSendError = YES;
        [[DatabaseCache shareInstance] updateInfoErrorWithChannel:messageModel.channel localid:messageModel.localId isSendError:@"1"];
    }
//    else
//    {
//        _errorButton.hidden = YES;
//        [self ActivityAnimatinWithBOOL:NO];
//    }
}

- (void)sendSucceedChangeStatus:(BOOL)b
{
    if (b)
    {
        _errorButton.hidden = YES;
        [self ActivityAnimatinWithBOOL:NO];
    }
    else
    {
        _errorButton.hidden = NO;
        [self ActivityAnimatinWithBOOL:NO];
    }
    
}
#pragma mark - 设置时间
- (void)setTimeWith:(NSTimeInterval )timeInterval
{
    CGFloat width = 0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a hh:mm"];
    NSString *chatCellTime = [formatter stringFromDate:date];
    
    NSString *currentDateStr = [NSDate currentDateStringWithFormat:@"yyyy年MM月dd"];
    if ([chatCellTime rangeOfString:currentDateStr].length > 1)
    {
        NSArray *dateArray = [chatCellTime componentsSeparatedByString:@" "];
        if (dateArray.count > 2) {
            _timeLabel.text = [NSString stringWithFormat:@"%@ %@",dateArray[1],dateArray[2]];
        }else {
            _timeLabel.text = dateArray.lastObject;
        }
    }
    else
    {
        _timeLabel.text = chatCellTime;
    }
    width = [_timeLabel.text boundingRectWithSize:CGSizeMake(320, 15) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_timeLabel.font} context:nil].size.width + 10;
    [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
    }];
}

#pragma mark - getter

+ (RTLabel*)textLabel
{
    RTLabel *rtLabel = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kEdgeInsetLeft - kEdgeInsetBottom - kFixedClearance - 54 - 15, 1000)];
    rtLabel.textColor = [UIColor blackColor];
    rtLabel.font = [UIFont CustomFontOfSize:17];
    [rtLabel setParagraphReplacement:@""];
    return rtLabel;
}

-(UIActivityIndicatorView *)activityView
{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.hidden = YES;
        [_activityView stopAnimating];
    }
    return _activityView;
}

-(UIButton *)errorButton
{
    if (_errorButton == nil) {
        _errorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorButton.bounds = CGRectMake(0, 0, 30, 30);
        [_errorButton setImage:[UIImage imageNamed:@"InfoError"] forState:UIControlStateNormal];
        [_errorButton addTarget:self action:@selector(errorAction:) forControlEvents:UIControlEventTouchUpInside];
        _errorButton.hidden = YES;
    }
    return _errorButton;
}

-(UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc ]init];
        _timeLabel.backgroundColor = UIColorFromRGB(0Xd8dbe2);
        _timeLabel.textColor = kWhiteColor;
        _timeLabel.font = KSmallFont;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.layer.cornerRadius = 3;
        _timeLabel.clipsToBounds = YES;
    }
    return _timeLabel;
}

-(UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(didSelectedTableViewRow)];
        [_backgroundImageView addGestureRecognizer:tap];
    }
    return _backgroundImageView;
}

- (NSTextAttachment *)attch {
    
    if (!_attch) {
        // 添加表情
        _attch = [[NSTextAttachment alloc] init];
        // 表情图片
        _attch.image = [UIImage imageNamed:@"horn"];
        // 设置图片大小
        _attch.bounds = CGRectMake(0, 0, 15, 15);
    }
    
    return _attch;
}

- (UIButton *)headerBtn {
    
    if (!_headerBtn) {
        _headerBtn = [XKO_CreateUIViewHelper createUIButtonWithNormalImage:IMAGE(@"head_bg") highlightedImage:nil radiusSize:NO frame:CGRectZero];
        
        [_headerBtn addSubview:self.headerImg];
        [self.headerImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_headerBtn);
            make.width.equalTo(_headerBtn).with.offset(-2);
            make.height.equalTo(_headerBtn).with.offset(-2);
        }];
    }
    
    return _headerBtn;
}


- (UIImageView *)headerImg {
    
    if (!_headerImg) {
        
        _headerImg = [XKO_CreateUIViewHelper createUIImageViewWithImage:IMAGE(@"default_head")];
        _headerImg.layer.masksToBounds = YES;
        _headerImg.userInteractionEnabled = YES;
        WEAK_SELF;
        [_headerImg addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weak_self tapAvatarAction];
        }];
    }
    
    return _headerImg;
}

-(UILabel *)voiceTimeLabel
{
    if (!_voiceTimeLabel) {
        _voiceTimeLabel = [[UILabel alloc] init];
        _voiceTimeLabel.font = [UIFont CustomFontOfSize:14];
        
    }
    return  _voiceTimeLabel;
}

- (UIImageView *)voiceAnimatedImage {
    if (_voiceAnimatedImage == nil) {
        UIImageView *imageViewOne = [[UIImageView alloc] initWithImage:IMAGE(@"msg_my_voice_03")];
        NSArray *imagesArray = @[IMAGE(@"msg_my_voice_01"),IMAGE(@"msg_my_voice_02"),IMAGE(@"msg_my_voice_03")];
        // 设置动画
        imageViewOne.animationImages      = imagesArray;
        imageViewOne.animationDuration    = 1.5;
        imageViewOne.animationRepeatCount = 0;
        _voiceAnimatedImage = imageViewOne;
        //        _voiceAnimatedImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _voiceAnimatedImage;
}

- (RTLabel *)textContent {
    
    if (!_textContent) {
        
        _textContent = [ChatViewCell textLabel];
        //        _textContent.textColor = [UIColor blackColor];
        //        _textContent.font = KNormalFont;
        _textContent.delegate  = self;
        //        [_textContent setParagraphReplacement:@""];
        _textContent.textAlignment = kCTTextAlignmentLeft;
        
        //        _textContent.delegate = self;
        //        _textContent.linkColor = [UIColor whiteColor];
        //        _textContent.highlightedLinkBackgroundColor = [UIColor clearColor];
        //        _textContent.linksHaveUnderlines = NO;
    }
    
    return _textContent;
}

- (UIImageView *)imageContent {
    
    if (!_imageContent) {
        _imageContent = [XKO_CreateUIViewHelper createUIImageViewWithImage:[[UIColor grayColor] translateIntoImage]];
        _imageContent.tag = 100;
        _imageContent.userInteractionEnabled = YES;
        _imageContent.layer.cornerRadius = 10;
        _imageContent.clipsToBounds = YES;
        _imageContent.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
        singleFingerOne.numberOfTouchesRequired = 1; //手指数
        singleFingerOne.numberOfTapsRequired = 1; //tap次数
        [_imageContent addGestureRecognizer:singleFingerOne];
    }
    
    return _imageContent;
}


- (UIButton *)pluginText {
    
    if (!_pluginText) {
        
        _pluginText = [XKO_CreateUIViewHelper createUIButtonWithTitle:@"" titleColor:[UIColor whiteColor] titleFont:KSmallFont backgroundColor:[UIColor clearColor] hasRadius:NO targetSelector:nil target:self];
        _pluginText.titleLabel.lineBreakMode = 0;
        [_pluginText setTitleEdgeInsets:UIEdgeInsetsMake(0, KLeftMargin, 0, KLeftMargin)];
        _pluginText.frame = CGRectMake(0, 0, kScreenWidth-60, 50);
        
        [_pluginText setBackgroundImage:[IMAGE(@"compent_bg") stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateNormal];
        
        [_pluginText setHidden:YES];
        
    }
    
    return _pluginText;
    
}

- (UILabel *)pluginDesc {
    
    if (!_pluginDesc) {
        _pluginDesc = [XKO_CreateUIViewHelper createLabelWithFont:kFontSize12 fontColor:[UIColor whiteColor] text:@""];
    }
    
    return _pluginDesc;
    
}

- (UIView *)videoContent {
    
    if (!_videoContent) {
        
        _videoContent = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _videoContent;
}

- (UIView *)audioContent {
    
    if (!_audioContent) {
        
        _audioContent = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _audioContent;
}

@end
