//  微信分享工具类
//  XMShareWechatUtil.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///  APP KEY
#define APP_KEY_WEIXIN            @"wxadf10b780467d1f7"


///  分享图片
#define SHARE_DEFAULTIMG [UIImage imageNamed:@"shareDefault"]


@interface XMShareWechatUtil : NSObject
/**
 *  分享类型
 */

@property (nonatomic,strong)NSNumber *shareType;

/**
 *  分享标题
 */
@property (nonatomic, strong) NSString *shareTitle;

/**
 *  分享内容
 */
@property (nonatomic, strong) NSString *shareText;

/**
 *  分享链接地址
 */
@property (nonatomic, strong) NSString *shareUrl;

/**
 *  分享图片
 */
@property (nonatomic, strong) NSString *imageUrl;



/**
 *  分享到微信会话
 */
- (void)shareToWeixinSession;

/**
 *  分享到朋友圈
 */
- (void)shareToWeixinTimeline;

+ (instancetype)sharedInstance;

@end
