//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Pservice : MTLModel <MTLJSONSerializing>

	//服务图片
	@property (nonatomic, readonly, copy) NSString *groupAccPath;
	//服务Id
	@property (nonatomic, readonly, copy) NSNumber *groupId;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *groupName;
	//服务价格
	@property (nonatomic, readonly, copy) NSNumber *totalPrice;
	//消费码
	@property (nonatomic, readonly, copy) NSString *groupSn;
	//默认为0，使用后为1，过期为-1，审核中为3，审核通过为5，审核不通过为6，退款完成为7
	@property (nonatomic, readonly, copy) NSNumber *status;
	
@end
