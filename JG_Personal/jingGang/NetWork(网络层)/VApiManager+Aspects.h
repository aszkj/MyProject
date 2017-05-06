//
//  VApiManager+Aspects.h
//  jingGang
//
//  Created by ray on 15/11/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "VApiManager.h"
@interface VApiManager (Aspects) <UIAlertViewDelegate>

+ (void)handleNeedTokenError;

@end
