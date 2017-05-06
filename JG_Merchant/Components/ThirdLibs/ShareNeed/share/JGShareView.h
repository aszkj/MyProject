//
//  JGShareView.h
//  jingGang
//
//  Created by 张康健 on 15/9/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma===============================ShareModle H==============================
@interface ShareModel : NSObject

@property (nonatomic, copy)NSString *shareTitle;

@property (nonatomic, copy)NSString *shareContent;

@property (nonatomic, copy)NSString *shareImgUrl;

@property (nonatomic, copy)NSString *shareUlrStr;

@property (nonatomic, copy)NSString *shareImagePath;

@end

@interface WeiBoShareModel : ShareModel
@end

@interface QQShareModel : ShareModel
@end

@interface WXShareModel : ShareModel
@end

@interface WXFriendShareModle : ShareModel
@end


@interface JGShareView : UIView

//标题，内容，图片url,分享内容点击后的url
+ (id)shareViewWithTitle:(NSString *)shareTitle
                 content:(NSString *)shareContent
               imgUrlStr:(NSString *)shareImgUrl
                  ulrStr:(NSString *)shareUlrStr
             contentView:(UIView *)contentView
          shareImagePath:(NSString *)shareImagePath;

+ (id)shareWithShareModel:(ShareModel *)shareModel;

@property (nonatomic, strong)WeiBoShareModel *weiBoShareModel;

@property (nonatomic, strong)QQShareModel *qqShareModel;

@property (nonatomic, strong)WXShareModel *wxShareModel;

@property (nonatomic, strong)WXFriendShareModle *wxFriendShareModle;

-(void)_onShow;

-(void)show;

@property (nonatomic, copy) void (^hiddenBlock)(void);

@end





