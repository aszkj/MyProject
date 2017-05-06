//
//  MJRefreshHeader+TriggerAutomaticallyRefresh.h
//  weimi
//
//  Created by ray on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MJRefreshHeader (TriggerAutomaticallyRefresh)


@property (assign, nonatomic) BOOL needAutomaticallyRefresh;
/** 当距离多少时就自动刷新(默认为0.0，在顶部才会自动刷新) */
@property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshTop;

@end
