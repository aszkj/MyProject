//
//  GlobeObject.h
//  ZCSuoPing
//
//  Created by caipeng on 14-11-14.
//  Copyright (c) 2014年 掌众传媒 www.chinamobiad.com. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CocoaLumberjack/DDLog.h>


#define BoundNibView(viewNibName,ViewClass) (ViewClass *)[[[NSBundle mainBundle] loadNibNamed:viewNibName owner:nil options:nil] lastObject]

//2倍的imgUrl
#define TwiceImgUrlStr(imgUrlStr,width,height) [NSString stringWithFormat:@"%@_%ix%i",imgUrlStr,(int)width*2,(int)height*2]

#define kCurrentKeyWindow    [UIApplication sharedApplication].keyWindow
#define IMAGE(image)               [UIImage imageNamed:image]
#define kPageSize                  [NSNumber numberWithInteger:5]

#define token @"token"
#define kShopKey @"shopKey"

#define WEAK_SELF                   __weak typeof(self) weak_self = self;
#define WEAK_OBJECT(weak_obj, obj)  __weak typeof(obj) weak_obj = obj;
#define WEAK_OBJ(__obj) typeof(__obj) __weak weak_##__obj = __obj;
#define BLOCK_OBJ(__obj) typeof(__obj) __block block_##__obj = __obj;


#pragma mark - ------------系统相关宏定义---------------

#define iOS_7_Above ([[UIDevice currentDevice].systemVersion floatValue]>7.0)

#define iPhone4_width 320
#define iPhone5_width 320
#define iPhone6_width 375
#define iPhone6p_width 414

#define iPhone4_Height 480
#define iPhone5_Height 568
#define iPhone6_Height 667
#define iPhone6P_Height 736

#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480) // 320*480
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568) // 320*568
#define iPhone6 ([UIScreen mainScreen].bounds.size.height == 667) // 375*667
#define iPhone6p ([UIScreen mainScreen].bounds.size.height == 736)// 414*736
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
#define iOS6 [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DeviceType (isPad?@"I2":([[UIDevice currentDevice].model rangeOfString:@"iPhone"].location !=NSNotFound?@"I1":@"I3") )
#define APP_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height
#define APP_WIDTH [[UIScreen mainScreen] applicationFrame].size.width

#define sysVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//屏幕的宽度，屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kNavBarAndStatusBarHeight 64

// 设备状态栏
#define __StatusScreenFrame             [[UIApplication sharedApplication] statusBarFrame]
// 设备状态栏高度
#define __StatusScreen_Height           __StatusScreenFrame.size.height
#pragma mark - ------------全局常量宏定义---------------

//通知中心全局数据常量单例
#define kNotification [NSNotificationCenter defaultCenter]
//NSUserDefaults 的全局
#define kUserDefaults [NSUserDefaults standardUserDefaults]
//UIApplication
#define kAppDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]
//按钮的圆角角度
#define m_button_cØ¡ornerRadius  4.0f
#pragma mark - ------------常用方法宏定义---------------

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//根据RGB来获取颜色
#define kGetColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//根据RGBA来获取颜色
#define kGetColorWithAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define MD5(src) [src MD5Hash]
#define kSystemFontSize(fontSize) [UIFont systemFontOfSize:fontSize]
#define IntToString(src) [NSString stringWithFormat:@"%ld", (long)src]
#define kNumberToStr(number) [NSString stringWithFormat:@"%@",number]
#define jFormat(__format, ...) [NSString stringWithFormat:__format, ##__VA_ARGS__]
#define jSetButtonNormalStateTile(button,title) [button setTitle:title forState:UIControlStateNormal]

//collectionHeight
#define kCollectionHeight(itemCount,cellHeihgt,horizonalCellCount) ((itemCount % horizonalCellCount ? (itemCount / horizonalCellCount + 1) : itemCount / horizonalCellCount) * cellHeihgt)

#define scrollViewMaxScrollHeight(scrollView) (scrollView.contentSize.height-scrollView.frame.size.height)
#define scrollViewMaxScrollWidth(scrollView) (scrollView.contentSize.width-scrollView.frame.size.width)

//传入ipone6下的尺寸，根据比例得到在其他屏幕下的尺寸
#define ADAPT_SCREEN_WIDTH(widthInPhone6) (widthInPhone6 * 1.0 / iPhone6_width ) * kScreenWidth
#define ADAPT_SCREEN_HEIGHT(heightInPhone6) (heightInPhone6 * 1.0/ iPhone6_Height * 1.0) * kScreenHeight


//根据字符串长度求字符串尺寸
#define kStringSize(str,fSize,str_W,str_H) [str sizeWithFont:[UIFont systemFontOfSize:fSize] constrainedToSize:CGSizeMake(str_W, str_H)]
//打印对象地址
#define DlogObjectAddress(obj) NSLog(@"address is %p",(id)obj);

#define afterSecondsLoadData(secondes,__stuff) {\
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, secondes * NSEC_PER_SEC);\
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){\
__stuff\
});\
}

#define emptyBlock(block,...)  if (block) {\
block(__VA_ARGS__);\
}

static inline BOOL isEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
    
}

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif



#ifdef DEBUG
#define JLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define JLog(fmt, ...)

#endif

#define EntityKey  @"entity"
#define ListKey    @"list"
#define kFilePathWithName(name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:name]



