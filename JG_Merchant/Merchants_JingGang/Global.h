//
//  Global.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. /Users/pengzhu/Library/Developer/Xcode/DerivedData/Merchants_JingGang-bqmhcvbervtffudjzllwmttxwwqx/Build/Products/Release-iphoneos/Merchants_JingGang.appAll rights reserved.
//

//测试环境
#define BaseAuthUrl @"http://auth.jgyes.cn"
#define BaseUrl     @"http://api.jgyes.cn"

// jg_ 测试环境
//#define BaseAuthUrl @"http://auth.jgclub.cn"
//#define BaseUrl     @"http://api.jgyclub.cn"


//测试环境
#define BaseAuthUrl @"http://auth.jgyes.cn"
#define BaseUrl     @"http://api.jgyes.cn"
#define StaticBase_Url @"http://static.jgyes.cn"
#define Shop_url @"http://shop.jgyes.cn"
#define kJPushEnvirStr @"t_"
//// jg_ 测试环境
//#define BaseAuthUrl @"http://auth.jgclub.cn"
//#define BaseUrl     @"http://api.jgyclub.cn"

 
//线上环境
//#define BaseAuthUrl @"http://auth.jgyes.com"
//#define BaseUrl     @"http://api.jgyes.com"
//#define StaticBase_Url @"http://static.jgyes.com"
//#define Shop_url @"http://shop.jgyes.com"
//#define kJPushEnvirStr @"p_"






//登录验证clientID
#define AuthenClientID @"carnation-merchant-ios"
//登录验证secret
#define AuthenSecret @"0d3063b6-f382-43cf-8693-03c27406f90b"


//联调主机
#define TestDomainBaseUrl @"http://192.168.1.50:8089"

#define status_color                     [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1]
#define background_Color                     [UIColor colorWithRed:240/255.0 green:239/255.0 blue:237/255.0 alpha:1.0]

#define normalbackGround_Color [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]



//topBar的高度
#define kTopBarHeight  44
//表距离tapBar的间隔
#define kTableToTopbarGap 10

#define kNavBarAndStatusBarHeight 64
#define kNavBarAndStatusBarAndTopBarHeight 108


#define iPhone4_width 320
#define iPhone5_width 320
#define iPhone6_width 375
#define iPhone6p_width 414

#define iPhone4_Height 480
#define iPhone5_Height 568
#define iPhone6_Height 667
#define iPhone6P_Height 736

#define kRadius                     3    // 默认圆角

#define KLeftMargin                 10   // 左右间距
#define KTopMargin                  10   // 上下间距
#define kEdgeInsetTop               4
#define kEdgeInsetLeft              8
#define kEdgeInsetBottom            10
#define kEdgeInsetRight             8
#define kMinimumInteritemSpacing    10   //collectionviewcell 左右间距
#define kMinimumLineSpacing         15   //collectionviewcell 上下间距

#define kFontSizeBold11             [UIFont boldSystemFontOfSize:11]
#define kFontSizeBold12             [UIFont boldSystemFontOfSize:12]
#define kFontSizeBold13             [UIFont boldSystemFontOfSize:13]
#define kFontSizeBold14             [UIFont boldSystemFontOfSize:14]
#define kFontSizeBold15             [UIFont boldSystemFontOfSize:15]
#define kFontSizeBold16             [UIFont boldSystemFontOfSize:16]

#define kFontSize11                 [UIFont systemFontOfSize:11]
#define kFontSize12                 [UIFont systemFontOfSize:12]
#define kFontSize13                 [UIFont systemFontOfSize:13]
#define kFontSize14                 [UIFont systemFontOfSize:14]
#define kFontSize15                 [UIFont systemFontOfSize:15]
#define kFontSize16                 [UIFont systemFontOfSize:16]

#define VCBackgroundColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
#define KColorText333333                UIColorFromRGB(0X333333)
#define KColorText59C4F0                UIColorFromRGB(0X59C4F0)
#define KColorText5AC4F1                UIColorFromRGB(0X5AC4F1)
#define KColorText0b5f9b                UIColorFromRGB(0X0b5f9b)
#define KColorText666666                UIColorFromRGB(0X666666)
#define KColorText999999                UIColorFromRGB(0X999999)

//屏幕的宽度，屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
// 设备状态栏
#define __StatusScreenFrame             [[UIApplication sharedApplication] statusBarFrame]
// 设备状态栏高度
#define __StatusScreen_Height           __StatusScreenFrame.size.height

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

#define kCurrentKeyWindow    [UIApplication sharedApplication].keyWindow
#define IMAGE(image)               [UIImage imageNamed:image]
#define kPageSize                  [NSNumber numberWithInteger:5]

