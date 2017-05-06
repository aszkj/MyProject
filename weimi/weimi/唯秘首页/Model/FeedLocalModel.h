//
//  FeedLocalModel.h
//  weimi
//
//  Created by ray on 16/1/27.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WEMEFeed;

@interface FeedLocalModel : NSObject

@property (nonatomic) NSNumber *Myfeed_content_id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *voice_url;
@property (nonatomic) NSString *image_url;
@property (nonatomic) NSString *type;
/**
 *  创建时间
 */
@property(nonatomic) NSNumber *timestamp;
/**
 *  更新时间(最后回复时间)
 */
@property (nonatomic) NSNumber *lastUpdate;
/**
 *  主题ID
 */
@property (nonatomic) NSString *_id;
@property (nonatomic) NSString *uid;
//@property (nonatomic) NSString *snapshotUid;
//@property (nonatomic) NSString *snapshotContent;

@property (nonatomic) NSNumber* toFriendCircle;
@property (nonatomic) NSNumber* toLbs;
//@property (nonatomic) 

+ (NSArray<FeedLocalModel *> *)convertWithWEMEFeedArray:(NSArray<WEMEFeed *> *)feedArray;

@end
