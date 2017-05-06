//
//  GlobeObject.h
//  ZCSuoPing
//
//  Created by caipeng on 14-11-14.
//  Copyright (c) 2014年 掌众传媒 www.chinamobiad.com. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "userDefaultManager.h"
#import "YTKKeyValueStore.h"
#import "Util.h"
#import "VApiManager+Aspects.h"
#import "RACEXTScope.h"

//#import "DefineClass.h"
//#import "NSString+MD5.h"
//#import "Util.h"
//#import "UIViewExt.h"
#pragma mark -------------url 信息------------------
//登录验证clientID
#define AuthenClientID @"carnation-resource-android"
//登录验证secret
#define AuthenSecret @"98e32480-d064-4166-945b-5c4467c717ea"

//开发环境
//#define BaseAuthUrl @"http://auth.jg.dev"
//#define StaticBase_Url @"http://static.jg.dev"
//#define Base_URL @"http://api.jg.dev"

//#define BaseAuthUrl @"http://192.168.2.13:10020"
//#define StaticBase_Url @"http://192.168.2.13:10020"
//#define Base_URL @"http://192.168.2.132:8070"

//
////测试环境
#define BaseAuthUrl @"http://auth.jgyes.cn"
//#define BaseAuthUrl @"http://192.168.2.132:8070"
#define StaticBase_Url @"http://static.jgyes.cn"
#define Base_URL @"http://api.jgyes.cn"
#define kJPushEnvirStr @"t_"
#define Shop_url @"http://shop.jgyes.cn"

//#define BaseAuthUrl @"http://192.168.2.69:8089"
//////#define BaseAuthUrl @"http://192.168.2.132:8070"
//#define StaticBase_Url @"http://static.jgyes.cn"
//#define Base_URL @"http://192.168.2.69:8081"
//#define kJPushEnvirStr @"t_"
//#define Shop_url @"http://192.168.2.69:8080"

//#define IrequestUrl @"http://api.jgyes.com"
//#define  hostAuth = "http://192.168.2.104:10020";
//#define  hostApi = "http://192.168.2.104:8083";
//#define  hostStatic = "http://192.168.2.104:8081";

//演练环境
//#define BaseAuthUrl @"http://auth.jgclub.cn"
//#define StaticBase_Url @"http://static.jgclub.cn"
//#define Base_URL @"http://api.jgclub.cn"

//线上环境
//#define BaseAuthUrl @"http://auth.jgyes.com"
//#define StaticBase_Url @"http://static.jgyes.com"
//#define Base_URL @"http://api.jgyes.com"
//#define kJPushEnvirStr @"p_"
//#define Shop_url @"http://shop.jgyes.com"
#pragma mark - ------------极光推送环境配置----------------







#pragma mark ----- 核销二维码生成链接-----
// 开发环境
//#define kDevCheckConsumeLink @"http://static.jgyes.cn/static/app/yqfx.html#"
// 生产环境
#define kProCheckConsumeLink @"http://static.jgyes.com/static/app/yqfx.html#"


#pragma mark - ------------通知名称宏定义----------------
//选择商品规格属性通知
#define selectGoodsCationPropertyNotification  @"selectGoodsCationPropertyNotification"
//改变商品数量通知
#define changeGoodsCountNotification @"changeGoodsCountNotification"

//改变商品squ通知
#define changeGoodsSquNotification @"changeGoodsSquNotification"

//库存改变的通知
#define goodsStockChangeNotification @"goodsStockChangeNotification"

//首页选择商城通知
#define selectShoppingNotification @"SelectShoppingNotification"


#pragma mark - ------------NSUserDefaults Key------------

// 显示启动引导画面标示
#define kAppVersion              @"2"
// 标示这个app是否已经登陆了
#define kIsLogin                 @"kIsLogin"

