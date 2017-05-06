//
//  weatherManager.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "urlManagerHeader.h"
#import "weather.h"
#import "AFNetworking.h"

@protocol weatherManagerDelegate <NSObject>

- (void) DidFinishLoadingWithWeather:(weather *)weather;
// 网络请求出现错误
- (void) DidFailWithError:(NSError *)error;

@end


@interface weatherManager : NSObject
{
    id                      m_delegate;
    NSString                *_intString;
}
@property (nonatomic, retain)id<weatherManagerDelegate>delegate;
- (void) setLocationWithCity:(NSString *)city;

- (void) startRequestWithDelegate:(id) delegate;

@end
