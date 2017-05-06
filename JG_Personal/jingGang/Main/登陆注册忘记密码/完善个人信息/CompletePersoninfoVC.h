//
//  CompletePersoninfoVC.h
//  jingGang
//
//  Created by 张康健 on 15/6/23.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Registe_Commin,//从注册中完善
    Show_huan_Commin,//手环信息进入
} ComminTypePersonInfo;

@interface CompletePersoninfoVC : UIViewController

@property (nonatomic,assign)ComminTypePersonInfo comminTypeInfo;
@property (nonatomic,copy)NSString *addressString;

@end
