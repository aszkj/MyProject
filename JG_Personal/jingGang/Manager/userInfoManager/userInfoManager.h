//
//  userInfoManager.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "urlManagerHeader.h"

@protocol userInfoManager <NSObject>

//网络请求成功收到返回值
- (void) DidFinishLoading:(int) nResult WithMsg:(NSString *)msg;
// 网络请求出现错误
- (void) DidFailWithError:(NSError *)error;
@end

@interface userInfoManager : NSObject
{
    __unsafe_unretained id     m_delegate;
    NSString                   *_Msg;
}

@property (nonatomic, assign)id              delegate;
@property (nonatomic, copy)NSString          *Msg;

- (void)startRequestWith;

@end
