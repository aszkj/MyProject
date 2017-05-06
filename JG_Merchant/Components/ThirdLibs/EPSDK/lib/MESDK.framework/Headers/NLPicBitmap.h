//
//  NLPicBitmap.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLPicture.h"

@class UIImage;
@class NLPoint;
/*!
 @class
 @abstract 用于显示的位图对象
 @discussion TODO 未确认{@link android.graphics.Bitmap Bitmap}是否能够适用.
 */
@interface NLPicBitmap : NSObject<NLPicture>
@property (nonatomic, strong) NLPoint *startPoint; // 起始点
@property (nonatomic, strong) UIImage *bitmap; // 位图对象
@property (nonatomic, assign) int width; // 宽度
@property (nonatomic, assign) int height; // 高度
- (id)initWithStartPoint:(NLPoint*)startPoint width:(int)width height:(int)height bitmap:(UIImage*)bitmap;
@end
