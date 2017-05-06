//
//  NLAbstractEmvPackage.h
//  MTypeSDK
//
//  Created by su on 14-1-26.
//  Copyright (c) 2014年 suzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLVPackage.h"
#import "NLEmvTagDefined.h"
/**
 * 抽象的emv包体构造<p>
 * 主要是对扩展包结构的支撑
 *
 * @since v1.0
 */

@interface NLAbstractEmvPackage : NSObject
/**
 * 对于对象内未知的标签，都可以使用该方法设置，该方法设置的的标签和数值，会参与最终的打包过程。<p>
 * 其打包的优先级高于{@link EmvTagDefined}的定义，会覆盖其设置
 *
 * @param tag 设置的tlv标签
 * @param value 设置的tlv数值
 */
- (void)setExternalWithTag:(int)tag value:(NSData*)value;
- (id<TLVPackage>)setExternalInfoPackageWithTags:(NSArray*)tags;
/**
 * 获得设置过的tlv标签。<p>
 * 该方法无法获取到，通过{@link EmvTagDefined}定义的，且被设置的数据。只能获取到通过{@link #setExternal(int, byte[])}定义的数据。<p>
 * 在解包完成后，该方法可以获取到所有设备返回的标签数据，包含定义为{@link EmvTagDefined}，且解包失败的数据。
 *
 * @param tag
 * @return
 */
- (NSData*)externalForTag:(int)tag;
- (void)removeExternalByTag:(int)tag;
- (id<TLVPackage>)externalPackage;
- (NSArray*)relativeTags;
+ (NSArray*)relativeTags;
+ (NSArray*)relativeTagsWithEmvPackageClass:(Class)entityClass;
- (NSString*)externalToString;
@end
