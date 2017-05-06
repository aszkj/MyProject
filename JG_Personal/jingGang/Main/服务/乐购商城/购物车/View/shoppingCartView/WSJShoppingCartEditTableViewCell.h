//
//  WSJShoppingCartEditTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSJShoppingCartInfoModel.h"

@interface WSJShoppingCartEditTableViewCell : UITableViewCell

@property (nonatomic, copy) NSIndexPath *indexPath;
//赋值数据
- (void) willCellWith:(WSJShoppingCartInfoModel *)model;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
/**
 *  选中某个商品
 */
@property (nonatomic, copy) void (^selectShopping)(NSString *ID,BOOL b);
/**
 *  删除某个商品
 */
@property (nonatomic, copy) void (^deleteCell)(NSIndexPath * index);
/**
 *  修改商品数量
 */
@property (nonatomic, copy) void (^changeCount)(NSInteger count,NSNumber *apiId);

@end
