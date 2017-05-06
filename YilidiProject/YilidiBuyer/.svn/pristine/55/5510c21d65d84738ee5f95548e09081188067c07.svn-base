//
//  PushMessageManager+messageListener.m
//  YilidiBuyer
//
//  Created by mm on 17/4/6.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "PushMessageManager+messageListener.h"
#import "ProjectRelativeDefineNotification.h"
#import "NSObject+SUIAdditions.h"

const void *pushMessageListenBlockKey = @"pushMessageListenBlockKey";
const void *lastMessageModelKey = @"lastMessageModelKey";

@implementation PushMessageManager (messageListener)

- (void)startListenPushMessage:(PushMessageListenBlock)pushMessageListenBlock {
    [self sui_setAssociatedCopyObject:pushMessageListenBlock key:pushMessageListenBlockKey];
    [kNotification addObserver:self selector:@selector(observeRemoteNotification:) name:KNotificationHasRecievedPushNotification object:nil];
}

- (void)endListenPushMessage {
    [kNotification removeObserver:self name:KNotificationHasRecievedPushNotification object:nil];
}

- (void)observeRemoteNotification:(NSNotification *)notification {
    PushMessageModel *model = notification.object;
    PushMessageModel *lastModel = [self sui_getAssociatedObjectWithKey:lastMessageModelKey];
    BOOL hasRecievedNewMessage;
    if (isEmpty(lastModel)) {
        hasRecievedNewMessage = YES;
    }else {
        hasRecievedNewMessage = ![lastModel.messageId isEqualToString:model.messageId];
    }
    if (hasRecievedNewMessage) {
        [self sui_setAssociatedRetainObject:model key:lastMessageModelKey];
        PushMessageListenBlock backBlock = [self sui_getAssociatedObjectWithKey:pushMessageListenBlockKey];
        backBlock(model);
    }
}



@end
