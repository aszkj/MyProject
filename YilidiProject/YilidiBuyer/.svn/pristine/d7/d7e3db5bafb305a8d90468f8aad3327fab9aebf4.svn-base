//
//  DLOrderListCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
#import "ProjectRelativeConst.h"

#define kGoodsViewHeight (kScreenWidth - 42)/4
#define orderListCellHeight   (kGoodsViewHeight + 95)
@interface DLOrderListCell : UITableViewCell

@property (nonatomic,strong)OrderListModel *orderListModel;

@property (nonatomic,copy)OneceOrderAgainBlock oneceOrderAgainBlock;

@property (nonatomic,copy)ConfiureRecieveGoodsBlock confiureRecieveGoodsBlock;

@property (nonatomic,copy)CancelOrderGoodsBlock cancelOrderGoodsBlock;

@property (nonatomic,copy)GotoPayBlock gotoPayBlock;

@property (nonatomic,copy)GotoCommentBlock gotoCommentBlock;

@property (nonatomic,copy)GotoLookOrderDetailBlock gotoLookOrderDetailBlock;

- (void)configureViewRelatedOrderStatusWithOrderListModel:(OrderListModel *)orderListModel;

@end
