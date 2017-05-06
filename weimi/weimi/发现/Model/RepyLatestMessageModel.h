//
//  RepyLatestMessageModel.h
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    LatestMessageTextType, //文字
    LatestMessageImageType,//图片
    LatestMessageSoundType,//语音
} LatestMessageType;

#define kLatestMessageToLeft 66
#define kLatestMessageToTopGap 5

@interface RepyLatestMessageModel : NSObject

//最新消息文字
@property (nonatomic, copy)NSString *latesMessageText;

//最新消息发送者昵称
@property (nonatomic, copy)NSString *latesMessageUserNickName;
//最新消息发送者uid
@property (nonatomic, copy)NSString *latesMessageUserUid;

@property (nonatomic, copy)NSString *typeStr;

//最新消息类型
@property (nonatomic,assign)LatestMessageType latestMessageType;

//要展示的str
@property (nonatomic, strong)NSMutableAttributedString *showStr;


//最新消息内容Size
@property (nonatomic, assign)CGSize contentSize;

//最新消息总size
@property (nonatomic, assign)CGSize totalSize;



@end
