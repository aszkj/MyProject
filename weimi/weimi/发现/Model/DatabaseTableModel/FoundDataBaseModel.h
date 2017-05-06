//
//  FoundDataBaseModel.h
//  weimi
//
//  Created by 张康健 on 16/1/28.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

//发现数据库模型
@interface FoundDataBaseModel : JSONModel

#pragma mark - 发布者信息相关
//发布者uid
@property (nonatomic, copy)NSString *found_poster_Uid;

//发布者头像
@property (nonatomic, copy)NSString *found_poster_avartUrl;

//发布者昵称
@property (nonatomic, copy)NSString *found_poster_nickName;


#pragma mark - 发布内容相关
//发布内容的类型
@property (nonatomic, copy)NSString *found_content_Type;

//发布内容文字
@property (nonatomic, copy)NSString *found_content_Text;

//发布内容图片url
@property (nonatomic, copy)NSString *found_content_ImgUrl;

//发布内容音频url
@property (nonatomic, copy)NSString *found_content_AudioUrl;


#pragma mark - 回复相关
//有最新回复
@property (nonatomic, assign)BOOL found_hasLatestMessage;

//回复类型
@property (nonatomic, copy)NSString *found_repy_Type;

//回复文字
@property (nonatomic, copy)NSString *found_repy_Text;

//回复人的uid
@property (nonatomic, copy)NSString *found_repyer_Uid;

//回复人的昵称
@property (nonatomic, copy)NSString *found_repyer_NickName;


#pragma mark - 其他
//主题对应的channel
@property (nonatomic, copy)NSString *found_channnel;

//发布距离
@property (nonatomic, copy)NSString *found_distanceStr;

//发布时间
@property (nonatomic, strong)NSNumber *found_disstributTime;

//来自哪里，朋友圈、附近的人
@property (nonatomic, copy)NSString *found_fromWhereTypeStr;

//有未读消息
@property (nonatomic, assign)BOOL found_hasUnreadMessage;


@end
