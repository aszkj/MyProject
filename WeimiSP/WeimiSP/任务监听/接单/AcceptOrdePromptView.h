//
//  AcceptOrdePromptView.h
//  WeimiSP
//
//  Created by thinker on 16/2/24.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcceptOrderDetailView.h"
#import "OrderMapView.h"

typedef void (^CancelOrderBlock)(void);

#define AcceptOrderButtonHeight 80

@interface AcceptOrdePromptView : UIView

/**
 *  内容view
 */
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) AcceptOrderDetailView *orderDetailView;
@property (nonatomic, strong) OrderMapView *orderMapView;

@property (nonatomic, strong) NSString *shangmenTitle;
@property (nonatomic, strong) NSString *orderDate;
@property (nonatomic, strong) NSString *orderContent;
@property (nonatomic, strong) NSString *orderAddress;
@property (nonatomic, assign) CLLocationCoordinate2D orderLocation;

/**
 *  取消订单回调
 */
@property (nonatomic, copy) CancelOrderBlock cancelOrderBlock;



@end
