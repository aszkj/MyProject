//
//  PushMessageManager+messageListener.h
//  YilidiBuyer
//
//  Created by mm on 17/4/6.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "PushMessageManager.h"

typedef void(^PushMessageListenBlock)(PushMessageModel *model);

@interface PushMessageManager (messageListener)

/**
 新的推送消息监听

 @param pushMessageListenBlock 新消息回调
 */
- (void)startListenPushMessage:(PushMessageListenBlock)pushMessageListenBlock;


/**
 结束消息监听
 */
- (void)endListenPushMessage;

@end
