//
//  SessonContentModel.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/12/14.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "SessonContentModel.h"
#import "WEMEMongoMessage.h"

@implementation SessonContentModel

//+ (NSArray<SessonContentModel *> *)convertWithWEMEFeedArray:(NSArray<WEMEMongoMessage *> *)simpleMyFeed
//{
//    [FeedLocalModel setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"title" : @"content.text",
//                 @"voice_url" : @"content.url",
//                 @"image_url" : @"content.url",
//                 @"type" : @"content.type",
//                 @"Myfeed_content_id" : @"_id"
//                 };
//    }];
//    
//    NSMutableArray *array = [FeedLocalModel objectArrayWithKeyValuesArray:[WEMEFeed keyValuesArrayWithObjectArray:feedArray]] ;
//    
//    [FeedLocalModel setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{};
//    }];
//    
//    return array;
//}

-(id)initWithSimpleMyFeed:(WEMEMongoMessage *)simpleMyFeed channel:(NSString *)channel {

    if (self = [super init]) {
        
        _channel = channel;
        _key_id = simpleMyFeed._id;
        _msgId = simpleMyFeed._id;
        _localId = simpleMyFeed.localId;
        _msgType = simpleMyFeed.msgType;
        _uid = simpleMyFeed.uid;
        _contentWidth = [simpleMyFeed.content.width integerValue];
        _contentHeight = [simpleMyFeed.content.height integerValue];
        _contentText = simpleMyFeed.content.content;
        _contentUrl = simpleMyFeed.content.url;
        _contentCode = simpleMyFeed.content.code;
        _contentType = [simpleMyFeed.content.msgtype uppercaseString];
        _contentDuration = [simpleMyFeed.content.duration integerValue];
        
//        _componentDesc = simpleMyFeed.content.desc;
//        _componentId = simpleMyFeed.content._id;
//        _componentName = simpleMyFeed.content.component.name;
//        _componentOrderCode = simpleMyFeed.content.component.orderCode;
//        _componentState = simpleMyFeed.content.component.status;
//        _componentTaskId = simpleMyFeed.content.component.taskId;
//        _componentUrl = simpleMyFeed.content.component.url;
//        _componentVersion = simpleMyFeed.content.component.version;
//        _componentViewType = simpleMyFeed.content.component.viewType;
        
        //@"48025-09-08T20:58:07+0800"
        _contentTimestamp = [simpleMyFeed.timestamp longValue] ;
        
    }
    
    return self;
}


-(id)initWithProtoMessage:(ProtoMessage *)protoMessage isMyself:(NSNumber *)isMyself {
    
    if (self = [super init]) {
        
//        _isMyself = isMyself;
        _channel = protoMessage.broadcastId;
        _msgId = protoMessage.message.id;
        _localId = protoMessage.message.localId;
        _uid = protoMessage.message.uid;
        _model = protoMessage.message.model;
        
        if (protoMessage.message.msgType == ProtoMessageMessageTypeSend) {
            _msgType = @"SEND";
        } else if (protoMessage.message.msgType == ProtoMessageMessageTypeReceive){
            _msgType = @"RECEIVE";
        }
        _contentWidth = protoMessage.message.content.width;
        _contentHeight = protoMessage.message.content.height;
        _contentText = protoMessage.message.content.content;
        _contentUrl = protoMessage.message.content.url;
        _contentCode = protoMessage.message.content.code;
        _contentTimestamp = protoMessage.message.timestamp;
        _contentDuration = (int)protoMessage.message.content.duration;
        _componentId = protoMessage.message.content.component.id;
        _componentName = protoMessage.message.content.component.name;
        _componentUrl = protoMessage.message.content.component.url;
        _componentVersion = protoMessage.message.content.component.version;
        _componentDesc = protoMessage.message.content.component.desc;
        _componentOrderCode = protoMessage.message.content.component.orderCode;
        _componentTaskId = protoMessage.message.content.component.taskId;
        
        if (protoMessage.message.content.component.viewType == ProtoMessageComponentViewTypeDesc) {
            _componentViewType = @"DESC";
        } else if (protoMessage.message.content.component.viewType == ProtoMessageComponentViewTypeDetail) {
            _componentViewType = @"DETAIL";
        }
        
        if (protoMessage.message.content.component.status == ProtoMessageComponentStatusNormal) {
            _componentState = @"NORMAL";
        } else if (protoMessage.message.content.component.status == ProtoMessageComponentStatusExpire) {
            _componentState = @"EXPIRE";
        }
        switch (protoMessage.message.content.msgtype) {
            case ProtoMessageContentTypeText:
                _contentType = @"TEXT";
                break;
            case ProtoMessageContentTypeVoice:
                _contentType = @"VOICE";
                break;
            case ProtoMessageContentTypeImage:
                _contentType = @"IMAGE";
                break;
            case ProtoMessageContentTypeCompoment:
                _contentType = @"COMPONENT";
                break;
            default:
                break;
        }
        
    }
    
    return self;
}


-(ProtoMessageContentType)mqttType
{
    if ([_contentType isEqualToString:@"TEXT"])
    {
         return ProtoMessageContentTypeText;
    }else if ([_contentType isEqualToString:@"IMAGE"])
    {
        return ProtoMessageContentTypeImage;
    } else if ([_contentType isEqualToString:@"VOICE"]) {
        return ProtoMessageContentTypeVoice;
    } else {
        return ProtoMessageContentTypeText;
    }
}

- (BOOL)isMyself {
    if ([_msgType isEqualToString:@"SEND"]) {
        return YES;
    } else {
        return NO;
    }
}


/**
 *  channel现在没有用到所以全部为@""
 *
 *  @return 返回@""
 */
- (NSString *)channel {
    return @"";
}

@end

