//
//  NLWaiterObject.h
//  MTypeSDK
//
//  Created by su on 14-5-12.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NLWaiter <NSObject>
@property (atomic, assign) BOOL isWaiting;
- (void)wait;
- (void)invoke;
@end

@interface NLWaiterObject : NSObject<NLWaiter>
{
    BOOL _isWaiting;
}
@end


@interface NLRunLoopWaiter : NSObject<NLWaiter>
{
    BOOL _isWaiting;
}
- (void)wait:(NSTimeInterval)timeout;
@end