//
//  Global.h
//  BaiYing_Thinker
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

//IM主机
#define KPort         1883
#define KUploadPort   8090
#define kTopic  @"WEME_SERVICE_TOPIC"
#define KClientID     @"1009287737"
#define KSecret       @"72ee5476e9b3fc62c4f7faff7d41614a"

//#define WeimiSP_TestHost  1

#ifdef WeimiSP_TestHost
//测试环境
#define authUrl       @"http://test.auth.thinker.vc/"
#define kApiUrl       @"http://test.api.thinker.vc/"
#define kIP           @"120.24.225.163"
#else
//开发环境
#define authUrl       @"http://auth.thinker.vc/"
#define kApiUrl       @"http://api.thinker.vc/"
#define kIP           @"mq.thinker.vc"
#endif

#define KBottomHeight               60
#define KTextBottomHeight           60
#define KVoiceBottomHeight          50
#define KContentBottomHeight        150
#define KTopHeight              50
#define KSessionTopHeight       50
#define kSessionCardHeight      90

//UI设计师写的规范文档:项目通用字体,字体
#define KNormalFont     [UIFont CustomFontOfSize:16.0]
#define KBigFont        [UIFont CustomFontOfSize:18.0]
#define KSmallFont      [UIFont CustomFontOfSize:13.0]

#define kWhiteColor     UIColorFromRGB(0xffffff)
#define kGrayColor      UIColorFromRGB(0x727272)
#define kLightGrayColor UIColorFromRGB(0x898989)
#define kLightestGrayColor UIColorFromRGB(0xc0c0c0)
#define kOrangeColor    UIColorFromRGB(0xf77705)
#define kRedColor       UIColorFromRGB(0xff0000)
#define kBlueColor      UIColorFromRGB(0x008aff)
#define kLightBlueColor UIColorFromRGB(0x00e5ff)

#define kCustomSpacing  13

#define kClearColor     [UIColor clearColor]
//tableView线颜色
#define  SeparatorColor [UIColor colorWithRed:138/255 green:138/255 blue:138/255 alpha:0.3]
#define  ViewBackgroundColor [UIColor colorWithRed:1 green:1 blue:1 alpha:0.05]


//联调主机

#define KImageWidth             200
#define KImageHeight            200

#define chatStatus_Color  UIColorFromRGB(0X33b5e5)
#define status_color                     [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1]
#define background_Color                     [UIColor colorWithRed:240/255.0 green:239/255.0 blue:237/255.0 alpha:1.0]
#define Background_Image self.view.backgroundColor = [UIColor colorWithPatternImage:IMAGE(@"backgroundImg")];

#define normalbackGround_Color [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
#define kColorNavText          kGetColor(255, 255, 255)  
#define kColorNav              kGetColor(62, 64, 66)

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
#define KMaxTopMargin               15   // 上下间距
#define KMaxLeftMargin              30   // 左右间距
#define kEdgeInsetLeft              40/3.0 
#define kEdgeInsetTop               10
#define kEdgeInsetBottom            10
#define kEdgeInsetRight             20
#define kFixedClearance             30
#define kEdgeInsetVerticalSpacing   25  //聊天cell上下间距

#define kComponentLeftMargin        60

#define kFontSizeBold11             [UIFont boldSystemFontOfSize:11]
#define kFontSizeBold12             [UIFont boldSystemFontOfSize:12]
#define kFontSizeBold13             [UIFont boldSystemFontOfSize:13]
#define kFontSizeBold14             [UIFont boldSystemFontOfSize:14]
#define kFontSizeBold15             [UIFont boldSystemFontOfSize:15]
#define kFontSizeBold16             [UIFont boldSystemFontOfSize:16]

#define kFontSize11                 [UIFont CustomFontOfSize:11]
#define kFontSize12                 [UIFont CustomFontOfSize:12]
#define kFontSize13                 [UIFont CustomFontOfSize:13]
#define kFontSize14                 [UIFont CustomFontOfSize:14]
#define kFontSize15                 [UIFont CustomFontOfSize:15]
#define kFontSize16                 [UIFont CustomFontOfSize:16]

