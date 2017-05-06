//
//  DLOrderProcessView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/27.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,OrderProcessStatus) {
    PlaceAnOrderStatus = 0,
    PaymentStatus,
    DistributionStatus,
    FinishStatus
};


@interface DLOrderProcessView : UIView

@property(nonatomic,assign) NSInteger count;

@property(nonatomic,assign) CGFloat lineGap;

@property(nonatomic,assign) OrderProcessStatus orderStatus;

@end
