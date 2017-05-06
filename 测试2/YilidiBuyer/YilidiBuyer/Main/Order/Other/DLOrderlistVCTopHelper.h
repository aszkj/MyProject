//
//  DLOrderlistVCTopHelper.h
//  YilidiSeller
//
//  Created by yld on 16/3/28.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "BaseTopbarTypeHelper.h"

@class DLOrderListVC;
@interface DLOrderlistVCTopHelper : BaseTopbarTypeHelper

//这里不能强持有，，否则会有循环引用
@property (nonatomic,weak)DLOrderListVC *orderListVC;

@end
