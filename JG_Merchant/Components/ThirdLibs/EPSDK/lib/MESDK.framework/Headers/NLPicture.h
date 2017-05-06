//
//  NLPicture.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NLPoint;
/*!
 @protocol 
 @abstract 用于液晶屏图形现实接口
 */
@protocol NLPicture <NSObject>
/*!
 @method
 @abstract 该图形所在的起始坐标点
 @return
 */
- (NLPoint*)startPoint;
@end
