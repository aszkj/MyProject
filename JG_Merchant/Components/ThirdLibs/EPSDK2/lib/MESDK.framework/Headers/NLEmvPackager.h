//
//  NLEmvPackager.h
//  MTypeSDK
//
//  Created by su on 14-1-27.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLAbstractEmvPackage.h"
/*!
 @protocol
 @abstract emv 打包器
 @discussion
 */
@protocol NLEmvPackager <NSObject>
/*!
 @method
 @abstract (NSInteger, NLEmvTagRef)
 @discussion
 */
- (NSDictionary*)supportTagMapping;
- (NSData*)pack:(NLAbstractEmvPackage*)pckg;
- (NSData*)pack:(NLAbstractEmvPackage*)pckg fields:(NSArray*)fields;
- (NLAbstractEmvPackage*)unpack:(NSData*)payload contentClass:(Class)content;
- (NLAbstractEmvPackage*)unpack:(NSData*)payload content:(id)content;

@end
