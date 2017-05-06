//
//  JGOrderDetailHeaderView.m
//  jingGang
//
//  Created by dengxf on 15/12/26.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGOrderDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "POrderDetails.h"



@implementation JGOrderDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconGesture)];
    }
    return self;
}

- (void)tapIconGesture {
    if (self.tapImageGestureBlock) {
        self.tapImageGestureBlock();
    }
}

- (NSString *)deatilOrderType:(NSNumber *)orderState {
    NSString *resultOrderState;
    switch ([orderState integerValue]) {
        case 0:
            resultOrderState = @"订单取消";
            break;
        case 10:
            resultOrderState = @"待付款";
            break;
        case 20:
            resultOrderState = @"已付款";
            break;
        case 30:
            resultOrderState = @"买家已使用";
            break;
        case 50:
            resultOrderState = @"买家评价完毕";
            break;
        case 60:
            resultOrderState = @"已完成";
            break;
        case 65:
            resultOrderState = @"订单不可评价";
            break;
        default:
            break;
    }
    return resultOrderState;
}


- (IBAction)comintoServiceDetailAction:(id)sender {
    
    if (self.tapintoServiceDetailBlock) {
        self.tapintoServiceDetailBlock();
    }
}

- (void)setOrderDetail:(POrderDetails *)orderDetail {
    _orderDetail = orderDetail;
    NSString * orderStatus = [self deatilOrderType:orderDetail.orderStatus];
    if ([orderStatus integerValue] == 10) {
        // 代付款
        self.payMoneyButton.hidden = NO;
        self.spaceTextTopConstraint.constant = 46;
    }else {
        self.payMoneyButton.hidden = YES;
        self.spaceTextTopConstraint.constant = 0;
    }
    
    NSArray *details = [NSArray arrayWithArray:orderDetail.serviceList];
    if (details.count) {
        NSDictionary *dic = details[0];
        NSString *urlString = TNSString(dic[@"groupAccPath"]);
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"logoeee"] options:SDWebImageRefreshCached];
        self.shopNameLab.text =  [NSString stringWithFormat:@"%@     %ld份",TNSString(dic[@"groupName"]),details.count];
        CGFloat price = 0;
        for (NSDictionary *tempDic in details) {
            NSString *totalPrice = TNSString(tempDic[@"totalPrice"]);
            price += [totalPrice floatValue];
        }
        self.priceLab.text = [NSString stringWithFormat:@"￥ %.2f",price];
    }
    
    self.endTimeLab.text = [NSString stringWithFormat:@"有效期: %@",TNSString(orderDetail.endTime)];
}

- (void)stControlWidgetWithStatus:(NSInteger)status {
    if (status == 20) {
        //
        self.qrcodeTextLab.hidden = NO;
        self.consumeCodeLab.hidden = NO;
        self.endTimeLab.hidden = NO;
    }else {
        self.qrcodeTextLab.hidden = YES;
        self.consumeCodeLab.hidden = YES;
        self.endTimeLab.hidden = YES;
    }
}

- (IBAction)payForMoneyAction:(id)sender {
    
    
}
@end
