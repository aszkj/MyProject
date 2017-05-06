//
//  shareView.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WeiboShareBlock)(void); // 微博分享
typedef void(^QQShareBlock)(void);    // qq分享
typedef void(^WXShareBlock)(void);    // 微信分享
typedef void(^WXFriendShareBlock)(void);    //微信朋友圈分享
typedef void(^TencentShareBlock)(void); // qq分享

typedef void(^CancelShareBlock)(void);  // 取消

@interface shareView : UIView



@property (nonatomic, retain)IBOutlet UIButton *cacel_btn;

+(shareView *)instance;


//取消分享
@property (nonatomic,copy)CancelShareBlock cancelShareBlock;

@property (nonatomic,copy)WeiboShareBlock weiboShareBlock;

@property (nonatomic,copy)QQShareBlock qqShareBlock;

@property (nonatomic,copy)WXShareBlock wxShareBlock;

@property (nonatomic,copy)WXFriendShareBlock wxFriendShareBlock;


@property (copy , nonatomic) TencentShareBlock tencentShareBlock;


//分享的图片路径
@property (nonatomic,copy) NSString *shareImagePath;


//分享标题
@property (nonatomic,copy)NSString *shareTitle;

//分享内容
@property (nonatomic,copy)NSString *shareContent;

//分享头像url
@property (nonatomic,copy)NSString *shareHeadImgUrl;

//分享点击的url
@property (nonatomic,copy)NSString *shareUrl;

//检测客户端是否安装
-(void)examinClientInstalled;

@end