#define VCBackgroundColor UIColorFromRGB(0xf1f3f8)
#define KColorText333333                UIColorFromRGB(0X333333)
#define KColorText59C4F0                UIColorFromRGB(0X59C4F0)
#define KColorText5AC4F1                UIColorFromRGB(0X5AC4F1)
#define KColorText0b5f9b                UIColorFromRGB(0X0b5f9b)
#define KColorText666666                UIColorFromRGB(0X666666)
#define KColorText999999                UIColorFromRGB(0X999999)
//百应颜色
#define KColorTextF1F1F1                UIColorFromRGB(0XF1F1F1)
//#define KColorOfTransparent             [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]
#define KColorOfTransparent             UIColorFromRGB(0X33373c)

//屏幕的宽度，屏幕的高度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
// 设备状态栏
#define __StatusScreenFrame             [[UIApplication sharedApplication] statusBarFrame]
// 设备状态栏高度
#define __StatusScreen_Height           __StatusScreenFrame.size.height

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

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
#define kAppDelegate               ((AppDelegate *)([UIApplication sharedApplication].delegate))
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
#define kStringSize(str,fSize,str_W,str_H) [str sizeWithFont:[UIFont CustomFontOfSize:fSize] constrainedToSize:CGSizeMake(str_W, str_H)]
//打印对象地址
#define DlogObjectAddress(obj) NSLog(@"address is %p",(id)obj);

#define BoundNibView(viewNibName,ViewClass) (ViewClass *)[[[NSBundle mainBundle] loadNibNamed:viewNibName owner:nil options:nil] lastObject]

//2倍的imgUrl
#define TwiceImgUrl(imgUrlStr,width,height) [NSURL URLWithString:[NSString stringWithFormat:@"%@_%ix%i",imgUrlStr,(int)width*2,(int)height*2]]

#define kNumberToStr(number) [NSString stringWithFormat:@"%.2f",number.doubleValue]

#define kGetColor(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kSystemFontWithSize(size) [UIFont CustomFontOfSize:size]
#define Token @"accessToken"
#define KInvalidTokenErrorCode     @"您的账号已失效,请重新登录!"

#define GetToken  [kUserDefaults objectForKey:Token]

#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width

#define TR_COLOR_RGBACOLOR_A(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define NARBAR_Y 20
#define ANIMATIONDURATION 0.3
#define TR_TEXTCOLOR TR_COLOR_RGBACOLOR_A(116, 116, 116, 1.0)
#define TR_MAINBACKGROUNDCOLOR TR_COLOR_RGBACOLOR_A(253, 63, 29, 1.0)
#define ROOTVIEW [ShareMethod getRootView].rootViewController.view

#define ROOTVC [ShareMethod getRootView].rootViewController

//录音目录
#define kPathOfLuyin  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/luyin.caf"]
#define kPathOfMP3    [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/luyin.mp3"]
#define kPathOfPCM    [[[FileMangeHelper shareInstance] libCachePath] stringByAppendingPathComponent:@"luyin.pcm"]
#define AliFile(file) [[[FileMangeHelper shareInstance] getUploadPathFromFileType:UploadFileAudioType] stringByAppendingPathComponent:file]

//通知中心全局数据常量单例
#define kNotification [NSNotificationCenter defaultCenter]
//收到新消息
#define kNotificationReceiveNewMessage @"ReceiveNewMessage"
#define kNotificationUpdateMessage     @"UpadteMessage"
#define KMessageParameter              @"ReceiveMessageKey"
#define KMessageParameterSequel        @"ReceiveMessageSequelKey"
#define KMessageParameterId            @"ReceiveMessageIdKey"
#define KMessageParameterLocalId       @"ReceiveMessageLocalIdKey"
#define KMessageParameterSubjectIndex  @"ReceiveMessageSubjectIndexKey"
#define kNotificationNetworkChangedMessage @"kNotificationNetworkChangedMessage"
#define kNotificationTaskStateChangedMessage @"kNotificationTaskStateChangedMessage"
#define kNotificationMqttStateChangedMessage @"kNotificationMqttStateChangedMessage"
#define kNotificationStatusChanged     @"MessageStatusChanged"

