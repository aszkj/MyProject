//
//  ReplayLoaclModel.h
//  weimi
//
//  Created by ray on 16/1/28.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplayLoaclModel : NSObject

/**
 *  对应的主题ID
 */
@property(nonatomic) NSString* fid;
/**
 *  聊天的channel
 */
@property(nonatomic) NSString* channel;
/**
 *  创建时间
 */
@property(nonatomic) NSNumber* timestamp;
/**
 *  更新时间
 */
@property(nonatomic) NSNumber* lastUpdate;
/**
 *  回复内容
 */
@property(nonatomic) NSString* text;

/**
 *  回复的类型
 */
@property(nonatomic) NSString* type;
@property(nonatomic) NSNumber* readed;
@property(nonatomic) NSString* uid;
@property(nonatomic) NSString* fuid;
@property (nonatomic) NSString *distance;


//@property(nonatomic) WEMEMessageSnapshot* snapshot;
//@property(nonatomic) WEMEPoint* location;
//@property(nonatomic) NSString* locationHumanText;

@end
