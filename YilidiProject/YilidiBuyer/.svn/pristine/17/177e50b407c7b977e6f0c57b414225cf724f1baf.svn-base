//
//  Util.h
//  jingGang
//
//  Created by 张康健 on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Util : NSObject

//把vc作为根控制器
+ (void)asRootOfVC:(UIViewController *)vc;

//加一个比较好点的背景button
+ (void)makeWellClickBGBtnAtNavBar:(UINavigationBar *)navBar withBtnSize:(CGFloat)size onResponseMethodStr:(NSString *)methodStr isLeftItem:(BOOL)isleftItem inResponseObject:(id)responseObj;

//设置导航栏标题
+ (void)setNavTitleWithTitle:(NSString *)navTitle ofVC:(UIViewController *)vc;

//导航推送
+ (void)preSentVCWithRootVC:(UIViewController *)vc withPrensentVC:(UIViewController *)presentvc;

//弹出警告,自定义标题
+ (void)ShowAlertWithOutCancelWithTitle:(NSString *)alertTitle message:(NSString *)alertMessage;

//弹出警告，默认标题
+ (void)ShowAlertWithOnlyMessage:(NSString *)alertMessage;

//验证字符串是否有效
+ (BOOL)varifyValidOfStr:(NSString *)str;

//验证字符串是否为空，以及是否在某个范围内
+ (BOOL)validateInputStr:(NSString *)inputStr rangeFromBeginValue:(NSInteger)beginValue endValue:(NSInteger)endValue withAlertName:(NSString *)alertName;

//验证邮箱
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  验证是否是手机号或者固定电话
 
 */
+ (BOOL)isValidatePhoneNumberOrTelNumber:(NSString *)phoneOrTelNumber;


//验证手机号
+ (BOOL)isValidateMobile:(NSString *)mobile;

//验证密码
+(BOOL)checkPassWord:(NSString *)password;

//字符串的是否包含空格判断
+(BOOL)isNull:(NSString *)str;

//是否是纯数字
+ (BOOL)isNumText:(NSString *)str;

//是否包含特殊字符
+(BOOL)validateNickname:(NSString *)nickname;

//验证固定电话
+ (BOOL)isValidateTel:(NSString *)tel;


+ (void)dialWithPhoneNumber:(NSString *)phoneNum;

/**
 *  拨打客服电话
 */
+ (void)dialServerNumber:(NSString *)numberStr;

/**
 *  app版本，build版本
 */
+ (NSString *)appVersion;


/**
  app版本字符串，1.0.1
 */
+ (NSString *)appVersionStr;


+ (NSString *)deviceID;


+(UIViewController *)currentViewController;


//设置某个变量在不同屏幕下不同的值
+ (void)setValueIndiffScreensWithVarary:(CGFloat *)var in4s:(CGFloat)var4s in5s:(CGFloat)var5s in6s:(CGFloat)var6s plus:(CGFloat)varplus;

//在一个button数组中找到选中的button，并返回
+ (UIButton *)getSeletedButtonAtBtnArr:(NSArray *)btnArr;

//在一个view数组中找到显示的view，并返回
+ (UIView *)getDisplayedViewAtViewArrs:(NSArray *)views;


//过滤html标签
+ (NSString *)removeHTML2:(NSString *)html;

//商户入驻左边标签字样设置
+ (NSAttributedString *)getShopEnterAttributeString:(NSString *)orignStr;

/**
 *  验证数字和小数点
 *
 */
+ (BOOL)isValidateNumber:(NSString *)str;

/**
 *  验证浮点数
 *
 *  @param string 输入字符
 *
 */
+ (BOOL)isPureFloat:(NSString*)string;

/**
 *  将浮点数转为字符串，默认两位小数，如果末尾为0的话处理掉
 *
 *  @param value 输入的浮点数
 */


+ (NSString *)toStrOfFloatValue:(CGFloat)value;
/**
 *  将浮点数转为￥.的形式
 *
 *  @param price 价格
 */

+ (NSString *)toRMBValueOfFloatValue:(CGFloat)price;
/**
 *   转成那种特殊显示的价格，价格¥和小数位都是小字体，整数位是大字体
 *
 *  @param prive   价格
 *  @param rmbSize 人民币符号字体
 *  @param zhengshuPartFont 整数部分字体
 *  @param pointPartFont 小数部分字体
 *
 *  @return 价格attributedStr
 */
+ (NSAttributedString *)toAttributeRMBfOfValue:(CGFloat)price
                     RMBTextFont:(UIFont *)RMBTextFont
                     zhengshuPartFont:(UIFont *)zhengshuPartFont
                   pointPartFont:(UIFont *)pointPartFont;

+ (NSAttributedString *)toAttributeRMBfOfValue:(CGFloat)price
                                   RMBTextFont:(UIFont *)RMBTextFont
                              zhengshuPartFont:(UIFont *)zhengshuPartFont;



// 根据内容动态获取宽高
+ (CGSize)resetFrameWithContent:(NSString *)content font:(NSInteger)font size:(CGSize)size;

@end
