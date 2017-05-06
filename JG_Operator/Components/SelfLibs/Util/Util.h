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

//验证手机号
+ (BOOL)isValidateMobile:(NSString *)mobile;

//验证固定电话
+ (BOOL)isValidateTel:(NSString *)tel;

+ (void)dialWithPhoneNumber:(NSString *)phoneNum;

//身份证验证


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

// 根据内容动态获取宽高
+ (CGSize)resetFrameWithContent:(NSString *)content font:(NSInteger)font size:(CGSize)size;

@end
