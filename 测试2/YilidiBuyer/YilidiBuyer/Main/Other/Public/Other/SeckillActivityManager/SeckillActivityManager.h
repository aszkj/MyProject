//
//  SeckillActivityManager.h
//  YilidiBuyer
//
//  Created by yld on 16/8/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CrazySaleActivityCountDonwBlock)(long long countDonwCount);

@interface SeckillActivityManager : NSObject
/**
 *  请求首页秒杀活动信息
 */
- (void)requestHomeSeckillActivityInfo;

@property (nonatomic,copy)CrazySaleActivityCountDonwBlock crazySaleActivityCountDonwBlock;


@end
