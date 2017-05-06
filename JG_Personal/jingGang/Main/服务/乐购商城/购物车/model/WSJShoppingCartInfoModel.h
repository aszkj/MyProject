//
//  WSJShoppingCartInfoModel.h
//  jingGang
//
//  Created by thinker on 15/8/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSJShoppingCartInfoModel : NSObject

//商品id
@property (nonatomic, copy  ) NSNumber *ID;

//是否选中
@property (nonatomic, assign) BOOL     isSelect;
//商品图片
@property (nonatomic, copy  ) NSString *imageURL;
//商品名称
@property (nonatomic, copy  ) NSString *name;
//商品规格
@property (nonatomic, copy  ) NSString *specInfo;
//商品当前价格
@property (nonatomic, copy  ) NSNumber *goodsCurrentPrice;
//是否是手机专享价
@property (nonatomic, copy  ) NSNumber *hasMobilePrice;
//商品数量
@property (nonatomic, copy  ) NSNumber *count;
//商品总数
@property (nonatomic, copy  ) NSNumber *goodsInventory;

//商品所有数据
@property (nonatomic, copy  ) NSDictionary *data;

@end
