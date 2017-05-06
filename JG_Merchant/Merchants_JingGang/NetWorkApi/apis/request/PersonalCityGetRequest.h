//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalCityGetResponse.h"

@interface PersonalCityGetRequest : AbstractRequest
/** 
 * 城市名称
 */
@property (nonatomic, readwrite, copy) NSString *api_cityName;
@end
