//
//  NLPicLine.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLPicture.h"

@class NLPoint;
@class NLColor;
/*!
 @class
 @abstract 线对象
 @discuss
 */
@interface NLPicLine : NSObject <NLPicture>
@property (nonatomic, strong) NLPoint *startPoint; // 起始点
@property (nonatomic, strong) NLPoint *endPoint; // 终结点
@property (nonatomic, strong) NLColor *color; // 颜色
- (id)initWithStartPoint:(NLPoint*)startPoint endPoint:(NLPoint*)endPoint color:(NLColor*)color;
@end