//标记应用程序是不是第一次使用
#define CT_FirstUser @"UDKEY_FirstUser"
//登录用户的账号名称
#define CT_LOGINUSERNAME @"UDKEY_LOGINUSERNAME"
//登录用户的账号密码
#define CT_LOGINUSERPASS @"UDKEY_LOGINUSERPASS"
//用户ID
#define CT_LOGINUSERUUID @"UDKEY_LOGINUSERID"
//用户token
#define CT_LOGINUSERTOKEN @"UDKEY_LOGINUSERTOKEN"
//用户推送TOKEN
#define CT_DEVICETOKEN @"UDKEY_DEVICETOKEN"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - -------app版本相关----------

#define BMKKEY @"tLwYdA0oWq7M2j7hVXOvrqOf"

#define YunBaAppKey @"54b4ebd952be1f7e1dd8455f"

//appsore appId
#define APPID_AppStore @"955291651"

#define kUpURL @"kupurl";

#define kIntegralGoodsCacheKey @"kIntegralGoodsCacheKey"

#pragma mark - ------------数据库和表------------

//数据库路径
#define db_path  [NSHomeDirectory() stringByAppendingPathComponent:@"documents/db/jgang.db"]

//用户信息缓存路径
#define userInfoCachPath  [NSHomeDirectory() stringByAppendingPathComponent:@"documents/userInfoModel"]

//用户信息缓存key
#define userInfoKey @"userInfoKey"

//用户运动数据key
#define userMotionInfoKey @"userMotionInfoKey"

//用户睡眠数据key
#define userSleepInfoKey @"userSleepInfoKey"


//缓存数据库名字
#define JingGang_Cache_db  @"JingGang_Cache_db.db"


#pragma mark ---------- 缓存表名-------------
//推荐位，广告缓存表
#define Tuijianwei_ad_cache_table @"Tuijianwei_ad_cache_table"

//推荐位，每日精华缓存表
#define Tuijianwei_perdayjinhua_cache_table @"Tuijianwei_perdayjinhua_cache_table"


#pragma mark ---------------------- 缓存ID名------------------------

#pragma ------广告位
//首页广告ID
#define Tuijianwei_ad_cache_shouyeID @"Tuijianwei_ad_cache_shouyeID"

//生活广告ID
#define Tuijianwei_ad_cache_lifeID @"Tuijianwei_ad_cache_lifeID"

//自测广告ID
#define Tuijianwei_ad_cache_selfTestID @"Tuijianwei_ad_cache_selfTestID"

//社区广告ID
#define Tuijianwei_ad_cache_communityID @"Tuijianwei_ad_cache_communityID"

#pragma ------每日精华
//首页每日精华ID
#define Tuijianwei_perdayessene_cache_shouyeID @"Tuijianwei_perdayessene_cache_shouyeID"

//首页靖港项目缓存
#define Main_jingGangProject_cacheID @"Main_jingGangProject_cacheID"


//生活健康咨询ID
#define Tuijianwei_healthQuery_cache_lifeID @"Tuijianwei_healthQuery_cache_lifeID"

//自测每日精华ID
#define Tuijianwei_perdayessene_cache_selfTestID @"Tuijianwei_perdayessene_cache_selfTestID"

//社区每日精华ID
#define Tuijianwei_perdayessene_cache_communityID @"Tuijianwei_ad_perdayessene_cache_communityID"


#define KHasYoulikeCacheKey @"KHasYoulikeCacheKey"



//缓存数据库
#define jGCaheStore (YTKKeyValueStore*)[[YTKKeyValueStore alloc] initDBWithName:JingGang_Cache_db]

#define MAX_PHYSCIALE_CHECK_TIME_OUT 30

#pragma mark --------------公共类----------------
#define GetToken  [userDefaultManager GetLocalDataString:@"Token"]

#define FounctionNotOpenedAlert  [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"抱歉，该功能暂时未开放"]

#define BoundNibView(viewNibName,ViewClass) (ViewClass *)[[[NSBundle mainBundle] loadNibNamed:viewNibName owner:nil options:nil] lastObject]

//2倍的imgUrl
#define TwiceImgUrlStr(imgUrlStr,width,height) [NSString stringWithFormat:@"%@_%ix%i",imgUrlStr,(int)width*2,(int)height*2]




