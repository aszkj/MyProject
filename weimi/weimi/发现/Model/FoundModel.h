//
//  FoundModel.h
//  weimi
//
//  Created by 张康健 on 16/1/20.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonDistributeContentModel.h"
#import "RepyLatestMessageModel.h"

@interface FoundModel : NSObject

@property (nonatomic, copy)NSString *channnel;

@property (nonatomic, copy)NSString *avartUrl;

@property (nonatomic, copy)NSString *nickName;

@property (nonatomic, strong)NSString *fromWhereTypeStr;

@property (nonatomic, strong)NSString* fromRecentDistance;

//发布时间
@property (nonatomic, strong)NSNumber *disstributTime;

//发的主题内容模型
@property (nonatomic, strong)PersonDistributeContentModel *personDistributeContentModel;

@property (nonatomic, assign)BOOL hasLatestMessage;

@property (nonatomic, assign)BOOL hasUnreadMessage;

//最新消息模型
@property (nonatomic, strong)RepyLatestMessageModel *repyLatestMessageModel;

@property (nonatomic, copy)NSString *distributePersonID;

@property (nonatomic, assign)CGFloat contentHeight;

@end
