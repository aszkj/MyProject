//
//  PublicInfo.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#ifndef jingGang_PublicInfo_h
#define jingGang_PublicInfo_h


#import "GlobeObject.h"

//对象释放部分宏定义

//安全释放的宏定义
#define OBJ_RELEASE(delegete)    @try\
{\
[delegete release];\
delegete = nil;\
}\
@catch(NSException *ex)\
{\
NSLog(@"Wild pointer error:%@",ex);\
}\
@finally\
{\
}


//界面元素相关宏定义

// 设备屏幕大小
#define __MainScreenFrame               [[UIScreen mainScreen] bounds]
// 设备屏幕宽
#define __MainScreen_Width              __MainScreenFrame.size.width
// 设备屏幕高
#define __MainScreen_Height             __MainScreenFrame.size.height
// 设备状态栏
#define __StatusScreenFrame             [[UIApplication sharedApplication] statusBarFrame]
// 设备状态栏高度
#define __StatusScreen_Height           __StatusScreenFrame.size.height
// 设备导航条大小
#define __NavScreenFrame                self.navigationController.navigationBar.frame
// 设备导航高度
#define __NavScreen_Height              __NavScreenFrame.size.height

// 导航栏和状态栏后的高度
#define __Other_Height                  __StatusScreen_Height + __NavScreen_Height

// baseView界面界定按钮大小
#define __btnBounds                     40
#define __btnBounds_4                   35

//topBar的高度
#define kTopBarHeight  44
//一般表距离上面的间隔
#define kTopEdge 10
//状态栏和导航栏的高度
#define kStatuBarAndNavBarHeight 64
// 默认圆角
#define kRadius                     4
#define IMAGE(image)               [UIImage imageNamed:image]

//主界面各个单元格高度
#define __table_cell1_h                 85
#define __table_cell2_h                 185
#define __table_cell3_h                 85
#define __table_section_h               30
//生活界面单元格高
#define __life_table_cell1_h            85
//健康自测界面单元格高度
#define __text_table_cell1_h             65
#define __text_table_cell2_h             110
//社区界面单元格高度
#define __commu_tab_cell2_h              105
#define __commu_child_tab_cell1_h        115
#define __commu_child_tab_section_h      28
//扫描外设的单元格高度
#define __mydeviese_tab_cell_h           73

#define VCBackgroundColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]

// TabBar颜色白色
#define TabBar_Bg_Color                 [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]
#define TabBar_selec_Color              [UIColor colorWithRed:95.0f/255.0f green:182.0f/255.0f blue:233.0f/255.0f alpha:1.0f]
#define Label_Selected_Color            [UIColor colorWithRed:70.f/255.0f green:203.f/255.0f blue:179.f/255.0f alpha:1.0f]
#define color_no                        [UIColor colorWithRed:200.f/255.0f green:235.f/255.0f blue:202.f/255.0f alpha:1.0f]
// 切换 tabbar成功
#define kNotification_Switch_TabBar_Finished                    @"have_changed_tabBar_finished"
//通过三色值获取颜色对象
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//登录界面元素高度
#define loginbtn_h                       222
#define loginbtn_h2                      165
//登陆注册界面颜色值
#define color_loginBtn_1                        [UIColor colorWithRed:0.f/255.0f green:233.f/255.0f blue:189.f/255.0f alpha:1.0f]
#define color_loginBtn_2                        [UIColor colorWithRed:0.f/255.0f green:190.f/255.0f blue:161.f/255.0f alpha:1.0f]
#define color_registBtn_1                        [UIColor colorWithRed:242.f/255.0f green:169.f/255.0f blue:84.f/255.0f alpha:1.0f]
#define color_registBtn_2                        [UIColor colorWithRed:219.f/255.0f green:150.f/255.0f blue:70.f/255.0f alpha:1.0f]

//main界面各区头字体颜色
#define color_section_1                        [UIColor colorWithRed:70.f/255.0f green:187.f/255.0f blue:208.f/255.0f alpha:1.0f]
#define color_section_3                        [UIColor colorWithRed:66.f/255.0f green:169.f/255.0f blue:149.f/255.0f alpha:1.0f]

//heathVc界面和自界面色值
#define health_color_1                          [UIColor colorWithRed:97/255.f green:204/255.f blue:115/255.f alpha:1]
//userTest界面元素颜色值
#define test_color_1                            [UIColor colorWithRed:1.f/255.0f green:187.f/255.0f blue:120.f/255.0f alpha:1.0f]
//communit界面颜色
#define communit_color_1                            [UIColor colorWithRed:90.f/255.0f green:196.f/255.0f blue:261.f/255.0f alpha:1.0f]

//公共使用部分的宏定义
#define showAlertVc(errorMessage)              UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前网络不可用，请打开或断开网络连接后重试。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertVc show];[alertVc release];

