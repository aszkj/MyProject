//
//  CommunityBaseModel.h
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface CommunityBaseModel : BaseModel
/**
 *  小区id
 */
@property (nonatomic,copy)NSString *communityId;

/**
 *  小区名称
 */
@property (nonatomic,copy)NSString *communityName;

/**
 *  小区详细地址
 */
@property (nonatomic,copy)NSString *communityAdressDetail;

/**
 *  城市名称
 */
@property (nonatomic,copy)NSString *cityName;

/**
 *  省编码
 */
@property (nonatomic,copy)NSString *provinceCode;

/**
 *  城市编码
 */
@property (nonatomic,copy)NSString *cityCode;

/**
 *  区编码
 */
@property (nonatomic,copy)NSString *countyCode;
/**
 *  省名
 */
@property (nonatomic,copy)NSString *provinceName;
/**
 *  区名
 */
@property (nonatomic,copy)NSString *townName;




@end
