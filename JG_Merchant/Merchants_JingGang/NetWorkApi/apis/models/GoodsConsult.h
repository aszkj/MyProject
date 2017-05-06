//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GoodsConsult : MTLModel <MTLJSONSerializing>

	//id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//咨询时间
	@property (nonatomic, readonly, copy) NSDate *addTime;
	//咨询用户id
	@property (nonatomic, readonly, copy) NSNumber *consultUserId;
	//咨询用户名
	@property (nonatomic, readonly, copy) NSString *consultUserName;
	//回复时间
	@property (nonatomic, readonly, copy) NSDate *replyTime;
	//回复用户名
	@property (nonatomic, readonly, copy) NSString *replyUserName;
	//满意数
	@property (nonatomic, readonly, copy) NSNumber *satisfy;
	//店铺名称 
	@property (nonatomic, readonly, copy) NSString *storeName;
	//不满意数量
	@property (nonatomic, readonly, copy) NSNumber *unsatisfy;
	//是否为自营商品咨询 0为第三方 1为自营
	@property (nonatomic, readonly, copy) NSNumber *whetherSelf;
	//咨询内容 
	@property (nonatomic, readonly, copy) NSString *consultContent;
	//回复内容 
	@property (nonatomic, readonly, copy) NSString *consultReply;
	//商品信息
	@property (nonatomic, readonly, copy) NSString *goodsInfo;
	
@end
