//
//  SeckillActivitySceneView.h
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillActivityPerSceneView.h"

typedef void(^SwitchActivityBlock)(NSInteger newActivityIndex);
@interface SeckillActivitySceneView : UIView

@property (nonatomic,copy)NSArray *secKillActivitys;

@property (nonatomic,assign)NSInteger currentActivityIndex;

@property (nonatomic,copy)SwitchActivityBlock switchActivityBlock;

-(void)refreshActivityWithNewActivityModel:(SeckillActivityModel *)newActivityModel
                                  atIndex:(NSInteger)activityIndex;

@end
