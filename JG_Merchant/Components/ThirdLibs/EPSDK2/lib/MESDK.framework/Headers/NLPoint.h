//
//  NLPoint.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class 
 @abstract 2d坐标/点描述
 */
@interface NLPoint : NSObject
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
- (id)initWithX:(int)x y:(int)y;
@end
