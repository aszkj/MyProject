//
//  DLHomeFloorBaseInfoModel.h
//  YilidiBuyer
//
//  Created by yld on 16/9/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLHomeFloorBaseInfoModel : BaseModel

@property (nonatomic,copy)NSString *floorId;

@property (nonatomic,copy)NSString *floorName;

/**
 *  点击楼层更多跳转类型，
 1:商品分类
 2:H5页面
 3:楼层商品
 */
@property (nonatomic,strong)NSNumber *floorLinkTypeNumber;

/**
 *  楼层关键链接数据以key=value形式传递，多个以&连接
 1：classCode
 2：h5PageType值见3.35接口请求参数值typeCode
 3：floorId
 */
@property (nonatomic,copy)NSString *floorLinkData;

/**
 *  楼层小图标
 */
@property (nonatomic,copy)NSString *floorIconImageUrl;

@property (nonatomic,copy)NSArray *floorProductList;


@end
