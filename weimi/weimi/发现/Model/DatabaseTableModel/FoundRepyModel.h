//
//  FoundRepyModel.h
//  weimi
//
//  Created by 张康健 on 16/1/28.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoundRepyModel : NSObject

//回复某条主题，其对应的channel
@property (nonatomic, copy)NSString *found_repy_channel;

//发布该主题的人的uid
@property (nonatomic, copy)NSString *found_repy_distributeTopicPersonId;

//回复人uid
@property (nonatomic, copy)NSString *found_repy_userId;

//回复类型
@property (nonatomic, copy)NSString *found_repy_type;

//回复内容文字
@property (nonatomic, copy)NSString *found_repy_text;


@end
