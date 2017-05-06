//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface IntegralListBO : MTLModel <MTLJSONSerializing>

	//商品id
	@property (nonatomic,  copy) NSNumber *apiId;
	//礼品兑换积分
	@property (nonatomic,  copy) NSNumber *igGoodsIntegral;
	//礼品名称
	@property (nonatomic,  copy) NSString *igGoodsName;
	//礼品图片
	@property (nonatomic,  copy) NSString *igGoodsImg;
	
@end
