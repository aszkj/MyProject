//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface GroupEvaluates : MTLModel <MTLJSONSerializing>

	//被评价订单
	@property (nonatomic, readonly, copy) NSNumber *orderId;
	//客户评价内容
	@property (nonatomic, readonly, copy) NSString *content;
	//商户回复内容
	@property (nonatomic, readonly, copy) NSString *replyContent;
	//评价图片，以';'分隔，最多六张
	@property (nonatomic, readonly, copy) NSString *photoUrls;
	//客户评价时间 
	@property (nonatomic, readonly, copy) NSDate *evaluateTime;
	//商户回复时间 
	@property (nonatomic, readonly, copy) NSDate *replyTime;
	//评价状态(1:图片上传/尚未评价 2:客户已评价  3:商户已评价/评价完成)
	@property (nonatomic, readonly, copy) NSNumber *status;
	//服务名称
	@property (nonatomic, readonly, copy) NSString *goodsName;
	//评论者昵称
	@property (nonatomic, readonly, copy) NSString *nickName;
	//用户头像
	@property (nonatomic, readonly, copy) NSString *avatarUrl;
	//评分：1~5
	@property (nonatomic, readonly, copy) NSNumber *score;
	
@end
