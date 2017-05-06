//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface PayCartLineDetails : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//用户昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//手机号码
	@property (nonatomic, readonly, copy) NSString *mobile;
	
@end
