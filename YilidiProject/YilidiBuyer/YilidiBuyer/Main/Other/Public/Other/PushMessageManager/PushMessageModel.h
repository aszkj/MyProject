//
//  PushMessageModel.h
//  YilidiBuyer
//
//  Created by mm on 17/4/1.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger,PushMessageType) {
    PushMessage_Unknown     = 0,                    //未知消息
    PushMessage_Tickect     = 1,                    //券消息
    PushMessage_Refund      = 2,                    //退款消息
    PushMessage_Activity    = 3                     //活动消息
};

@interface PushMessageModel : BaseModel

@property (nonatomic,copy)NSString *messageId;

@property (nonatomic,copy)NSString *messageTitle;

@property (nonatomic,copy)NSString *messageAbstract;

@property (nonatomic,copy)NSString *messageImageUrl;

@property (nonatomic,copy)NSDictionary *messageContent;

/**
 消息发生时间
 */
@property (nonatomic,copy)NSString *messageTime;

@property (nonatomic,assign)PushMessageType pushMessageType;

@property (nonatomic,assign)NSString *messageCode;

@property (nonatomic,assign)BOOL isOffLineMessage;


/**
 用户是否点击了这条消息，如果点击了，要做相应跳转
 */
@property (nonatomic,assign)BOOL userHasClickedThisMessage;

@end
