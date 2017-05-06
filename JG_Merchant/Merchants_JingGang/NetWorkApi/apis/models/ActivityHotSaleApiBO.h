//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ActivityHotSaleApiBO : MTLModel <MTLJSONSerializing>

	//促销活动id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//促销活动名称
	@property (nonatomic, readonly, copy) NSString *hotName;
	//促销活动首页图片
	@property (nonatomic, readonly, copy) NSString *firstImage;
	//促销活动头部图片
	@property (nonatomic, readonly, copy) NSString *headImage;
	//促销活动底部图片
	@property (nonatomic, readonly, copy) NSString *footImage;
	//活动代码
	@property (nonatomic, readonly, copy) NSString *vcode;
	//活动开始时间
	@property (nonatomic, readonly, copy) NSDate *startTime;
	//活动结束时间
	@property (nonatomic, readonly, copy) NSDate *endTime;
	
@end
