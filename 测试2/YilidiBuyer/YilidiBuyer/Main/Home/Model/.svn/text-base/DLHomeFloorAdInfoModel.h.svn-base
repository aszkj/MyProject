//
//  DLHomeFloorAdInfoModel.h
//  YilidiBuyer
//
//  Created by yld on 16/9/3.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLHomeFloorAdInfoModel : BaseModel

@property (nonatomic,copy)NSString *floorAdtitle;
/**
 *  楼层广告跳转类型
 0:没有链接
 1:商品分类
 2:H5页面
 3:首页分类专区页面（废弃）
 4:专题
 5:活动
 6:商品详情页
 7:网站资讯、公告
 */
@property (nonatomic,strong)NSNumber *floorAdLinkTypeNumber;
/**
 *  楼层广告关键链接数据以key=value形式传递，多个以&连接
 0：
 1：classCode
 2：h5PageType值见3.35接口请求参数值typeCode
 3：zoneCode（废弃）
 4：themeType
 5：activityType
 6：barCode
 7：linkUrl
 */
@property (nonatomic,copy)NSString *floorAdLinkData;


@property (nonatomic,copy)NSString *floorAdImageUrl;


@end
