//
//  SessonContentMessage.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/22.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "SessonContentMessage.h"
#import "NSDate+Addition.h"
#import "AppDelegate.h"
#import "SessonContentModel.h"
#import <WEMESimpleMyFeed.h>

@implementation SessonContentMessage

//聊天时间间隔多长显示当前时间 （秒）
#define DifferTime 60

-(id)initWithMessage:(WEMESimpleMyFeed *)message isMyself:(NSNumber *)isMyself {
    
    if (self = [super init]) {
        
        _isMyself = isMyself;
        _message = message;
        
        _create_time = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return self;
}

-(id)initWithProtoMessage:(ProtoMessage *)protoMessage isMyself:(NSNumber *)isMyself {
    
    if (self = [super init]) {
        
        _isMyself = isMyself;
        _message = [self convertToFeedMessageWithProtoMessage:protoMessage];
        
        _create_time = [NSDate currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return self;
}

- (WEMESimpleMyFeed *)convertToFeedMessageWithProtoMessage:(ProtoMessage *)protoMessage {
    
    WEMESimpleMyFeed *simpleMyFeed = [[WEMESimpleMyFeed alloc] init];
    simpleMyFeed.content = protoMessage.message.content;
    
    return simpleMyFeed;
}

//- (SessonContentModel*)convertToSessonContentModel {
//    
//    SessonContentMessage *sessonContentMessage = self;
//    
//    if (sessonContentMessage) {
//        
//        SessonContentModel *sessonContentModel = [[SessonContentModel alloc] init];
//        sessonContentModel.session_id = sessonContentMessage.session_id;
//        sessonContentModel.subject_id = sessonContentMessage.subject_id;
//        sessonContentModel.subject_content = sessonContentMessage.subject_content;
//        sessonContentModel.msg_type = sessonContentMessage.message.message.content.type;
//        sessonContentModel.msg_content = sessonContentMessage.message.message.content.text;
//        sessonContentModel.recevier = sessonContentMessage.message.message.channel;
//        sessonContentModel.model = sessonContentMessage.message.message.model;
//        sessonContentModel.sys_code = sessonContentMessage.message.message.content.code;
//        sessonContentModel.isMyself = sessonContentMessage.isMyself;
//        sessonContentModel.content_height = sessonContentMessage.message.message.content.height;
//        sessonContentModel.content_width = sessonContentMessage.message.message.content.width;
//        sessonContentModel.content_timestamp = sessonContentMessage.message.message.content.timestamp;
//        sessonContentModel.content_url = sessonContentMessage.message.message.content.url;
//        sessonContentModel.local_Path = sessonContentMessage.local_Path;
//        sessonContentModel.componentId = sessonContentMessage.message.message.content.component.id;
//        sessonContentModel.componentName = sessonContentMessage.message.message.content.component.name;
//        sessonContentModel.componentUrl = sessonContentMessage.message.message.content.component.url;
//        sessonContentModel.componentDesc = sessonContentMessage.message.message.content.component.desc;
//        sessonContentModel.componentViewType = sessonContentMessage.message.message.content.component.viewType;
//        sessonContentModel.componentStatus = sessonContentMessage.message.message.content.component.status;
//        sessonContentModel.create_time = sessonContentMessage.create_time;
//        sessonContentModel.isHiddenTime = sessonContentMessage.isHiddenTime;
//        sessonContentModel.localId = sessonContentMessage.message.message.localId;
//        sessonContentModel.key_id = sessonContentMessage.message.message.id;
//        sessonContentModel.isSendError = sessonContentMessage.isSendError;
//        if (_message.message.content.duration != 0) {
//            sessonContentModel.duration = (int)_message.message.content.duration;
//        }
//        sessonContentModel.isSubjectMessage = sessonContentMessage.isSubjectMessage;
//
//        return sessonContentModel;
//    }
//    
//    return nil;
//}

//- (NSDictionary *)toConvertDictionary {
//    
//    SessonContentModel *sessonContentModel = [self convertToSessonContentModel];
//    
//    if (sessonContentModel) {
//        return [sessonContentModel toDictionary];
//    }
//    
//    return nil;
//}

@end

