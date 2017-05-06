//
//  SelftestDetailVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BeginTest_Type, //开始测试
    TestDetail_Type,//详情
} TestDetailType;

@interface SelftestDetailVC : UIViewController

@property (nonatomic,assign)long self_Test_DetailID;

@property (nonatomic,assign)TestDetailType testDetailType;

@property (nonatomic, copy)NSString *selfTestTitle;


@end
