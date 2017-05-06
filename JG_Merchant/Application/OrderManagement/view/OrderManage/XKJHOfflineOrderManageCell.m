//
//  XKJHOfflineOrderManageCell.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOfflineOrderManageCell.h"
#import "VApiManager.h"
#import "UIView+firstResponseController.h"


@interface XKJHOfflineOrderManageCell()<UIAlertViewDelegate> {

    VApiManager *_vapManager;

}

@end

@implementation XKJHOfflineOrderManageCell

- (void)awakeFromNib {
    // Initialization code
    _vapManager = [[VApiManager alloc] init];
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.customerNameLabel.text = self.groupOffOrderModel.displayName;
    self.phoneNumberLabel.text = self.groupOffOrderModel.mobile;
    self.addTimeLabel.text = [NSString stringWithFormat:@"%@",self.groupOffOrderModel.addTime];
    self.addTimeLabel.text = self.groupOffOrderModel.dateStr;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.groupOffOrderModel.totalPrice.floatValue];
    self.consumeStatusLabel.text = self.groupOffOrderModel.offLineOrderStatusStr;
    self.friendQuanlabel.text = [NSString stringWithFormat:@"%@",self.groupOffOrderModel.groupService.goodsName];
    self.serviceLabel.text = self.groupOffOrderModel.localGroupName;
    self.refundButton.enabled = !self.groupOffOrderModel.hasReturnedMoney;
    if (self.refundButton.enabled) {
        self.refundButton.backgroundColor = [UIColor whiteColor];
    }else {
        self.refundButton.backgroundColor = kGetColor(161, 48, 37);
    }
}


- (IBAction)refunAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退款" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    [self.firstResponseController.view addSubview:alert];
    [alert show];
}


#pragma mark - 线下退款请求
-(void)_offLineRefundRequest {

    GroupOrderRefundSaveRequest *request = [[GroupOrderRefundSaveRequest alloc] init:GetToken];
    request.api_orderId = self.groupOffOrderModel.apiId;
    
    [_vapManager groupOrderRefundSave:request success:^(AFHTTPRequestOperation *operation, GroupOrderRefundSaveResponse *response) {
        if (!response.errorCode) {
            self.groupOffOrderModel.localReturnStatus = @2;
            [self setNeedsLayout];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {//确定
        [self _offLineRefundRequest];
    }
}



@end
