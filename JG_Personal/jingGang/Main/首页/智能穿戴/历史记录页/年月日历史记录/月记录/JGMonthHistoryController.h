//
//  JGMonthHistoryController.h
//  jingGang
//
//  Created by HanZhongchou on 16/2/26.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "XK_ViewController.h"

typedef enum : NSUInteger {
    monthHistoryType,//月记录
    yearHistoryType,//年纪录
}yearMonthHistoyeType;

@class historyViewController;
@interface JGMonthHistoryController : XK_ViewController

@property (nonatomic,strong) historyViewController *historyViewController;

@property (nonatomic,assign) yearMonthHistoyeType yearMonthHistoyeType;

/**
 *  标题
 */
@property (nonatomic,copy) NSString *strTitle;

@end
