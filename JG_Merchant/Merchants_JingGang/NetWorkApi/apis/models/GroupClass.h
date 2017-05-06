//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GroupClass : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//类目名称
	@property (nonatomic, readonly, copy) NSString *gcName;
	//图标
	@property (nonatomic, readonly, copy) NSString *mobileIcon;
	
@end
