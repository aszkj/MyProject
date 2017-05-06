//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface InformationBO : MTLModel <MTLJSONSerializing>

	//文章id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//添加时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//文章标题
	@property (nonatomic, readonly, copy) NSString *title;
	//文章内容
	@property (nonatomic, readonly, copy) NSString *article;
	
@end
