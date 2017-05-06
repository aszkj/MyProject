//
//  PersonalOrderlineModel.h
//  jingGang
//
//  Created by dengxf on 15/11/11.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface PersonalOrderlineModel : NSObject
/**
 *  id                  Long	id
    status              Integer	状态|默认为0，使用后为1，过期为-1，审核中为3，审核通过为5，审核不通过为6，退款完成为7
    storeName           String	店铺名称
    localGroupName      String	线下服务名称
    totalPrice          NSNumber	订单总价格
    orderStatus         Integer	订单状态 订单状态，0为订单取消，10为已提交待付款，20为已付款，30为买家已使用，全部使用后更新该值,50买家评价完毕 ,65订单不可评价，到达设定时间，系统自动关闭订单相互评价功能
    localReturnStatus	Integer	线下服务退款状态|1为未退款 2为已退款
    userNickname        String	用户昵称,非会员的就显示手机号码
    mobile              String  手机号码
    orderId             String	订单号
    addTime             Date    下单时间
 */
@property (assign, nonatomic) long idType;

@property (assign, nonatomic) NSInteger status;

@property (copy, nonatomic) NSString *storeName;

@property (copy, nonatomic) NSString *localGroupName;

@property (assign, nonatomic) double totalPrice;

@property (assign, nonatomic) NSInteger orderStatus;

@property (assign, nonatomic) NSInteger localReturnStatus;

@property (copy, nonatomic) NSString *userNickname;

@property (copy, nonatomic) NSString *mobile;

@property (copy , nonatomic) NSString *orderId;

@property (strong,nonatomic) NSDate *addTime;




@end
