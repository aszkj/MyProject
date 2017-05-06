//
//  loginAndRegistManager.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "urlManagerHeader.h"

@protocol LoginAndRegistManagerDelegate <NSObject>
@optional
//网络请求成功收到返回值
- (void) DidFinishLoading:(int) nResult WithMsg:(NSString *)msg;
// 网络请求出现错误
- (void) DidFailWithError:(NSError *)error;
@end

@interface loginAndRegistManager : NSObject
{
    GeneralQuestResult            _NetworkResult;
    NSString                     *_Msg;
    id                         m_delegate;
}

@property (nonatomic, copy)NSString       *Msg;
@property (nonatomic, retain)id           delegate;

@property (nonatomic, copy)NSString       *tokenStr;


@end
