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

+ (NSString *)appVersion;

//设置导航栏标题
+ (void)setNavTitleWithTitle:(NSString *)navTitle ofVC:(UIViewController *)vc;

//设置weimi白色标题
+ (void)setWemiWhiteTitle:(NSString *)title ofVC:(UIViewController *)vc;

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

//身份证验证


//设置某个变量在不同屏幕下不同的值
+ (void)setValueIndiffScreensWithVarary:(CGFloat *)var in4s:(CGFloat)var4s in5s:(CGFloat)var5s in6s:(CGFloat)var6s plus:(CGFloat)varplus;

//在一个button数组中找到选中的button，并返回
+ (UIButton *)getSeletedButtonAtBtnArr:(NSArray *)btnArr;

//在一个view数组中找到显示的view，并返回
+ (UIView *)getDisplayedViewAtViewArrs:(NSArray *)views;

//根据时间戳返回时间，秒、分、小时、天、月
+ (NSString *)getRelatedTimeByTimeInterval:(NSTimeInterval)timeInteval;

//过滤html标签
+ (NSString *)removeHTML2:(NSString *)html;

//过滤div标签
+ (NSString *)removeDivHtmlWithKey:(NSString *)key value:(NSString *)value;

//商户入驻左边标签字样设置
+ (NSAttributedString *)getShopEnterAttributeString:(NSString *)orignStr;

/**
 *  验证数字和小数点
 *
 */
+ (BOOL)isValidateNumber:(NSString *)str;

// 根据内容动态获取宽高
+ (CGSize)resetFrameWithContent:(NSString *)content font:(NSInteger)font size:(CGSize)size;

+ (NSString *)createTimeIntervalWithDate:(NSDate *)date;

+ (NSString *)createTimeIntervalOfNoRandomWithDate:(NSDate *)date;

+ (NSString *)transferDistanceStrWithDistance:(NSNumber *)distance;

+ (NSString *)macaddress;

+ (NSArray *)findObjectFromArrary:(NSArray *)sourceList predicate:(NSPredicate *)predicate;

+ (CGSize)resetImageSizeFromSourceSize:(CGSize)sourceSize maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
//view截图
+ (UIImage *)snapshot:(UIView *)view;

// 复制对象
+ (UIView *)duplicate:(UIView*)view;
/**
 *  设置控制器的导航栏为透明的背景色
 */
+ (void)setNavigationTranslucentWithVC:(UIViewController *)vc;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  可变数组进行排序
 *
 *  @param dicArray 排序对象：可变数组
 *  @param key      数组内容的key值
 *  @param yesOrNo  yes为升序、no为降序
 */
+(NSTimeInterval)sortWithArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo;
/**
 *  计算中英文长度
 *
 *  @param strtemp <#strtemp description#>
 *
 *  @return <#return value description#>
 */
+(NSUInteger)getToInt:(NSString*)strtemp;
/**
 *  保证字符串字节数小于less
 *
 *  @param strtemp 原先字符串
 *  @param less    小于less
 *
 *  @return 返回结果字符串
 */
+ (NSString *)getToString:(NSString *)strtemp byteLessWith:(NSInteger)less;

@end
