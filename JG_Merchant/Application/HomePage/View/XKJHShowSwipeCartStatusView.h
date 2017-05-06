//
//  XKJHShowSwipeCartStatusView.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BeginSwipeCartBlock)(void);
typedef enum : NSUInteger {
    ProduceOrderStatus,//生成订单
    IsswipingCartStatus,//正在刷卡状态
    SwipeCartSuccessStatus,//刷卡成功状态
} SwipeCartStatus;

@interface XKJHShowSwipeCartStatusView : UIView

+(id)showInContentView:(UIView *)contentView beginSwipeCart:(BeginSwipeCartBlock)beginSwipeCart;

-(void)hiddden;

//刷卡状态
@property (nonatomic, assign)SwipeCartStatus swipeCartStatus;

@end
