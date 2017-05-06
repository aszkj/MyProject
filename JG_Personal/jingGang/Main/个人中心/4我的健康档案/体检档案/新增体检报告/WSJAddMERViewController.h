//
//  WSJAddMERViewController.h
//  jingGang
//
//  Created by thinker on 15/10/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XK_ViewController.h"


typedef enum : NSUInteger {
    kAddMERType,  //新增体检报告
    kEditMERType, //修改体检报告
} MERViewControlerType;


@interface WSJAddMERViewController : XK_ViewController

@property (nonatomic, assign) MERViewControlerType type;

@property (nonatomic,copy) NSNumber *api_id;  //体检报告id
@property (nonatomic,copy) NSString *strReportName;//报告名称，由报告详情页面传来
@property (nonatomic,copy) NSString *strCheckHospital;//检查机构名称，由报告详情页面传来
@property (nonatomic,copy) NSString *strYear;//年份
@property (nonatomic,copy) NSString *strMonth;//月
@property (nonatomic,copy) NSString *strDay;//日
@property (nonatomic,assign) BOOL isComePhysicalReportDetailVc;//是否来自体检详情页面

@end
