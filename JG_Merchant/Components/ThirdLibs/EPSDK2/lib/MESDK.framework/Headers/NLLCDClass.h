//
//  NLLCDClass.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum
 @abstract 液晶屏类型
 @constant NLScreenTypeBlackWhite 黑白屏
 @constant NLScreenTypeColor 彩屏
 */
typedef enum {
    NLScreenTypeBlackWhite, // 黑白屏
    NLScreenTypeColor // 彩屏
}NLScreenType;

/*!
 @class 
 @abstract LCD类型
 @discussion
 */
@interface NLLCDClass : NSObject
@property (nonatomic, assign) int width; // LCD的像素宽度
@property (nonatomic, assign) int height; // LCD的像素高度
@property (nonatomic, assign) NLScreenType screenType; // 液晶屏类型{@link ScreenType}
- (id)initWithWidth:(int)width height:(int)heiht screenType:(NLScreenType)screenType;

@end
