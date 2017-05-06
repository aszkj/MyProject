//
//  FeedLocalModel.m
//  weimi
//
//  Created by ray on 16/1/27.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "FeedLocalModel.h"
#import "WEMEFeed.h"

@implementation FeedLocalModel

+ (NSArray<FeedLocalModel *> *)convertWithWEMEFeedArray:(NSArray<WEMEFeed *> *)feedArray
{
    [FeedLocalModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"title" : @"content.text",
                 @"voice_url" : @"content.url",
                 @"image_url" : @"content.url",
                 @"type" : @"content.type",
                 @"Myfeed_content_id" : @"_id"
                 };
    }];
    
    NSMutableArray *array = [FeedLocalModel objectArrayWithKeyValuesArray:[WEMEFeed keyValuesArrayWithObjectArray:feedArray]] ;

    [FeedLocalModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{};
    }];
    
    return array;
}

@end
