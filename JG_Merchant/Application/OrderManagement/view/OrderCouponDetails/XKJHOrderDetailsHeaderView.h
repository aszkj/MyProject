//
//  XKJHOrderDetailsHeaderView.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHOrderDetailsHeaderView : UIView

//订单号
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//下单时间
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
//消费者名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//手机号码
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