#define WEAK_SELF                   __weak typeof(self) weak_self = self;
#define WEAK_OBJECT(weak_obj, obj)  __weak typeof(obj) weak_obj = obj;

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IntToString(src) [NSString stringWithFormat:@"%ld", (long)src]
//根据字符串长度求字符串尺寸
#define kStringSize(str,fSize,str_W,str_H) [str sizeWithFont:[UIFont systemFontOfSize:fSize] constrainedToSize:CGSizeMake(str_W, str_H)]
//打印对象地址
#define DlogObjectAddress(obj) NSLog(@"address is %p",(id)obj);

#define BoundNibView(viewNibName,ViewClass) (ViewClass *)[[[NSBundle mainBundle] loadNibNamed:viewNibName owner:nil options:nil] lastObject]

//2倍的imgUrl
#define TwiceImgUrlStr(imgUrlStr,width,height) [NSString stringWithFormat:@"%@_%ix%i",imgUrlStr,(int)width*2,(int)height*2]

#define kNumberToStr(number) [NSString stringWithFormat:@"%.2f",number.doubleValue]

#define kGetColor(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define Token @"access_token"

#define GetToken  [kUserDefaults objectForKey:Token]

//通知中心全局数据常量单例
#define kNotification [NSNotificationCenter defaultCenter]
//NSUserDefaults 的全局
#define kUserDefaults [NSUserDefaults standardUserDefaults]

//商户ID UserDefaultsKey
#define kUserDefaultsUserIDKey @"userDefaultsUserID"
//是否O2O UserDefaultsKey
#define kUserDefaultsIsO2OKey @"userDefaultsIsO2O"

typedef void(^ClickIndexPathBlock)(id deliverObj);

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

static inline BOOL IsEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
}

#pragma mark - ------ 分享配置数据、百度地图key值 -------

#define k_BaiduMapKey @"j0Ft0VZca1GGvNlWGgdaildY"

//Mob share分享appkey,secret
#define Mob_share_key @"83e8a9b3e0f8"
#define Mob_share_secret @"316cae137f9900fe75ecc6c65e04ea1c"


//微信appID,secret
#define Weixin_AppID @"wxd233ef2eecfd4d45"
#define Weixin_AppSecret @"32d36491975aefb7fb5ae73bfcd74b01"


//新浪微博
#define Weibo_Appkey @"959489958"
#define Weibo_AppSecret @"a18126534f63e8ac298e93734ec6094f"
#define Default_Redirect_URL @"https://api.weibo.com/oauth2/default.html"


//腾讯平台
#define Tencent_AppKey @"1104826353"
#define Tencent_Secret @"xWQx4gRyTc7EgCBf"

typedef enum : NSUInteger {
    PoserOperater_Send,
    PosterPlat_Send,
} PosterType;


#pragma mark - ------------ 分享内容 -------------

//#define kInvitationCodeShareUrlCode(invitationcode) [NSString stringWithFormat:@"shop.jgyes.com/mobile_register.htm?invitationCode=%@",invitationcode]
#define kInvitationShareTitle1(integral) [NSString stringWithFormat:@"噢耶！我已轻松加入云e生，且获取%@积分！\
",integral]


#define kWeiboShareContent(invitationCode,giveIngertal) [NSString stringWithFormat:@"%@%@/mobile_register.htm?invitationCode=%@",giveIngertal,Shop_url,invitationCode]

#define kInvitationCodeShareUrlCode(invitationcode) [NSString stringWithFormat:@"%@/mobile_register.htm?invitationCode=%@",Shop_url,invitationcode]


#define kInvitationShareDescription1(integral) [NSString stringWithFormat:@"噢耶！我已轻松加入云e生，且获取%@积分，积分可兑换商品！速点！\
",integral]
#define kInvitationShareDescription2(integral) [NSString stringWithFormat:@"加入云e生，立马赠送%@积分，积分可兑换商品！速点！\
",integral]
#define kLogShareUrl @"http://static.jgyes.com/static/person.png"
//#define kWeiboShareContent(invitationCode,giveIngertal) [NSString stringWithFormat:@"%@http://shop.jgyes.com/mobile_register.htm?invitationCode=%@",kInvitationShareDescription1(giveIngertal),invitationCode]




#define share_title(title)        [NSString stringWithFormat:@"噢耶！我的%@已轻松入驻云e生",title]
#define share_content(invitCode)  [NSString stringWithFormat:@"使用我的邀请码%@加入云e生，立马享受更多入驻优惠！好商机，速点！打开方式：下载云e生商户APP的链接地址%@",invitCode,share_URL]
#define share_image               @"http://static.jgyes.com/static/merchant.png"
#define share_URL                 @"http://static.jgyes.com/merchant.html"


#define  kNotificationOffShelfChanged   @"kNotificationOffShelfChanged"
#define  kNotificationAddShelfChanged   @"kNotificationAddShelfChanged"