#define kPullFeedNotification            @"PullFeedNotification"
#define kPullMyReplyNotification         @"PullMyReplyNotification"
#define kPullReciveFeedNotification      @"PullReciveFeedNotification"
#define kPullMyFeedReplayNotification    @"PullMyFeedReplayNotification"

#define kNotificationUpdateChannel     @"UpdateChannel"
#define kNotificationMessageIsReached  @"MessageIsReached"
#define kNotificationReadMessage       @"ReadMessage"
#define kNotificationChatBeginMoving   @"ChatBeginMoving"
#define KNotificationUpdatePath        @"UpdatePath"
#define KNotificationUpdateAvatar      @"UpdateAvatar"

#define kNotificationSendNewMessage    @"SendNewMessage"

//NSUserDefaults 的全局
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kLocalSessionId   @"WEME_WORKER_"                  //自定义session_id
#define KNoDataCode              @"9999"
#define KDataOfWelcomeCode       @"1005"
#define KWeimiIndexPath          @"weimi_indexPath"
#define KWeimiLastSubject_id    @"lastSubject_id"
#define KWeimiLastSession_id    @"lastSession_id"

//科大讯飞参数
#define APPID_VALUE           @"5630ae93"

//MQTT系统消息参数
#define KParameter1000          @"1000"
#define KParameter1001          @"1001"
#define KParameter1002          @"1002"
#define KParameter1003          @"1003"
#define KParameter1004          @"1004"
#define KParameter1005          @"1005"
#define KParameter1006          @"1006"
#define KParameter1007          @"1007"
#define KParameter1008          @"1008"
#define KParameter1009          @"1009"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define MB_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif


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

//聊天间隔5分钟显示时间
#define kChatSpacingTime (60 * 5)
//聊天发送超时时间
#define kChatSendOvertime 30

#pragma mark - ------ 分享配置数据、百度地图key值 -------

#define k_BaiduMapKey @"j0Ft0VZca1GGvNlWGgdaildY"

//Mob share分享appkey,secret
#define Mob_share_key @"afefcce1c458"
#define Mob_share_secret @"f3e6b20f30e020f11910c5c1e020ea42"


//微信appID,secret
#define Weixin_AppID @"wx200c3161c5d9efc4"
#define Weixin_AppSecret @"0ea8100e0755ea3c84e344a712ef297e"


//新浪微博
#define Weibo_Appkey @"2091552150"
#define Weibo_AppSecret @"1f8cc4726000567e187af2dd65f81ec7"
#define Default_Redirect_URL @"https://api.weibo.com/oauth2/default.html"


//腾讯平台
#define Tencent_AppKey @"1104826381"
#define Tencent_Secret @"mn5nBvRGXQzAmH4R"

/* * * * * * * * ** * * * 支付宝参数 * * * * * * * * * * * */

#define kParameterAlipayPartner                 @"2088101040490920";
#define kParameterAlipaySeller                  @"jxufe427wbt@yeah.net";
#define kParameterAlipayPrivateKey              @""
#define kParameterAlipayNotifyUrl                @"http://202.104.150.151:1688/notify_url.aspx"

/* * * * * * * * ** * * * 支付宝参数 * * * * * * * * * * * */

/* * * * * * * * ** * * * 微信支付参数 * * * * * * * * * * * */

#define kParameterWXApiAppID                     @"wxd930ea5d5a258f4f"

/* * * * * * * * ** * * * 微信支付参数 * * * * * * * * * * * */

