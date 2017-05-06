//
//  MyErWeiMaView.h
//  jingGang
//
//  Created by 张康健 on 15/11/14.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyErWeiMaViewDelegate <NSObject>

- (void)myErWeiMaViewImmediatelyInviteButtonClick;

- (void)shareErweimaButtonClick;

@end

typedef void(^ErweimaSnapUrlGetBlock)(UIImage *shareImage,NSString *shareImageUrl);
typedef void(^ShareErweimaBlock)(void);

@interface ErweiMoModel : NSObject

@property (nonatomic, copy)NSString *userHeaderUrlStr;
@property (nonatomic, copy)NSString *userNickName;
@property (nonatomic, copy)NSString *userInvitationCode;
@property (nonatomic, copy)NSString *userErWeiMoHtmlStr;
@property (nonatomic, copy)NSString *userShareContent;

@end

@interface MyErWeiMaView : UIView

@property (nonatomic, strong)ErweiMoModel *erweimoModel;

@property (nonatomic,assign) id<MyErWeiMaViewDelegate>delegate;


@property (nonatomic, copy)ShareErweimaBlock shareErweimaBlock;

@property (nonatomic, copy)ErweimaSnapUrlGetBlock erweimaSnapUrlGetBlock;

@end

