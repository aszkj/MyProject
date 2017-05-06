//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "PGroupGoods.h"
#import "InformationBO.h"
#import "ShopStore.h"
#import "Goods.h"
#import "CircleInvitation.h"
#import "PStoreInfo.h"

@interface PositionAdvertBO : MTLModel <MTLJSONSerializing>

	//推荐id
	@property (nonatomic, readonly, copy) NSString *itemId;
	//广告描述
	@property (nonatomic, readonly, copy) NSString *adText;
	//广告标题
	@property (nonatomic, readonly, copy) NSString *adTitle;
	//广告链接
	@property (nonatomic, readonly, copy) NSString *adUrl;
	//1:帖子（链接），2商品，3商户，4资讯（静港项目）（链接）5服务商户 6服务
	@property (nonatomic, readonly, copy) NSString *adType;
	//广告图片
	@property (nonatomic, readonly, copy) NSString *adImgPath;
	//查询时间戳
	@property (nonatomic, readonly, copy) NSString *timeStamp;
	//附加信息－帖子信息
	@property (nonatomic, readonly, copy) CircleInvitation *invitation;
	//附加信息－静港项目信息
	@property (nonatomic, readonly, copy) InformationBO *information;
	//附加信息－商城商品信息
	@property (nonatomic, readonly, copy) Goods *shopGoods;
	//附加信息－商城商家信息
	@property (nonatomic, readonly, copy) ShopStore *shopStore;
	//附加信息－商户服务信息
	@property (nonatomic, readonly, copy) PGroupGoods *pGroupGoods;
	//附加信息－商户信息
	@property (nonatomic, readonly, copy) PStoreInfo *pStoreInfo;
	//广告显示类型(1:Html5页面,2:原生页面)
	@property (nonatomic, readonly, copy) NSNumber *nativeType;
	
@end
