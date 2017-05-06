//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserConsultingListBO : MTLModel <MTLJSONSerializing>

	//专家咨询,专家信息
	@property (nonatomic, readonly, copy) UserExperts *userExperts;
	//专家咨询最后回复时间
	@property (nonatomic, readonly, copy) NSDate *apiNewRepayTime;
	//提问标题
	@property (nonatomic, readonly, copy) NSString *title;
	//提问Id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	
@end
