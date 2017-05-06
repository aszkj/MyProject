//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "UsersCustomerUpdateResponse.h"

@interface UsersCustomerUpdateRequest : AbstractRequest
/** 
 * 昵称|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_nickname;
/** 
 * 姓名|必须
 */
@property (nonatomic, readwrite, copy) NSString *api_name;
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
 * 电子邮箱
 */
@property (nonatomic, readwrite, copy) NSString *api_email;
/** 
 * 头像路径
 */
@property (nonatomic, readwrite, copy) NSString *api_headImgPath;
/** 
 * 药物过敏史
 */
@property (nonatomic, readwrite, copy) NSString *api_allergHistory;
/** 
 * 家族药物过敏史
 */
@property (nonatomic, readwrite, copy) NSString *api_transHistory;
/** 
 * 家族遗传病史
 */
@property (nonatomic, readwrite, copy) NSString *api_transGenetic;
/** 
 * 血型
 */
@property (nonatomic, readwrite, copy) NSString *api_blood;
@end
