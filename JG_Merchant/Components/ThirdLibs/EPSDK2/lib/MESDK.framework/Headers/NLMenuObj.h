//
//  NLMenuObj.h
//  MTypeSDK
//
//  Created by wlx on 14-2-17.
//  Copyright (c) 2014年 wanglx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLAbstractMenu.h"
@interface NLMenuObj : NLAbstractMenu
-(id)initWithECode:(NSString *)eCode andName:(NSString *)name andIsLeaf:(BOOL)isLeaf;
/**
 * 构造一个可以有子菜单的菜单对象
 *
 * @param eCode 菜单处理码
 * @param name 名称
 * @return
 */
+(id<NLMenu>)createSubListMenuWithECode:(NSString *)eCode andName:(NSString *)name;
/**
 * 构造一个可以有子菜单的菜单对象
 *
 * @param parent 父菜单
 * @param eCode 菜单处理码
 * @param name 名称
 * @return
 */
+(id<NLMenu>)createSubListMenu:(id<NLMenu>)parent eCode:(NSString *)eCode name:(NSString *)name;
/**
 * 构造一个可选择的菜单项<p>
 * 该菜单不能有子菜单
 *
 * @param eCode 菜单处理码
 * @param name 菜单名称
 * @return
 */
+(id<NLMenu>)createButtonMenu:(NSString *)eCode name:(NSString *)name;

/**
 * 构造一个可选择的菜单项<p>
 * 该菜单不能有子菜单
 *
 * @param parent 父菜单
 * @param eCode 菜单处理码
 * @param name 菜单名称
 * @return
 */
+(id<NLMenu>)createButtonMenu:(id<NLMenu>)parent eCode:(NSString *)eCode name:(NSString *)name;
@end
