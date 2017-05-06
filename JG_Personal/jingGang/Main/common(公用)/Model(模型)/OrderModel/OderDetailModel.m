//
//  OderDetailModel.m
//  jingGang
//
//  Created by 张康健 on 15/8/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OderDetailModel.h"

@implementation OderDetailModel

-(id)initWithJSONDic:(NSDictionary *)json{
    
    self = [super initWithJSONDic:json];
    if (self) {
        NSDictionary *dicGoods = nil;
        for (NSString *key in json.allKeys) {
            if ([key isEqualToString:@"goods"]) {
                dicGoods = json[key];
                break;
            }
        }
        _canLookGoodsDelivery = NO;
        if (dicGoods) {
            GoodsDetailModel *model = [[GoodsDetailModel alloc] initWithJSONDic:dicGoods];
            self.goods = model;
        }
        
        
        //处理订单状态
        [self deallWithOrderStatus];
    }
    return self;
}

//订单状态  订单状态，0为订单取消，10为已提交待付款，15为线下付款提交申请，16为货到付款，20为已付款待发货，30为已发货待收货，40为已收货，50买家评价完毕 ,65订单不可评价，到达设定时间，系统自动关闭订单相互评价功能

- (void)deallWithOrderStatus {
    
    switch (self.orderStatus.integerValue) {
        case 0:
            _orderStatusStr = @"订单取消";
            break;
        case 10:
            _orderStatusStr = @"待付款";
            break;
        case 15:
            _orderStatusStr = @"先下付款提交申请";
            break;
        case 16:
            _orderStatusStr = @"货到付款";
            break;
        case 20:
            _orderStatusStr = @"待发货";
//            _canLookGoodsDelivery = YES;
            break;
        case 30:
            _orderStatusStr = @"待收货";
            _canLookGoodsDelivery = YES;
            break;
        case 40:
            _orderStatusStr = @"已收货";
            break;
        case 50:
            _orderStatusStr = @"已评价";
            break;
        case 65:
            _orderStatusStr = @"不可评价";
            break;
        default:
            break;
    }
    
}

@end
