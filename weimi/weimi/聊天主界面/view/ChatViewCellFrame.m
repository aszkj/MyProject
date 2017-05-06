//
//  ChatViewCellFrame.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/11/4.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "ChatViewCellFrame.h"
#import "NSString+Teshuzifu.h"
#import "FileMangeHelper.h"
#import "ChatViewCell.h"
#import "SessonContentModel.h"
#import "DatabaseCache.h"
#import <WEMESimpleMyFeed.h>

#define kChatTimeHeight 20
#define kSpacing (40/3)
#define kBackImageEdge 10

#define kHeaderImageHeight  0

@interface ChatViewCellFrame()

#define avatorSize      40.0
#define avatorToBackImage 8.0

@property (nonatomic, assign) NSInteger horizontalWidth; //内容与边框距离
@property (nonatomic, assign) NSInteger leftTextMargin;
@property (nonatomic, assign) NSInteger leftImageMargin;
@property (nonatomic, assign) NSInteger leftheaderImageMargin;
@property (nonatomic, assign) NSInteger topY;
@property (nonatomic, assign) NSInteger leftX;

@end

@implementation ChatViewCellFrame

-(id)initWithDateModel:(SessonContentModel *)dataModel
{
    if (self = [super init]) {
        self.messageModel = dataModel;

        _topY = _topY + (_messageModel.isHiddenTime ? kChatTimeHeight:0);
        _leftX = kSpacing + avatorToBackImage + kBackImageEdge + CGRectGetWidth(self.headImageRect);
    }
    return self;
}

- (id)initWithDataModel:(SessonContentModel *)dataModel dataModelType:(ProtoMessageContentType)dataModelType webSize:(CGSize)webSize {
    
    if (self = [super init]) {
        self.messageModel = dataModel;
        _dataModelType = dataModelType;
        _webViewSize = webSize;
        _horizontalWidth = kScreenWidth - kEdgeInsetLeft - kEdgeInsetBottom - kFixedClearance - 54 - 15;
        if (self.messageModel.isMyself) {
            _leftheaderImageMargin = kScreenWidth - kHeaderImageHeight;
            _leftTextMargin = kEdgeInsetLeft + kFixedClearance - kHeaderImageHeight + 48;
            _leftImageMargin = kScreenWidth - kEdgeInsetRight - KImageWidth - kHeaderImageHeight;
        } else {
            _leftheaderImageMargin = kEdgeInsetLeft;
            _leftTextMargin = 18 + kHeaderImageHeight;
            _leftImageMargin = kEdgeInsetLeft + kHeaderImageHeight;
        }
    }
    
    
    return self;
}

- (CGRect)headImageRect {
    
    if (_headImageRect.size.width <= 0 && _textRect.size.height <= 0) {
        CGFloat width = avatorSize;
        if (!self.messageModel.isMyself) {
            _headImageRect = CGRectMake(kSpacing, _topY, width, width);
        } else {
            _headImageRect = CGRectMake(kScreenWidth - kSpacing - width,_topY, width, width);
        }
    }
    
    return _headImageRect;
}

- (CGRect)getTextRect:(NSString *)string {
    RTLabel *textRtLabel = [ChatViewCell textLabel];
    [textRtLabel setText:string];
    CGSize optimumSize = [textRtLabel optimumSize];
    
    CGFloat x = _leftX + kBackImageEdge / 2 ;
    CGFloat width = optimumSize.width;
    CGFloat height = optimumSize.height;
    width = width < 25 ? 25 :width;
    if ([self.messageModel.msgType isEqualToString:@"SEND"])//右边
    {
        x = kScreenWidth - _leftX - width;
    }
    return CGRectMake(x, _topY + kBackImageEdge , width, height);
}

