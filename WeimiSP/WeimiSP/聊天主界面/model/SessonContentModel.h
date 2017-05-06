//
//  SessonContentModel.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/12/14.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "JSONModel.h"
#import "Message.pb.h"

@class SessonContentMessage;
@class WEMEMongoMessage;

@interface SessonContentModel : JSONModel

@property (nonatomic, retain) NSNumber<Optional> *session_content_id;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *localId;
@property (nonatomic, strong) NSString *msgType;
@property (nonatomic, assign) NSInteger model;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) NSInteger contentWidth;
@property (nonatomic, assign) NSInteger contentHeight;
@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *contentCode;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, assign) SInt64 contentTimestamp;
@property (nonatomic, assign) NSInteger contentDuration;
@property (nonatomic, strong) NSString *componentId;
@property (nonatomic, strong) NSString *componentName;
@property (nonatomic, strong) NSString *componentUrl;
@property (nonatomic, strong) NSString *componentVersion;
@property (nonatomic, strong) NSString *componentDesc;
@property (nonatomic, strong) NSString *componentOrderCode;
@property (nonatomic, strong) NSString *componentTaskId;
@property (nonatomic, strong) NSString *componentState;
@property (nonatomic, strong) NSString *componentViewType;
@property (nonatomic)         BOOL isMyself;
@property (nonatomic, strong) NSString *localFileName;
@property (nonatomic, assign) NSInteger sequel;
@property (nonatomic, strong) NSString *key_id;
@property (nonatomic, assign) BOOL isHiddenTime;//YES 显示
@property (nonatomic, assign) BOOL isSendError;
@property (nonatomic, assign) BOOL hasRead;

-(ProtoMessageContentType) mqttType;

-(id)initWithSimpleMyFeed:(WEMEMongoMessage *)simpleMyFeed channel:(NSString *)channel;

-(id)initWithProtoMessage:(ProtoMessage *)protoMessage isMyself:(NSNumber *)isMyself;

@end

