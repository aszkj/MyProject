//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UserCustomerSavefirstResponse.h"

@interface UserCustomerSavefirstRequest : AbstractRequest
/** 
 * 身高|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_height;
/** 
 * 体重|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_weight;
/** 
 * 性别|1，男 2，女|必须
 */
@property (nonatomic, readwrite, copy) NSNumber *api_sex;
/** 
 * 手机|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_mobile;
/** 
 * 生日|格式：yyyy-MM-dd
 */
@property (nonatomic, readwrite, copy) NSString *api_birthDate;
/** 
 * 城市名(下拉框选择)
 */
@property (nonatomic, readwrite, copy) NSString *api_paddress;
/** 
 * 县区名(下拉框选择)
 */
@property (nonatomic, readwrite, copy) NSString *api_address;
/** 
 * 用户id
 */
@property (nonatomic, readwrite, copy) NSString *api_uid;
/** 
 * 邀请人推荐码
 */
@property (nonatomic, readwrite, copy) NSString *api_invitationCode;
@end
