//
//  DLSelectCouponView.h
//  YilidiBuyer
//
//  Created by mm on 16/11/21.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectRelativEmerator.h"
#import "ViewStateEmerater.h"

typedef void(^CloseSelectCouponBlock)(NSArray *selectCoupons,BOOL useTicket);
typedef void(^MarkUserMadeChoiceBlock)(BOOL userMadeChoice);

@interface DLSelectCouponView : UIView

- (void)setCoupons:(NSArray *)coupons;

- (void)setPledgeTickets:(NSArray *)pledgeTickets;

- (void)showAvaliableTicketsWithTicketType:(SelectTicketType)selectTicketType;

@property (nonatomic,assign)BOOL needResetOtherTypeSelectTicket;

@property (nonatomic,assign)BOOL willShowTicketUseTicket;

/**
 是否支持多选
 */
@property (nonatomic,assign)NSInteger isTicketSingleSelection;

@property (nonatomic,copy)CloseSelectCouponBlock closeSelectCouponBlock;

/**
 标志用户有没做出选择，从第一次进来系统自动选择之后
 */
@property (nonatomic,copy)MarkUserMadeChoiceBlock userMadeChoiceBlock;

@end
