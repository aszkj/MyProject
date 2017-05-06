//
//  PushMessageModel.m
//  YilidiBuyer
//
//  Created by mm on 17/4/1.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "PushMessageModel.h"


@implementation PushMessageModel

- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.messageContent = dic[@"contentVariablesMap"];
    }
    return self;
}

- (void)setMessageContent:(NSDictionary *)messageContent {
    self.messageId = messageContent[@"msgId"];
    self.messageTitle = messageContent[@"msgTitle"];
    self.messageAbstract = messageContent[@"msgAbstract"];
    self.messageImageUrl = messageContent[@"msgImage"];
    self.messageTime = messageContent[@"msgTime"];
    self.pushMessageType = [messageContent[@"directType"] integerValue];
    self.messageCode = messageContent[@"directCode"];
}

- (void)setMessageIdWithMessageDic:(NSDictionary *)dic{
    NSString *messageOriginalId = dic[@"_gmid_"];
    NSArray  *messageIds = [messageOriginalId componentsSeparatedByString:@":"];
    if (messageIds.count >= 2) {
        self.messageId = messageIds[1];
    }
}



@end
