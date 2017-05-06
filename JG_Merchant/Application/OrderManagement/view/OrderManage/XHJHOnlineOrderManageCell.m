//
//  XHJHOnlineOrderManageCell.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XHJHOnlineOrderManageCell.h"
#import "XKJHOrderCouponDetailsViewController.h"
#import "UIView+firstResponseController.h"
#import "XKJHTheDetailController.h"

@implementation XHJHOnlineOrderManageCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.customerNameLabel.text = self.groupOrderModel.nickName;
    self.phoneNumberLabel.text = self.groupOrderModel.mobile;
    self.addTimeLabel.text = [NSString stringWithFormat:@"%@",self.groupOrderModel.addTime];
    self.orderNumberLabel.text = self.groupOrderModel.orderId;
    self.addTimeLabel.text = self.groupOrderModel.dateStr;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.groupOrderModel.totalPrice.floatValue];
 
    self.consumeStatusLabel.text = self.groupOrderModel.orderStatusStr;
    self.friendQuanlabel.text = [NSString stringWithFormat:@"%@",self.groupOrderModel.groupService.goodsName];
    self.countLabel.text = [NSString stringWithFormat:@"X%@",self.groupOrderModel.groupService.goodsCount];
    
}


- (IBAction)comtoQuanDetailPageAction:(id)sender {
    DDLogVerbose(@"进入券详情页, 订单id %@",self.groupOrderModel.apiId);
    XKJHOrderCouponDetailsViewController *orderDetailVC = [[XKJHOrderCouponDetailsViewController alloc] init];
    orderDetailVC.api_orderId = self.groupOrderModel.apiId;
    [self.firstResponseController.navigationController pushViewController:orderDetailVC animated:YES];
}

@end
