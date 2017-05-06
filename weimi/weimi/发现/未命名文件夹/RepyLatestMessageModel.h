//
//  RepyLatestMessageModel.h
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepyLatestMessageModel : NSObject

//最新消息回复内容
@property (nonatomic, copy)NSString *repyText;

//最新消息回复人昵称
@property (nonatomic, copy)NSString *repyPersonNickName;


@end
