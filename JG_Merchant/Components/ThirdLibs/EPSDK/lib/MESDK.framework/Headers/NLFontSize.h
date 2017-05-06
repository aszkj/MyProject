//
//  NLFontSize.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @class
 @abstract 设置字体大小
 @discussion 任何参数若获取数值小于0,则表示该参数未被设置.
 */
@interface NLFontSize : NSObject
@property (nonatomic, assign) int chineseCharWidth; // 中文字符宽度
@property (nonatomic, assign) int chineseCharHeight; // 中文字符高度
@property (nonatomic, assign) int charWidth; // 字符宽度
@property (nonatomic, assign) int charHeight; // 字符高度
- (id)initWithChineseCharWidth:(int)chineseCharWidth
             chineseCharHeight:(int)chineseCharHeight
                     charWidth:(int)charWidth
                    charHeight:(int)charHeight;
@end
