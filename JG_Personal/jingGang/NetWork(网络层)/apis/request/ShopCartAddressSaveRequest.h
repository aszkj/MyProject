//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "ShopCartAddressSaveResponse.h"

@interface ShopCartAddressSaveRequest : AbstractRequest
/** 
 * 地址id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * true为默认地址
 */
@property (nonatomic, readwrite, copy) NSNumber *api_defaultValue;
/** 
 * 收货人姓名
 */
@property (nonatomic, readwrite, copy) NSString *api_trueName;
/** 
 * 收货人电话
 */
@property (nonatomic, readwrite, copy) NSString *api_telephone;
/** 
 * 收货人手机
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 地区
 */
@property (nonatomic, readwrite, copy) NSNumber *api_areaId;
/** 
 * 街道地址
 */
@property (nonatomic, readwrite, copy) NSString *api_areaInfo;
/** 
 * 邮编
 */
@property (nonatomic, readwrite, copy) NSString *api_zip;
@end
