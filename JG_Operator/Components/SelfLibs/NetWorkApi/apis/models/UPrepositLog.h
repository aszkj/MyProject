//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UPrepositLog : MTLModel <MTLJSONSerializing>

	//提现时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//提现金额
	@property (nonatomic, readonly, copy) NSNumber *cashAmount;
	//提现状态 0为审核中，1为已经完成
	@property (nonatomic, readonly, copy) NSNumber *cashStatus;
	
@end
