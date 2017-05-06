//
//  NLLCD.h
//  mpos
//
//  Created by su on 13-6-14.
//  Copyright (c) 2013年 suzw. All rights reserved.
//

#import "NLFoundation.h"
#import "NLModule.h"
#import "NLPoint.h"
#import "NLColor.h"
#import "NLPicture.h"
#import "NLLCDClass.h"
#import "NLFontSize.h"
#import "NLDispType.h"
#import "NLMenu.h"
#import "NLMenuRoot.h"
#import "NLMenuObj.h"
#import "NLLoadMenuResult.h"
/*!
 @enum
 @abstract 刷新模式
 @constant NLFlushTypeManual 手动刷新(该模式需要显示调用刷新过程)
 @constant NLFlushTypeAutomatic 自动刷新
 */
typedef enum {
    NLFlushTypeManual,
    NLFlushTypeAutomatic
}NLFlushType;

/*!
 @protocol LCD液晶屏
 @abstract 液晶屏
 */
@protocol NLLCD <NLModule>
/*!
 @method
 @abstract 获得液晶属性
 @return
 */
- (NLLCDClass*)LCDClass;
/*!
 @method
 @abstract 获得字体大小
 @return
 */
- (NLFontSize*)fontSize;
/*!
 @method
 @abstract 获得光标位置
 @return
 */
- (NLPoint*)cursorPosition;
/*!
 @method
 @abstract 液晶屏清屏
 @discussion 清屏结束后,坐标设置为<tt>(0,0)</tt>,同时屏幕显示模式设置为<tt>{@link DispType#NORMAL}
 */
- (void)clearScreen;
/*!
 @method
 @abstract 设置显示模式
 @discussion 设置之后,将会启用反向显示模式。
             对应反向显示的背景色参考上次设置的{@link FontColor#getReversalWordsColor()}和{@link FontColor#getReversalWordsColor()}
 @param dispType 显示模式
 */
- (void)setDisplayType:(NLDispType)dispType;
/*!
 @method
 @abstract 设置刷新模式
 */
- (void)setFlushType:(NLFlushType)flushType;
/*!
 @method
 @abstract 设置光标位置
 */
- (void)setCursorPosition:(NLPoint*)p;
/*!
 @method
 @abstract 画出给定图像
 @discussion 若刷新模式为:{@link FlushType#MANUAL}，则会记录在显存，在刷新时一并显示
             若自动刷新，则直接刷新出对应图片
 */
- (void)drawWithPicture:(id<NLPicture>)picture;
/*!
 @method
 @abstract 从当前光标处输出字符串
 @param words 待输出数据
 */
- (void)drawWithWords:(NSString*)words NL_DEPRECATED_AT(1_0_3);
/*!
 @version 1.0.6
 @method
 @abstract 从当前光标处输出字符串并在预定的时间内显示
 @param words 待输出数据
 @param showtime 显示时间
 @param
 */
- (void)drawWithWords:(NSString*)words showtime:(int)showtime;
/*!
 @method
 @abstract 手动刷新屏幕
 @discussion 将显存中用户设置的显示区域数据刷新显示。同时清空显存.
 */
- (void)flush;
/*!
 @method
 @abstract 启动背光
 */
- (void)enableBackgroundLight;
/*!
 @method
 @abstract 关闭背光
 */
- (void)disableBackgroundLight;
/*!
 @method
 @abstract 设置通用正显字体颜色
 */
- (void)setNormalWordsColor:(NLColor*)color;
/*!
 @method
 @abstract 设置通用反显字体颜色
 */
- (void)setReversalWordsColor:(NLColor*)color;
/*!
 @method
 @abstract 设置通用反显背景颜色
 */
- (void)setReversalBackgroundColor:(NLColor*)color;
/*!
 @method
 @deprecated
 @abstract 显示一个菜单
 @param menuRoot 菜单
 @param timeout 显示超时时间
 @return
 */
- (id<NLMenu>)showMenu:(NLMenuRoot *) menuRoot timeout:(int)timeout NL_DEPRECATED_API;
/*!
 @since 1.3.0
 @method
 @abstract 装载菜单
 @param menuRoot 菜单
 @param timeout 显示超时时间
 @return
 */
- (NLLoadMenuResult)loadMenu:(NLMenuRoot*)menuRoot timeout:(int)timeout;
/*!
 @since 1.3.0
 @method
 @abstract 装载菜单并进行mac校验
 @param menuRoot 菜单
 @param macIndex mac索引
 @param macRadom 分散随机数
 @param mac 菜单mac
 @param timeout 显示超时时间
 @return
 */
- (NLLoadMenuResult)loadMenu:(NLMenuRoot*)menuRoot macIndex:(int)macIndex macRadom:(NSData*)macRadom mac:(NSData*)mac timeout:(int)timeout;
/*!
 @since 1.3.0
 @method
 @abstract 启动pos预装载菜单，显示并返回菜单交易代码
 @param timeout 超时时间
 @param err 异常情况
 @return
 */
- (NSString*)launchMenuWithTimeout:(int)timeout error:(NSError**)err;
@end
