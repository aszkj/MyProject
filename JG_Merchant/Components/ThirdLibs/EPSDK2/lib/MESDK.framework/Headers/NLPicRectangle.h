//
//  NLPicRectangle.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLPicture.h"

/*!
 @enum
 @abstract 填充方式
 @constant NLFilledTypeFull 全填充
 @constant NLFilledTypeRim 仅边框
 */
typedef enum {
    NLFilledTypeFull, // 全填充
    NLFilledTypeRim // 仅边框
}NLFilledType;


@class NLPoint;
@class NLColor;
/*!
 @class
 @abstract 矩形对象
 @discuss
 */
@interface NLPicRectangle : NSObject<NLPicture>
@property (nonatomic, strong) NLPoint *startPoint; // 起始点
@property (nonatomic, strong) NLColor *color; // 颜色
@property (nonatomic, assign) int width; // 宽度
@property (nonatomic, assign) int height; // 高度
@property (nonatomic, assign) NLFilledType filledType; // 填充方式
- (id)initWithStartPoint:(NLPoint*)startPoint width:(int)width height:(int)height color:(NLColor*)color filledType:(NLFilledType)filledType;

@end
