//
//  SubmitOrderController.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDetailModel.h"

@interface SubmitOrderController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign) NSInteger serviceId; // 服务ID
@property(nonatomic, strong) NSString *serviceName; // 服务名称
@property(nonatomic, strong) NSString *price; //单价
@property(nonatomic, assign) NSInteger maxNum; //最大数量
@property (nonatomic) ServiceDetailModel *serviceDetail;

@end
