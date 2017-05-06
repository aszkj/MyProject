//
//  XK_ViewController.h
//  jingGang
//
//  Created by ray on 15/10/20.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+FBKVOController.h"
#import "PublicInfo.h"
#import "Masonry.h"
#import "GlobeObject.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "XKO_ViewModel.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "MJExtension.h"
#import "NSObject+FBKVOController.h"
#import "UIView+Loading.h"
#import "VApiManager.h"

@interface XK_ViewController : UIViewController
/**
 *  是否关闭默认的弹窗样式
 */
@property (nonatomic) BOOL closeDefaultErrorInform;
/**
 *  网络请求对象
 */
@property (nonatomic, strong) VApiManager *vapiManager;

/**
 *  统一设置界面UI，如颜色,字体，圆角等
 */
- (void)setUIAppearance;
/**
 *  统一绑定UI数据及逻辑判断等
 */
- (void)bindViewModel;
/**
 *  控制器处理网络错误
 *
 *  @param error 错误信息
 */
- (void)errorHandle:(NSError *)error;
/**
 *  控制器处理服务器错误
 *
 *  @param error 错误信息
 */
- (void)specErrorHandle:(NSError *)error;
@end
