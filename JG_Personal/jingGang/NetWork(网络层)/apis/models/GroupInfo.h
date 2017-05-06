//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Mantle.h"

@interface GroupInfo : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//消息码
	@property (nonatomic, readonly, copy) NSString *groupSn;
	//退款说明 
	@property (nonatomic, readonly, copy) NSString *refundReasion;
	//团购信息状态，默认为0，,使用后为1,-1为过期,3申请退款、5退款中、7退款完成
	@property (nonatomic, readonly, copy) NSNumber *status;
	
@end
