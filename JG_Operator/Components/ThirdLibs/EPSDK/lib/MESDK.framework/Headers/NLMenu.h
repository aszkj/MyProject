//
//  NLMenu.h
//  MTypeSDK
//
//  Created by wlx on 14-2-17.
//  Copyright (c) 2014年 wanglx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NLMenu <NSObject>
/**
 * 获取菜单名称<p>
 * @return
 */
- (NSString*)menuName;

/**
 * 获得一个菜单处理码
 * @return
 */
- (NSString*)eCode;


/**
 * 获取子菜单快照<p>
 *
 * @return
 */
- (NSArray*)subMenu;

/**
 * 增加一个子菜单<p>
 * 将被插入当前子菜单列表的末尾
 *
 * @param menu 增加的子菜单
 */
- (void)addSubMenu:(id<NLMenu>)menu;

/**
 * 插入一个字菜单<p>
 * 若子菜单索引大等于当前子菜单长度,将会抛出{@link ArrayIndexOutOfBoundsException}的异常<p>
 * 索引默认从<tt>0</tt> 开始
 *
 * @param index 子菜单索引
 * @param menu
 */
- (void)insertSubMenuByIndex:(int)index andMenu:(id<NLMenu>)menu;

/**
 * 使用索引清除一个子菜单
 * 若子菜单索引大等于当前子菜单长度,将会抛出{@link ArrayIndexOutOfBoundsException}的异常<p>
 * 索引默认从<tt>0</tt> 开始
 *
 * @param index 子菜单索引
 */
- (id<NLMenu>)removeSubMenuByIndex:(int)index;

/**
 * 清理一个子菜单<p>
 * 会查找子菜单列表,当判定equals被清理.<p>
 *
 * @param menu
 */
- (BOOL)removeSubMenu:(id<NLMenu>)menu;

/**
 * 是否是叶节点<p>
 *
 * @return
 */
- (BOOL)isLeaf;

/**
 * 是否是根节点
 *
 * @return
 */
- (BOOL)isTop;
@end
