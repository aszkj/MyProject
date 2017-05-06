//
//  CommunityModel.h
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CommunityBaseModel.h"
#import "StoreModel.h"
@interface CommunityModel : CommunityBaseModel
/**
 *  当前小区店铺，目前一个小区只有一个店铺
 */
@property (nonatomic,strong)StoreModel *communityStore;

/**
 *  小区当前地区名称
 */
@property (nonatomic,copy)NSString *countyName;


@end
