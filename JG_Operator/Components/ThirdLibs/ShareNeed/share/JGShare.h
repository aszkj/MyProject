//
//  JGShare.h
//  jingGang
//
//  Created by 张康健 on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
@interface JGShare : NSObject

+ (void)shareWithTitle:(NSString *)title
               content:(NSString *)content
          headerImgUrl:(NSString *)headImgUrl
              shareUrl:(NSString *)shareUrl
             shareType:(ShareType)shareType;

/**
 *  分享二维码图片
 */
+ (void)shareWithImage:(NSString *)imagePath
        shareWithTitle:(NSString *)title
               content:(NSString *)shareContent
          headerImgUrl:(NSString *)shareHeadImgUrl
              shareUrl:(NSString *)shareUrl
             shareType:(ShareType)shareType;

@end


