//
//  PhysicalReportDetailController.h
//  jingGang
//
//  Created by HanZhongchou on 15/10/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "XK_ViewController.h"

@interface PhysicalReportDetailController : XK_ViewController

/**
 *  报告id
 */
@property (nonatomic, copy) NSNumber *apiId;

@property (nonatomic,copy)NSString *strYear;//报告日期年
@property (nonatomic,copy)NSString *strMonth;//报告日期月
@property (nonatomic,copy)NSString *strDay;  //报告日期日
@end
