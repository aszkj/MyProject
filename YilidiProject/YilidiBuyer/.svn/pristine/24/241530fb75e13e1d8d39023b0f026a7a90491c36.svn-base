//
//  CommunityDataManager.h
//  YilidiBuyer
//
//  Created by yld on 16/6/11.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityModel.h"
#import "ProjectRelativEmerator.h"

@interface CommunityDataManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,strong)CommunityModel *communityModel;

@property (nonatomic,strong)StoreModel *currentStore;
/**
 *  店铺配送方式送货上门、门店自提
 */
@property (nonatomic,assign)SelectShipWay selectedShipWay;

/**
 *  有没有定位或者选择过小区
 */
@property (nonatomic,assign)BOOL hasLocatedOrSelectedCommunity;


@end