/////////////////////////////////////////////////////////////////////////////

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
//ColorTalk软件版本
#define pVersion @"1.0"

//屏幕的宽度，屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

// 设备状态栏
#define __StatusScreenFrame             [[UIApplication sharedApplication] statusBarFrame]
// 设备状态栏高度
#define __StatusScreen_Height           __StatusScreenFrame.size.height
#pragma mark - ------------全局常量宏定义---------------

//本地全局数据常量单例
#define kUserInfoSingle [UserInfo shareInstances]
//通知中心全局数据常量单例
#define kNotification [NSNotificationCenter defaultCenter]
//NSUserDefaults 的全局
#define kUserDefaults [NSUserDefaults standardUserDefaults]
//userDeafaul关键字信息
#define kUserDefaultOfkey(key) [kUserDefaults objectForKey:key]

//用户关键字信息
#define userInfoOfKye(key) [[kUserDefaults objectForKey:userInfoKey] objectForKey:key];



//UIApplication
#define kAppDelegate (AppDelegate*)[[UIApplication sharedApplication] delegate]
//按钮的圆角角度
#define m_button_cornerRadius  4.0f
//当前登录用户的UserID
#define LOGIN_USERID CheckString([kUserDefaults stringForKey:CT_LOGINUSERUUID])
//根据uuId，创建不同目录
#define FileDirectoryName MD5(CT_LOGINUSERUUID)
//本地沙盒的路径
#define LocalFilePath [GlobeObject localDocumentPath]
// 默认用户头像
#define kDefaultAvator @"default_user"

#pragma mark - ------------常用方法宏定义---------------

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//根据RGB来获取颜色
#define kGetColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//根据RGBA来获取颜色
#define kGetColorWithAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kPromptColor kGetColorWithAlpha(0, 0, 0, 0.6)
//将对象转换成字符串
#define CheckString(obj) [Util objectToString:obj]
//将int转成NSNumber对象
#define IntToNum(src) [Util intToNumber:src]
//将double转成NSNumber对象
#define DoubleToNum(src) [Util doubleToNumber:src]
//将时间戳格式化成字符串
#define StructsTime(time) [Util stringFromTimeInterval:time]
//系统当前时间戳
#define TimeInterval [Util currentTimeInterval]
//将数字进行MD5加密
#define MD5(src) [src MD5Hash]
#define IntToString(src) [NSString stringWithFormat:@"%ld", (long)src]
#define kNumberToStr(number) [NSString stringWithFormat:@"%@",number]
//保留两位小数,不带元
#define kNumberToStrRemain2Point(number) [NSString stringWithFormat:@"%.2f",number.doubleValue]
//带元
#define kNumberToStrRemain2PointYuan(number) [NSString stringWithFormat:@"%@元",kNumberToStrRemain2Point(number)]

//collectionHeight
#define kCollectionHeight(itemCount,cellHeihgt) ((itemCount % 2 ? (itemCount / 2 + 1) : itemCount / 2) * cellHeihgt)

//根据字符串长度求字符串尺寸
#define kStringSize(str,fSize,str_W,str_H) [str sizeWithFont:[UIFont systemFontOfSize:fSize] constrainedToSize:CGSizeMake(str_W, str_H)]
//打印对象地址
#define DlogObjectAddress(obj) NSLog(@"address is %p",(id)obj);

//navbarColor
#define NavBarColor kGetColor(94, 180, 231)

#define status_color  [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1]

static inline BOOL isEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
    
}

#define UNLOGIN_HANDLE  if (isEmpty(GetToken)) {\
[VApiManager handleNeedTokenError];\
return;\
}


@interface GlobeObject : NSObject
/**
 *  获取本地沙河文件的存储路径
 *
 *  @return 沙河路径
 */
+(NSString *)localDocumentPath;

//体检报告创建时间和创建的id
#define kMERTime @"MERCreateTime"
#define kMERID   @"MERCreateID"

/**
 *  敏感词提示
 */
#define KSensitiveWords  [Util ShowAlertWithOnlyMessage:@"发布的帖子中包含敏感信息词，请核对修改后再发布"];





@end
