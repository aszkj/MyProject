//
//  WSJShoppingCartModel.h
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

//购物车数据模型
#import <Foundation/Foundation.h>
#import "WSJShoppingCartInfoModel.h"

@interface WSJShoppingCartModel : NSObject
//店铺id
@property (nonatomic, strong) NSNumber *goodsStoreId;
//是否全选该段商品
@property (nonatomic, assign) BOOL isAll;
//编辑状态
@property (nonatomic, assign) BOOL edit;
//该店铺名称
@property (nonatomic, strong) NSString *name;
//该店铺的logo |  0为自营商品 jinzhu，1为第三方经销商 guanfang
@property (nonatomic, assign) BOOL goodsType;
//该段店铺，所有商品信息 ：里面数据是WSJShoppingCartInfoModel
@property (nonatomic, strong) NSMutableArray *data;

- (void) setNoSelect;


@end
