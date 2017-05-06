//
//  SessonContentMessage.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/22.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "JSONModel.h"
#import "Message.pb.h"

@class WEMESimpleMyFeed;

@interface SessonContentMessage : JSONModel

@property (nonatomic, strong) WEMESimpleMyFeed *message;
@property (nonatomic, strong) NSNumber<Optional> *session_content_id;
@property (nonatomic, strong) NSNumber *isMyself;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, retain) NSString *subject_id;
@property (nonatomic, strong) NSString *session_id;
@property (nonatomic, retain) NSString *subject_content;
@property (nonatomic, retain) NSString *local_Path;
//是否隐藏时间 YES 隐藏
@property (nonatomic, assign) BOOL isHiddenTime;
//该条信息是否发送失败 YES 失败
@property (nonatomic, assign) BOOL isSendError;
//判断是不是主题消息
@property (nonatomic, assign) BOOL isSubjectMessage;

-(id)initWithMessage:(WEMESimpleMyFeed *)message isMyself:(NSNumber *)isMyself;
//- (NSDictionary *)toConvertDictionary;

@end

