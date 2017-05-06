//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface OpNotices : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//添加时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//公告状态,0为待审核，1为审核通过,-1未审核失败
	@property (nonatomic, readonly, copy) NSNumber *ntStatus;
	//公告标题
	@property (nonatomic, readonly, copy) NSString *ntTitle;
	//公告内容
	@property (nonatomic, readonly, copy) NSString *ntContent;
	//运营商 
	@property (nonatomic, readonly, copy) NSString *operatorName;
	
@end
