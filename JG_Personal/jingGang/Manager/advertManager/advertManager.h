//
//  advertManager.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VApiManager.h"
#import "AccessToken.h"

@protocol advertManagerDelegate <NSObject>
@optional
//网络请求成功收到返回值
- (void) DidFinishLoadingWithArray:(NSMutableArray *)array WithKeyStr:(NSString *)keyStr;
// 网络请求出现错误
- (void) DidFailWithError:(NSError *)error;
@end

@interface advertManager : NSObject
{
    VApiManager        *_vapManager;
    __unsafe_unretained  id                  m_delegate;
}

@property (nonatomic, assign)id<advertManagerDelegate>       delegate;


//开始广告请求
- (void) startRequestWithkeyStr:(NSString *) keyStr withDelegate:(id) delegate;

@end
