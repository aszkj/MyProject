//
//  Util.m
//  jingGang
//
//  Created by 张康健 on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "Util.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "PinYin4Objc.h"
#import "loginViewController.h"
#import "MBProgressHUD.h"


@implementation Util
 + (void)asRootOfVC:(UIViewController *)vc {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    keyWindow.rootViewController = nav;

}

+ (void)enterLoginPage {
    
    
    loginViewController *loginVC = [[loginViewController alloc] init];
    UINavigationController *logNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = logNav;
    
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

+ (NSString *)appVersion {

    NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
    NSString *versionStr = [infoDictionary objectForKey:@"CFBundleVersion"];
    return versionStr;
}

+ (void)setTitleViewWithTitle:(NSString *)title andNav:(UINavigationController *)nav{
    
    UILabel * name_lab = [[UILabel alloc]init];
    name_lab.frame = CGRectMake(0, __StatusScreen_Height, __MainScreen_Width,44);
    name_lab.textColor = [UIColor whiteColor];
    name_lab.text = title;
    name_lab.font = [UIFont systemFontOfSize:18];
    name_lab.textAlignment = NSTextAlignmentCenter;
    [nav.view addSubview:name_lab];
    RELEASE(name_lab);
}

//验证字符串是否有效
+ (BOOL)varifyValidOfStr:(NSString *)str{
    if (!str || [str isEqualToString:@""]) {
//         [Util ShowAlertWithOnlyMessage:@"请问你想了解此商品哪方面信息？"];
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

+ (NSString *)transferDistanceStrWithDistance:(NSNumber *)distance
{

    if (!distance) {
        return nil;
    }
    CGFloat distanceValue = distance.doubleValue;
    if (distanceValue > 0) {
        NSString *unitStr = @"m";
        if (distanceValue >= 1000 ) {
            distanceValue /= 1000;
            unitStr = @"km";
        }
        return [NSString stringWithFormat:@"%.2f%@",distanceValue,unitStr];
    } else {
        return @"- -";
    }
}

+ (BOOL)isValidatePostcode:(NSString *)postcode
{
    NSString *phoneRegex = @"^\\d{6}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:postcode];
}
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (void)dialWithPhoneNumber:(NSString *)phoneNum {
    
    NSString *tellNumber = [NSString stringWithFormat:@"tel://%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tellNumber]];
}


+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+ (void)setNavTitleWithTitle:(NSString *)navTitle ofVC:(UIViewController *)vc{

    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
//    titleLable.font = [UIFont systemFontOfSize:18.0];
    titleLable.font = [UIFont boldSystemFontOfSize:18.0];
    titleLable.text = navTitle;
    titleLable.textAlignment = NSTextAlignmentCenter;
    vc.navigationItem.titleView = titleLable;
    RELEASE(titleLable);
}


+ (void)preSentVCWithRootVC:(UIViewController *)vc withPrensentVC:(UIViewController *)presentvc{
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [presentvc presentViewController:modalNav animated:YES completion:nil];
    RELEASE(modalNav);
}//弹出导航模态

+ (void)ShowAlertWithOutCancelWithTitle:(NSString *)alertTitle message:(NSString *)alertMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    RELEASE(alert);
}

+ (void)ShowAlertWithOnlyMessage:(NSString *)alertMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

+ (void)showHudAltert:(UIView *)view message:(NSString *)message {
    
    if (view == nil) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.margin = 10.f;
    hud.yOffset = 5.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
    
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

+ (NSString *)accodingToScreenSizeGetMobileType {
    if (kScreenWidth == 320 && kScreenHeight == 480 ) {//4s
        return kApMobile4s;
    }else if (kScreenWidth == 320 && kScreenHeight == 568){//5s
        return kApMobile5s;
    }else if (kScreenWidth == 375 && kScreenHeight == 667 ){//6s
        return kApMobile6s;
    }else{
        return kApMobile6plus;
    }
}

+ (NSString *)trasnLateToHumanReadStrOfServerTimeStr:(NSString *)serverTimeStr {

    if (serverTimeStr.length < 11) {
        return @"--";
    }
    //处理时间
    serverTimeStr = [serverTimeStr stringByReplacingCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
    serverTimeStr = [serverTimeStr stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
    serverTimeStr = [serverTimeStr stringByReplacingCharactersInRange:NSMakeRange(10, 1) withString:@"日 "];

    return [serverTimeStr substringToIndex:11];
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

+ (NSString *)getPinyinStringWithNSString:(NSString *)str
{
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:str withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
    return outputPinyin;
}

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


@end
