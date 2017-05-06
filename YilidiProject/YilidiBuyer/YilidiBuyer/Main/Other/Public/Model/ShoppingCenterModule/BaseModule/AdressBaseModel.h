//
//  DLAdressListModel.h
//  YilidiBuyer
//
//  Created by yld on 16/4/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface AdressBaseModel : BaseModel
/**
 *  收货地址id
 */
@property (nonatomic,copy)NSString *consigneAdressId;
/**
 *  收货地址userId
 */
@property (nonatomic,copy)NSString *consigneUserId;
/**
 *  收货人姓名
 */
@property (nonatomic,copy)NSString *consigneePersonName;
/**
 *  收货人电话
 */
@property (nonatomic,copy)NSString *consigneePersonPhoneNumber;
/**
 *  收货人性别 0-女，1-男
 */
@property (nonatomic,strong)NSNumber *consigneenPersonGender;
/**
 *  收货人地址
 */
@property (nonatomic,copy)NSString *consigneePersonAdress;
/**
 *收货人详细地址
 */
@property (nonatomic,copy)NSString *consigneePersonalDetailAdress;
/**
 * 门牌号
 */
@property (nonatomic,copy)NSString *consigneeHouseNo;
/**
 *  省code
 */
@property (nonatomic,copy)NSString *provinceCode;
/**
 *  市code
 */
@property (nonatomic,copy)NSString *cityCode;
/**
 *  区code
 */
@property (nonatomic,copy)NSString *townShipCode;
/**
 *  城市名
 */
@property (nonatomic,copy)NSString *cityName;
/**
 *  省名
 */
@property (nonatomic,copy)NSString *provinceName;
/**
 *  区名
 */
@property (nonatomic,copy)NSString *townName;

/**
 *  是否默认收货地址
 */
@property (nonatomic,strong)NSNumber* isDefaultConsigneeAdress;

@end