#define checkVirsion                      @"http://itunes.apple.com/lookup?id"
#define APP_STORE_ID                      @""//应用在appStore上面的ID

//http://shop.jgyes.com/goods_793_gcase.htm
//http://shop.jgyes.com/group/store.htm?id=29
//http://shop.jgyes.com/group/view_51.htm

#define kGoodsShareUrlWithID(ID)  [NSString stringWithFormat:@"http://shop.jgyes.com/goods_%@_gcase.htm",ID]
#define kServiceShareUrlWithID(ID) [NSString stringWithFormat:@"http://shop.jgyes.com/group/store.htm?id=%@",ID]
#define kMerchantShareWithID(ID) [NSString stringWithFormat:@"http://shop.jgyes.com/group/view_%@.htm",ID]



#define kInvitationShareTitle1(integral) [NSString stringWithFormat:@"噢耶！我已轻松加入云e生，且获取%@积分！\
",integral]
#define kInvitationShareDescription1(integral) [NSString stringWithFormat:@"噢耶！我已轻松加入云e生，且获取%@积分，积分可兑换商品！速点！\
",integral]
#define kInvitationShareDescription2(integral) [NSString stringWithFormat:@"加入云e生，立马赠送%@积分，积分可兑换商品！速点！\
",integral]
#define kLogShareUrl @"http://static.jgyes.com/static/person.png"
//#define kWeiboShareContent(invitationCode,giveIngertal) [NSString stringWithFormat:@"%@http:// %@",kInvitationShareDescription1(giveIngertal),kInvitationCodeShareUrlCode(invitationCode)]
//

#define kWeiboShareContent(invitationCode,giveIngertal) [NSString stringWithFormat:@"%@%@/mobile_register.htm?invitationCode=%@",giveIngertal,Shop_url,invitationCode]

#define kInvitationCodeShareUrlCode(invitationcode) [NSString stringWithFormat:@"%@/mobile_register.htm?invitationCode=%@",Shop_url,invitationcode]


//分享界面图片和url
#define k_ShareImage @"http://static.jgyes.com/static/person.png"
//@"http://f1.jgyes.com/1,20bc0e8abf0f"
//#define k_ShareURL   @"http://static.jgyes.com/static/platform/appDownload.jsp"
#define k_ShareURL   @"http://static.jgyes.com/person.html"
//#define physical_ShareUrl @"http://static.jgyes.com/static/platform/appDownload.jsp"
#define k_ShareDec  @"在云e生发现这个服务很不错哦！快来下载吧！http://static.jgyes.com/static/platform/appDownload.jsp"
#define k_DownAppUrl @"http://static.jgyes.com/static/platform/appDownload.jsp"
//#define kGetColor(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static inline BOOL IsEmpty(id thing) {
    
    return thing == nil || [thing isEqual:[NSNull null]]
    
    || ([thing respondsToSelector:@selector(length)]
        
        && [(NSData *)thing length] == 0)
    
    || ([thing respondsToSelector:@selector(count)]
        
        && [(NSArray *)thing count] == 0);
    
}

#define KMarginLeft                 10   // 左右间距
#define KMarginTop                  10   // 上下间距
#define KMarginVertical             2.5
#define kMarginHorizontal           5

#define kEdgeInsetTop               4
#define kEdgeInsetLeft              10
#define kEdgeInsetBottom            10
#define kEdgeInsetRight             10
#define kMinimumInteritemSpacing    10   //collectionviewcell 左右间距
#define kMinimumLineSpacing         15   //collectionviewcell 上下间距

//状态栏颜色
#define status_color                     [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1]
#define textBlackColor UIColorFromRGB(0x333333)
#define textGrayColor UIColorFromRGB(0x666666)
#define textLightGrayColor UIColorFromRGB(0x999999)
#define background_Color UIColorFromRGB(0xEAEBEC)

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

#define KColorText333333                UIColorFromRGB(0X333333)
#define KColorText59C4F0                UIColorFromRGB(0X59C4F0)
#define KColorText5AC4F1                UIColorFromRGB(0X5AC4F1)
#define KColorText0b5f9b                UIColorFromRGB(0X0b5f9b)
#define KColorText666666                UIColorFromRGB(0X666666)
#define KColorText999999                UIColorFromRGB(0X999999)

#import "NSObject+ApiResponseErrFliter.h"


#pragma mark - ------------ 【商户详情页】的分享内容  -------------

////#define share_merchantTitle(title)        [NSString stringWithFormat:@"噢耶！我的%@已轻松入驻云e生",title]
//#define share_merchantContent(invitCode)  [NSString stringWithFormat:@"使用我的邀请码%@加入云e生，立马享受更多入驻优惠！好商机，速点！打开方式：下载云e生商户APP的链接地址%@",invitCode,share_URL]
//#define share_merchantImage               @"http://static.jgyes.com/static/merchant.png"
//#define share_merchantURL                 @"http://static.jgyes.com/person.html"






#endif
