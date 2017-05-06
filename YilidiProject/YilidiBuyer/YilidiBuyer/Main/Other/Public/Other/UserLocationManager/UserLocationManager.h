//
//  UserLocationManager.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/7/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduLocationManage.h"

@class CommunityModel;
typedef void(^UserLocationCommunityChangeBlcok)(CommunityModel *locatedCommunityModel);
@interface UserLocationManager : NSObject

+ (instancetype)sharedManager;

-(void)startUserLocationBackBlock:(BaiduLocationBlock)baiduLocationBlock
                   errorBlock:(BaiduLocationErrorBlock)errorblock;

@property (nonatomic, assign)BOOL enterHomePage;

@property (nonatomic, assign)BOOL leaveHomePage;

@property (nonatomic, assign)BOOL userSwitchedCommuntiByHand;

@property (nonatomic, copy)UserLocationCommunityChangeBlcok userLocationCommunityChangeBlcok;



@end
