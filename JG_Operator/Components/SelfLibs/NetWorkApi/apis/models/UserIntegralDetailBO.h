//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserIntegralDetailBO : MTLModel <MTLJSONSerializing>

	//积分来源描述
	@property (nonatomic, readonly, copy) NSString *type;
	//获取积分时间
	@property (nonatomic, readonly, copy) NSDate *addtime;
	//积分数
	@property (nonatomic, readonly, copy) NSNumber *integral;
	
@end
