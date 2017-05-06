//
//  PushNofiticationController.h
//  jingGang
//
//  Created by HanZhongchou on 16/1/18.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "XK_ViewController.h"

typedef NS_ENUM(NSUInteger, ControllerMyUrlType) {
    RichTextlControllerType = 0,  // 链接类型
    InterLinkageControllerType     // 富文本类型
};

@interface PushNofiticationController : XK_ViewController
@property (assign, nonatomic) ControllerMyUrlType urlType;
/**
 *  推送过来的url
 */
@property (nonatomic,copy) NSString *strPushUrl;

/**
 *  富文本的UrlID
 */
@property (nonatomic,copy) NSString *strUrlID;


/**
 *  页面的title
 */
@property (nonatomic,copy) NSString *strControllerTitle;
@end
