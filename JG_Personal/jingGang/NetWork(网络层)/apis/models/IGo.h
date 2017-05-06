//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface IGo : MTLModel <MTLJSONSerializing>

	//图片
	@property (nonatomic, readonly, copy) NSString *images;
	//名称
	@property (nonatomic, readonly, copy) NSString *igoName;
	//积分
	@property (nonatomic, readonly, copy) NSNumber *igoInteral;
	//数量
	@property (nonatomic, readonly, copy) NSNumber *count;
	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	
@end
