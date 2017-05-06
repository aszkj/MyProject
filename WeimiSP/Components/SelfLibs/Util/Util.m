//
//  Util.m
//  jingGang
//
//  Created by 张康健 on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "Util.h"
#import "UIImage+ImageEffects.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "NSDate+Addition.h"
#import "SessonContentModel.h"

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
         [Util ShowAlertWithOnlyMessage:@"内容不能为空"];
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
    titleLable.font = [UIFont boldSystemFontOfSize:17.0];
    titleLable.text = navTitle;
    titleLable.textAlignment = NSTextAlignmentCenter;
    vc.navigationItem.titleView = titleLable;
}

+ (void)setWemiWhiteTitle:(NSString *)title ofVC:(UIViewController *)vc {

    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont boldSystemFontOfSize:17.0];
    titleLable.text = title;
    titleLable.textAlignment = NSTextAlignmentCenter;
    vc.navigationItem.titleView = titleLable;
}
+ (NSString *)getRelatedTimeByTimeInterval:(NSTimeInterval)timeInteval {
    
    long seconds = (long)timeInteval/1000;
    NSTimeInterval timeInterval = (NSTimeInterval)seconds;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSTimeInterval intervalTimeSinceNow = [confromTimesp timeIntervalSinceNow];
    seconds = -(long)intervalTimeSinceNow;

    long minute = seconds / 60;
    long hour = seconds / 3600;
    long days = seconds / (3600 * 24);
    long months = seconds / (3600 * 24 * 30);
    long years = seconds / (3600 * 24 * 30 * 12);
    
    if (years > 1) {
        return @"很久前";
    }
    
    long timeValue = 0;
    NSString* timeUit = @"";
    if (seconds < 60) {
        timeValue = seconds;
        timeUit = @"秒";
    }else if (minute<60){
        timeValue = minute;
        timeUit = @"分钟";
    }else if (hour < 24){
        timeValue = hour;
        timeUit = @"小时";
    }else if (days < 30){
        timeValue = days;
        timeUit = @"天";
    }else if (months < 12){
        timeValue = months;
        timeUit = @"月";
    }
    
    if (seconds < 5) {
        return @"刚刚";
    }else {
        return [NSString stringWithFormat:@"%ld%@前",timeValue,timeUit];
    }
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
        return @"0.00m";
    }
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

+ (NSString *)appVersion {
    
    NSDictionary *infoDictionary =[[NSBundle mainBundle]infoDictionary];
    NSString *versionStr = [infoDictionary objectForKey:@"CFBundleVersion"];
    return versionStr;
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
    NSString *telResex = @"^\\d{3}-\\d{8}|\\d{4}-\\d{7}|\\d{7}|\\d{8}|\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telResex];
    return [phoneTest evaluateWithObject:tel];
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(16[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


+ (NSString *)removeDivHtmlWithKey:(NSString *)key value:(NSString *)value{
    
    NSString *result = value;
    if ([key isEqualToString:@"msg_content"] && [value containsString:@"<div"] && [value containsString:@"</div>"]) {
        
        NSRange find = [value rangeOfString:@">"];
        result = [value substringFromIndex:find.location + 1];
        
        find = [result rangeOfString:@"<"];
        result = [result substringToIndex:find.location];
    }
    
    return result;
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
                                   [UIFont systemFontOfSize:17.0],NSFontAttributeName,
                                   [UIColor redColor],NSForegroundColorAttributeName,nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@"*"];
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
    return [regex firstMatchInString:string options:0 range:range] != nil;
    
}

+ (BOOL)isValidateNumber:(NSString *)str
{
    NSString *numberRegex = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    return [[self class] containsMatch:numberRegex insString:str];
}

+ (NSString *)createTimeIntervalOfNoRandomWithDate:(NSDate *)date {
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([date timeIntervalSince1970] * 1000)];
    return timeSp;
}

+ (NSString *)createTimeIntervalWithDate:(NSDate *)date {
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld.%d", (long)([date timeIntervalSince1970] * 1000),arc4random() % 10000];
    return timeSp;
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *)macaddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

+ (NSArray *)findObjectFromArrary:(NSArray *)sourceList predicate:(NSPredicate *)predicate {
        
    NSArray *filterArray = [sourceList filteredArrayUsingPredicate:predicate];
    if (filterArray && filterArray.count > 0) {
        return filterArray;
    }
    
    return nil;
}

+ (CGSize)resetImageSizeFromSourceSize:(CGSize)sourceSize maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight {
    
    CGSize imgRect = sourceSize;
    
    if (imgRect.width > maxWidth) {
        imgRect.height = (maxWidth*imgRect.height)/imgRect.width;
        imgRect.width = maxWidth;
    }
    if (imgRect.height > maxHeight) {
        imgRect.width = (maxHeight*imgRect.width)/imgRect.height;
        imgRect.height = maxHeight;
    }
    
    return imgRect;
}

//view截图
+ (UIImage *)snapshot:(UIView *)view {
    
//    UIGraphicsBeginImageContext(view.bounds.size);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
    
    
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, [UIScreen mainScreen].scale);
    
    // IOS7及其后续版本
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                    [self methodSignatureForSelector:
                                     @selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
        [invocation setTarget:self];
        [invocation setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
        CGRect arg2 = [UIScreen mainScreen].bounds;
        BOOL arg3 = YES;
        [invocation setArgument:&arg2 atIndex:2];
        [invocation setArgument:&arg3 atIndex:3];
        [invocation invoke];
    } else { // IOS7之前的版本
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

// 复制对象
+ (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    UIView *copView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    return copView;
}

+(void)setNavigationTranslucentWithVC:(UIViewController *)vc
{
    //定制返回按钮,这两个要一起用,为啥这么用，苹果言语不详
    vc.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navigation_back"];;
    vc.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navigation_back"];
    //更改导航栏为透明色
//    vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    vc.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    [vc.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]  fillClipSize:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
//    vc.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    vc.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //返回title为空
    UIBarButtonItem *titleBar = [[UIBarButtonItem alloc] init];
    titleBar.title = @"";
    vc.navigationItem.backBarButtonItem = titleBar;
//    vc.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x65c577);
    vc.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    vc.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    });
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSTimeInterval)sortWithArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo
{
    NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:yesOrNo];
    NSArray *descriptors = [NSArray arrayWithObjects:distanceDescriptor,nil];
    [dicArray sortUsingDescriptors:descriptors];
    NSTimeInterval subTime = kChatSpacingTime;//间隔多久显示时间
    NSTimeInterval tempTime = 0;
    for (SessonContentModel *model in dicArray)
    {
        if ((model.contentTimestamp - tempTime) > (subTime * 1000) )
        {
            model.isHiddenTime = YES;
        }
        else{
            model.isHiddenTime = NO;
        }
        tempTime = model.contentTimestamp;
    }
    return tempTime;
    
}
+(NSUInteger)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return [da length];
}

/**
 *  保证字符串字节数小于less
 *
 *  @param strtemp 原先字符串
 *  @param less    小于less
 *
 *  @return 返回结果字符串
 */
+ (NSString *)getToString:(NSString *)strtemp byteLessWith:(NSInteger)less
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    if ([da length] <= less)
    {
        return strtemp;
    }
    else
    {
        da = [da subdataWithRange:NSMakeRange(0, less)];
        NSString *str = [[NSString alloc ]initWithData:da encoding:enc];
        return str.length == 0 ? strtemp : str;
    }
}


@end
