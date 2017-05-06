//
//  Role.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "GoodsCase.h"

@interface GoodsCase : MTLModel <MTLJSONSerializing>

	//橱窗id
	@property (nonatomic, readonly, copy) NSNumber *apiId;
	//橱窗名称
	@property (nonatomic, readonly, copy) NSString *caseName;
	//商品二级分类
	@property (nonatomic, readonly, copy) NSArray *classList;
	
@end
