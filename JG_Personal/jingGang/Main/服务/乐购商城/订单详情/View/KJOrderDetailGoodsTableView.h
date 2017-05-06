//
//  KJOrderDetailGoodsTableView.h
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OderDetailModel.h"
typedef void(^ClickOrderDetailBlock)(NSIndexPath *indexPath,NSNumber *goodsId);
@interface KJOrderDetailGoodsTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSArray *orderListArr;
@property (nonatomic, strong)OderDetailModel *orderDetailModel;
@property (nonatomic, copy)NSString *payWay;
@property (nonatomic, copy)ClickOrderDetailBlock clickOrderDetailBlock;

@end