- (CGRect)textRect
{
    if (_textRect.size.width <= 0 && _textRect.size.height <= 0) {
        
        _textRect = [self getTextRect:_messageModel.contentText];
        
    }
    return _textRect;
}
-(CGRect)backImageRect
{
    CGFloat audioWith = 70;
    //毫秒转秒，与安卓一致
    NSInteger duration = _messageModel.contentDuration / 1000;
    audioWith = audioWith + 130 * duration / 30;
    audioWith = audioWith > 200 ? 200 : audioWith;
//    CGFloat minWidth = 40; //语音最小宽度
    if ([self.messageModel.msgType isEqualToString:@"SEND"])
    {
        if (_dataModelType == ProtoMessageContentTypeVoice)
        {
            _backImageRect = CGRectMake(CGRectGetMinX(self.headImageRect) - avatorToBackImage - audioWith, _topY, audioWith, 40);
        }
        else
        {
//            CGFloat x =  CGRectGetMinX(self.textRect) - kBackImageEdge ;
//            CGFloat width = CGRectGetMinX(self.headImageRect) - x -  kSpacing;

            CGFloat width = CGRectGetWidth(self.textRect) + kBackImageEdge*2;
            CGFloat x = CGRectGetMinX(self.headImageRect) - avatorToBackImage - width;
            
            _backImageRect = CGRectMake( x , CGRectGetMinY(self.textRect) - kBackImageEdge , width, CGRectGetHeight(self.textRect) + 2 * kBackImageEdge);
        }
    } else {
        if (_dataModelType == ProtoMessageContentTypeVoice)
        {
            _backImageRect = CGRectMake(CGRectGetMaxX(self.headImageRect) + avatorToBackImage, _topY, audioWith, 40);
        }
        else
        {
            _backImageRect = CGRectMake(CGRectGetMaxX(self.headImageRect) + avatorToBackImage, CGRectGetMinY(self.textRect) - kBackImageEdge , CGRectGetWidth(self.textRect) + 2 * kBackImageEdge  +  kBackImageEdge / 2, CGRectGetHeight(self.textRect) + 2 * kBackImageEdge);
        }
    }
    return _backImageRect;
}
-(CGPoint)errorPoint
{
    if (_errorPoint.x <= 0)
    {
        CGFloat h = 20;
        if ([self.messageModel.msgType isEqualToString:@"SEND"])
        {
            switch (_dataModelType) {
                case ProtoMessageContentTypeText:
                {
                     _errorPoint = CGPointMake(CGRectGetMinX(self.backImageRect) - h, CGRectGetMinY(self.textRect) + CGRectGetHeight(self.textRect) / 2);
                }
                    break;
                case ProtoMessageContentTypeImage:
                {
                    _errorPoint = CGPointMake(CGRectGetMinX(self.imageRect) - h, CGRectGetMinY(self.imageRect) + CGRectGetHeight(self.imageRect) / 2);
                }
                    break;
                case ProtoMessageContentTypeVoice:
                {
                    _errorPoint = CGPointMake(CGRectGetMinX(self.backImageRect) - h, CGRectGetMinY(self.textRect) + CGRectGetHeight(self.textRect) / 2);
                }
                    break;
                default:
                    break;
            }
        }
        else
        {
            _errorPoint = CGPointMake(kScreenWidth + 30, 0);
        }
    }
    return _errorPoint;
}
-(CGPoint)activityPoint
{
    if (_activityPoint.x <= 0)
    {
        CGFloat h = 18;
        if ([self.messageModel.msgType isEqualToString:@"SEND"])
        {
            switch (_dataModelType) {
                case ProtoMessageContentTypeText:
                {
                    _activityPoint = CGPointMake(CGRectGetMinX(self.backImageRect) - h, CGRectGetMinY(self.textRect) + CGRectGetHeight(self.textRect) / 2);
                }
                    break;
                case ProtoMessageContentTypeImage:
                {
                    _activityPoint = CGPointMake(CGRectGetMinX(self.imageRect) - h, CGRectGetMinY(self.imageRect) + CGRectGetHeight(self.imageRect) / 2);
                }
                    break;
                case ProtoMessageContentTypeVoice:
                {
                    _activityPoint = CGPointMake(CGRectGetMinX(self.backImageRect) - h, CGRectGetMinY(self.textRect) + CGRectGetHeight(self.textRect) / 2);
                }
                    break;
                default:
                    break;
            }
        }
        else
        {
            _activityPoint = CGPointMake(kScreenWidth + 30, 0);
        }

    }
    return _activityPoint;
}

- (CGRect)imageRect
{
    if (_imageRect.size.height <= 0) {
        CGSize size = [Util resetImageSizeFromSourceSize:CGSizeMake(_messageModel.contentWidth, _messageModel.contentHeight) maxWidth:KImageWidth maxHeight:KImageHeight];
        if ([self.messageModel.msgType isEqualToString:@"SEND"])
        {
            _imageRect = CGRectMake(CGRectGetMinX(self.headImageRect) - size.width - kSpacing, _topY, size.width, size.height);
        }
        else
        {
            _imageRect = CGRectMake(CGRectGetMaxX(self.headImageRect) + kSpacing , _topY, size.width , size.height );
        }
//        CGFloat spacing = 10; //图片跟头像的间距
//        if (_webViewSize.height == 0) {
//            _imageRect = CGRectMake(CGRectGetMaxX(self.headImageRect) + spacing, kEdgeInsetTop, KImageWidth, KImageHeight);
//        } else {
//            
//            _imageRect = CGRectMake(CGRectGetMaxX(self.headImageRect) + spacing, kEdgeInsetTop, _webViewSize.width, _webViewSize.height);
//        }
//        if (IsEmpty(self.message.local_Path)) {
//            
//            if (_webViewSize.height == 0) {
//                _imageRect = CGRectMake(CGRectGetMaxX(self.headImageRect) + spacing, kEdgeInsetTop, KImageWidth, KImageHeight);
//            } else {
//                
//                _imageRect = CGRectMake(CGRectGetMaxX(self.headImageRect) + spacing, kEdgeInsetTop, _webViewSize.width, _webViewSize.height);
//            }
//            
//        } else {
//            
//            NSString *localPath = [[FileMangeHelper shareInstance] getUploadFilePathFromFileType:UploadFileImageType fileName:_message.local_Path];
//            UIImage *image = [UIImage imageWithContentsOfFile:localPath];
//            
//            //调整高度
//            CGSize imgRect = [Util resetImageSizeFromSourceSize:image.size maxWidth:KImageWidth maxHeight:KImageHeight];
//            
//            _imageRect = CGRectMake(CGRectGetMinX(self.headImageRect) - imgRect.width - spacing, kEdgeInsetTop, imgRect.width, imgRect.height);
//            
//        }
    }
    return _imageRect;
}

