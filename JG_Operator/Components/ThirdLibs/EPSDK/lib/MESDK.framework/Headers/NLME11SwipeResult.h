//
//  NLME11SwipeResult.h
//  MTypeSDK
//
//  Created by su on 14/10/13.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import "NLSwipeResult.h"

@interface NLME11SwipeResult : NLSwipeResult
/**
 * 返回当前调用的读卡模式
 *
 * @since ver1.0
 * @return
 */
@property (nonatomic, copy) NSArray *moduleTypes;
/**
 * 返回卡号
 *
 * @since ver1.0
 * @return
 */
@property (nonatomic, copy) NSString *acctId;
@end
