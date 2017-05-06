//
//  NLColor.h
//  mpos
//
//  Created by su on 13-6-13.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class NLColor 
 @abstract 色彩定义
 */
@interface NLColor : NSObject {
}
@property (nonatomic, strong, readonly) NSData *colorValue;
- (NLColor*)initWithValue:(int)value;
- (NLColor*)initWithData:(NSData*)data;
+ (NLColor*)colorWithValue:(int)value;


@end