- (CGRect)webRect
{
    if (_webRect.size.width <= 0 && _webRect.size.height <= 0) {
                
        if (self.messageModel.isMyself) {

            _webRect = CGRectMake(kScreenWidth - kEdgeInsetRight - kHeaderImageHeight -_webViewSize.width, kEdgeInsetTop, _webViewSize.width, _webViewSize.height);
            
        } else {

//            if (self.message.message.message.content.component.viewType == ProtoMessageComponentViewTypeDesc) {
//                
//                CGSize size = [_message.message.message.content.component.desc getSizeWithWidth:_webViewSize.width font:KSmallFont];
//                if (size.height < 50) {
//                    size.height = 50;
//                }
//                
//                _webRect = CGRectMake(kComponentLeftMargin, 0, _webViewSize.width, size.height + kEdgeInsetTop + kEdgeInsetTop);
//                
//            } else {
//                _webRect = CGRectMake(kComponentLeftMargin, 0, _webViewSize.width, _webViewSize.height);
//            }
            
        }
    }
    return _webRect;
}

- (CGRect)videoRect
{
    if (_videoRect.size.width <= 0 && _videoRect.size.height <= 0) {
        
        _videoRect = CGRectMake(_leftImageMargin, kEdgeInsetTop, KImageWidth, KImageHeight);
        
    }
    return _videoRect;
}

- (CGRect)voiceImageRect
{
    if (_voiceImageRect.size.width <= 0 && _voiceImageRect.size.height <= 0) {
        CGFloat width = 18;
        CGFloat height = 18;
        CGRect frame = CGRectMake(0, 0, width, height);
        frame.origin.y = /*CGRectGetMinY(self.backImageRect) +*/ CGRectGetHeight(self.backImageRect) / 2 - height / 2;
        if ([self.messageModel.msgType isEqualToString:@"SEND"])
        {
            frame.origin.x = CGRectGetWidth(self.backImageRect) -  KTopMargin - width;
        }
        else
        {
            frame.origin.x = KTopMargin;
        }
        _voiceImageRect = frame;
    }
    return _voiceImageRect;
}
- (CGRect)voiceTimeRect
{
    if (_voiceTimeRect.size.width <= 0)
    {
        if ([self.messageModel.msgType isEqualToString:@"SEND"])
        {
            _voiceTimeRect = CGRectMake(KTopMargin, CGRectGetHeight(self.backImageRect) / 2 - 10, 35, 20);
        }
        else
        {
            _voiceTimeRect = CGRectMake(CGRectGetWidth(self.backImageRect) - KTopMargin - 35, CGRectGetHeight(self.backImageRect) / 2 - 10, 35, 20);
        }
    }
    return _voiceTimeRect;
}

- (CGFloat)cellHeight
{
    CGFloat height = 0;
    
    switch (_dataModelType) {
        case ProtoMessageContentTypeText:
        {
            height = CGRectGetMaxY(self.backImageRect);
        }
            break;
        case ProtoMessageContentTypeVoice:
        {
            height = CGRectGetMaxY(self.backImageRect);
        }
            break;
        case ProtoMessageContentTypeImage:
        {
            height = CGRectGetMaxY(self.imageRect);
        }
            break;
        default:
            break;
    }
    
    CGFloat minHeight = CGRectGetMaxY(self.headImageRect);
    if (height < minHeight) {
        height = minHeight;
    }
    height += kSpacing;
    
    return height;
    
    
    
//    CGFloat height = 0;
//    if (_dataModelType == ProtoMessageContentTypeText) {
//        
//        height = kEdgeInsetTop + self.textRect.origin.y + self.textRect.size.height;
//        
//    } else if (_dataModelType == ProtoMessageContentTypeImage) {
//        
//        height = kEdgeInsetTop + self.imageRect.origin.y + self.imageRect.size.height;
//        
//    }  else if (_dataModelType == ProtoMessageContentTypeAudio) {
//        
////        height = kEdgeInsetTop + self.audioRect.origin.y + self.audioRect.size.height;
//        height = kEdgeInsetTop + self.textRect.origin.y + self.textRect.size.height;
//        
//    } else if (_dataModelType == ProtoMessageContentTypeComponent) {
//        
////        height = kEdgeInsetTop + self.webRect.origin.y + self.webRect.size.height + kEdgeInsetTop;
//        height = 2*kEdgeInsetTop + 60 + self.webRect.size.height;
//
//        NSLog(@"cellHeight:%f",height);
//        
//    } 
//    
//    height += kEdgeInsetVerticalSpacing; //上下间距
//    
//    if (!_message.isHiddenTime)
//    {
//        height = height + 30;
//    }
//    
//    if (height < kHeaderImageHeight) {
//        height = kHeaderImageHeight;
//    }
//    
//    return height;
}

@end
