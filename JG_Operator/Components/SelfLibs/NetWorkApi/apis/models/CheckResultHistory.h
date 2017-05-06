//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CheckResultHistory : MTLModel <MTLJSONSerializing>

	//自测套题标题
	@property (nonatomic, readonly, copy) NSString *groupTitle;
	//自测结果描述
	@property (nonatomic, readonly, copy) NSString *resultDesc;
	//自测时间
	@property (nonatomic, readonly, copy) NSDate *createTime;
	//结果描述|已过滤标签
	@property (nonatomic, readonly, copy) NSString *desc;
	
@end
