//
//  WIntegralDeleteTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralGoodsDetails.h"

@interface WIntegralDeleteTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^changeShopCount)(void);

@property (nonatomic, copy) IntegralGoodsDetails *dataCell;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^deleteCell)(NSIndexPath * index);

@end
