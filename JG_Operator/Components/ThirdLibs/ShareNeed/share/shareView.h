//
//  shareView.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/26.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WeiboShareBlock)(void);
typedef void(^QQShareBlock)(void);
typedef void(^WXShareBlock)(void);
typedef void(^WXFriendShareBlock)(void);

typedef void(^CancelShareBlock)(void);

@interface shareView : UIView



@property (nonatomic, retain)IBOutlet UIButton *cacel_btn;

+(shareView *)instance;


//取消分享
@property (nonatomic,copy)CancelShareBlock cancelShareBlock;

@property (nonatomic,copy)WeiboShareBlock weiboShareBlock;

@property (nonatomic,copy)QQShareBlock qqShareBlock;

@property (nonatomic,copy)WXShareBlock wxShareBlock;

@property (nonatomic,copy)WXFriendShareBlock wxFriendShareBlock;

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
