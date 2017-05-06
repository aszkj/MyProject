//
//  DLShareBottomView.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/11/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^WechatBlock)(void);
typedef void(^FriendsBlock)(void);
typedef void(^MessageBlock)(void);
@interface DLShareBottomView : UIView
@property (nonatomic,strong)WechatBlock wechatBlock;
@property (nonatomic,strong)FriendsBlock friendsBlock;
@property (nonatomic,strong)MessageBlock messageBlock;
@property (strong, nonatomic) IBOutlet UIView *wechatView;
@property (strong, nonatomic) IBOutlet UIView *friendView;
@property (strong, nonatomic) IBOutlet UIView *messageView;

@end
