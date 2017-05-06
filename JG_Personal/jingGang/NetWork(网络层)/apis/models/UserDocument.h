//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface UserDocument : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//标识|papphelp个人，mapphelp商户，oapphelp营运商
	@property (nonatomic, readonly, copy) NSString *mark;
	//标题
	@property (nonatomic, readonly, copy) NSString *title;
	//内容
	@property (nonatomic, readonly, copy) NSString *content;
	//HTML页面内容
	@property (nonatomic, readonly, copy) NSString *htmlContent;
	
@end
