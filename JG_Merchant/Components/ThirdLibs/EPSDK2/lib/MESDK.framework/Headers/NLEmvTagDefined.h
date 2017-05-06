//
//  NLEmvTagDefined.h
//  MTypeSDK
//
//  Created by su on 14-1-26.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NLEmvTagDefined <NSObject>
/*!
 @method
 @abstract 标签值
 @discussion
 */
- (int)tag;
@end

@interface NLEmvTagDefined : NSObject<NLEmvTagDefined>
@property (nonatomic) int tag;
+ (id)emvTagdefined:(int)tag;
@end


@protocol NLEmvTagDefinedDataSource <NSObject>
+ (NSDictionary*)emvTagDefineds;
@optional
+ (NSArray*)emvTagFields;
@end