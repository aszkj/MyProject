//
//  GuideViewController.h
//  Movie
//
//  Created by Mac on 14-8-27.
//  Copyright (c) 2014年 Mac. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController

/** 引导页面
 * 第一次进来
 * 引导页面（ViewController） view - scrollView - imageView
 * self.window.rootViewController - GuideViewController
 * self.window.rootViewController - MainViewController
 *
 * flag，持久到磁盘中[数据持久化 : 属性列表化、归档、NSUserDefault、Sqlite、Core Data]
 *
 * 第二次进来
 *
 * flag【change】，不再调用引导页面
 */

// 类，轻量级，使用简单

// 当程序升级时，由1.0到2.0 Documents和Library文件会被保留下来
/**
 * iTunes :
 * Documents ：同步Documents
 * Library ：应用程序的偏好设置【同步】，缓存caches
 * tmp  ： 临时文件，系统自动清理文件
 * bundle 包【应用程序】
 */


@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;



@end
