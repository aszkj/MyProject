//
//  AppInitRequest.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "IRequest.h"
#import "PersonalPayPageResponse.h"

@interface PersonalPayPageRequest : AbstractRequest
/** 
 * id
 */
@property (nonatomic, readwrite, copy) NSNumber *api_id;
/** 
 * count
 */
@property (nonatomic, readwrite, copy) NSNumber *api_count;
@end
