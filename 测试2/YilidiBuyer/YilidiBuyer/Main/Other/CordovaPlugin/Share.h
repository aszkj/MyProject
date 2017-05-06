//
//  Share.h
//  YilidiBuyer
//
//  Created by mm on 16/12/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Cordova/CDVPlugin.h>

typedef void(^ShareToAllBlock)(void);
typedef void(^ShareToFriendBlock)(void);
typedef void(^ShareToMomentBlock)(void);
typedef void(^ShareSmsBlock)(void);

@interface Share : CDVPlugin

- (void)shareToAll:(CDVInvokedUrlCommand *)command;

//微信好友
- (void)shareToFriend:(CDVInvokedUrlCommand *)command;

//朋友圈
- (void)shareToMoment:(CDVInvokedUrlCommand *)command;

//短信
- (void)shareSms:(CDVInvokedUrlCommand *)command;

@property (nonatomic,copy)ShareToFriendBlock shareToFriendBlock;
@property (nonatomic,copy)ShareToMomentBlock shareToMomentBlock;
@property (nonatomic,copy)ShareSmsBlock shareSmsBlock;
@property (nonatomic,copy)ShareToAllBlock shareToAllBlock;



@end
