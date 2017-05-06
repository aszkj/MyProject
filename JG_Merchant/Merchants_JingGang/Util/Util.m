//
//  Util.m
//  jingGang
//
//  Created by 张康健 on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "Util.h"
#import "NSDate+Utilities.h"


@implementation Util
 + (void)asRootOfVC:(UIViewController *)vc {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    keyWindow.rootViewController = nav;

}

+ (UIButton *)getSeletedButtonAtBtnArr:(NSArray *)btnArr{
    
    for (UIButton *button in btnArr) {
        if (button.selected) {
            return button;
            break;
        }
    }
    return nil;
}//得到之前选中的tabbutton

+ (UIView *)getDisplayedViewAtViewArrs:(NSArray *)views{
    
    for (UIView *view in views) {
        if (!view.hidden) {
            return view;
            break;
        }
    }
    return nil;
}//返回显示的view


+ (void)makeWellClickBGBtnAtNavBar:(UINavigationBar *)navBar withBtnSize:(CGFloat)size onResponseMethodStr:(NSString *)methodStr isLeftItem:(BOOL)isleftItem inResponseObject:(id)responseObj
{

//    CGRect frame;
//    if (isleftItem) {
//        frame = CGRectMake(0, 0, size, size);
//    }else{
//        frame = CGRectMake(kScreenWidth-size-20, 0, size, size);
//    }
//    
//    UIButton *bigBtn = [[UIButton alloc] initWithFrame:frame];
////    bigBtn.alpha = 0.1;
//    bigBtn.backgroundColor = [UIColor clearColor];
//    SEL responseSel = NSSelectorFromString(methodStr);
//    [bigBtn addTarget:responseObj action:responseSel forControlEvents:UIControlEventTouchUpInside];
//    [navBar addSubview:bigBtn];
//    [navBar bringSubviewToFront:bigBtn];
}



//验证字符串是否有效
+ (BOOL)varifyValidOfStr:(NSString *)str{
    if (!str || [str isEqualToString:@""]) {
//         [Util ShowAlertWithOnlyMessage:@"内容不能为空"];
        return NO;
    }
    return YES;
}

+ (BOOL)validateInputStr:(NSString *)inputStr rangeFromBeginValue:(NSInteger)beginValue endValue:(NSInteger)endValue withAlertName:(NSString *)alertName{
    NSString *alertStr = nil;
    if (![self varifyValidOfStr:inputStr]) {
        alertStr = [NSString stringWithFormat:@"%@不能为空",alertName];
            [Util ShowAlertWithOnlyMessage:alertStr];
        return NO;
    }
    
    if ([inputStr integerValue] < beginValue || [inputStr integerValue] > endValue) {
        alertStr = [NSString stringWithFormat:@"%@输入不合理，请重新输入",alertName];
        [Util ShowAlertWithOnlyMessage:alertStr];
        return NO;
    }
    
    return YES;
    
}



+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+ (void)setNavTitleWithTitle:(NSString *)navTitle ofVC:(UIViewController *)vc{

    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:18.0];
    titleLable.text = navTitle;
    titleLable.textAlignment = NSTextAlignmentCenter;
    vc.navigationItem.titleView = titleLable;

}


+ (void)preSentVCWithRootVC:(UIViewController *)vc withPrensentVC:(UIViewController *)presentvc{
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [presentvc presentViewController:modalNav animated:YES completion:nil];

}//弹出导航模态

+ (void)ShowAlertWithOutCancelWithTitle:(NSString *)alertTitle message:(NSString *)alertMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];

}

+ (void)ShowAlertWithOnlyMessage:(NSString *)alertMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

+ (void)setValueIndiffScreensWithVarary:(CGFloat *)var in4s:(CGFloat)var4s in5s:(CGFloat)var5s in6s:(CGFloat)var6s plus:(CGFloat)varplus
{
    if (kScreenWidth == 320 && kScreenHeight == 480 ) {//4s
        
        *var = var4s;
        
    }else if (kScreenWidth == 320 && kScreenHeight == 568){//5s
        *var = var5s;
        
    }else if (kScreenWidth == 375 && kScreenHeight == 667 ){//6s
        
        *var = var6s;
        
    }else{//plus
        
        *var = varplus;
    }
    
}
+(BOOL)isValidateTel:(NSString *)tel
{
    NSString *telResex = @"^\\d{3}-\\d{7}|\\d{3}-\\d{8}|\\d{4}-\\d{7}|\\d{4}-\\d{8}|\\d{7}|\\d{8}|\\d{10}|\\d{11}|\\d{12}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telResex];
    return [phoneTest evaluateWithObject:tel];
}
+ (BOOL)isValidateIdentity:(NSString *)indentity
{
    NSString *phoneRegex = @"^\\d{15}|\\d{18}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:indentity];
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


+ (NSString *)removeHTML2:(NSString *)html{
    
    NSArray *components = [html componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    
    for (int i = 0; i < [components count]; i = i + 2) {
        
        [componentsToKeep addObject:[components objectAtIndex:i]];
        
    }
    
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    
    return plainText;
    
}

+ (NSAttributedString *)getShopEnterAttributeString:(NSString *)orignStr
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:orignStr];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:7.0],NSFontAttributeName,
                                   [UIColor redColor],NSForegroundColorAttributeName,nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@"✻"];
    if (range.length > 0)
    {
        range = NSMakeRange(range.location, 1);
        [attributedString addAttributes:attributeDict range:range];
    }
    return attributedString.copy;
}

+ (BOOL)containsMatch:(NSString *)pattern insString:(NSString *)string
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSRange range = NSMakeRange(0, string.length);
    return [regex firstMatchInString:string options:NSMatchingReportCompletion range:range] != nil;
    
}

+ (BOOL)isValidateNumber:(NSString *)str
{
    NSString *numberRegex = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    return [[self class] containsMatch:numberRegex insString:str];
}

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (CGSize)resetFrameWithContent:(NSString *)content font:(NSInteger)font size:(CGSize)size {
    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
//    CGRect resetFrame = [content boundingRectWithSize:size
//                                        options:NSStringDrawingUsesLineFragmentOrigin
//                                     attributes:attributes
//                                        context:nil];
    
    CGSize resetSize = kStringSize(content, font, size.width, size.height);
    
    return resetSize;
}

+(NSString *)getStringFormaDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateF = [dateFormatter dateFromString:date];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)dateF.year,(long)dateF.month,(long)dateF.day,(long)dateF.hour,(long)dateF.minute];
    return dateStr;
}

+ (NSDate *)_getDateFromDateStr:(NSString *)dateStr {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateF = [dateFormatter dateFromString:dateStr];
    return dateF;
}

+ (NSString *)getStringFormaDateWithTailSecond:(NSString *)date
{
    NSDate *dateF = [self _getDateFromDateStr:date];
    return  [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",(long)dateF.year,(long)dateF.month,(long)dateF.day,(long)dateF.hour,(long)dateF.minute,(long)dateF.seconds];
}

@end
