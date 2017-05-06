//
//  addClockViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addClockViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>

@property(nonatomic, copy)NSString     *H_str;//小时
@property(nonatomic, copy)NSString     *M_str;//分钟
@property(nonatomic, copy)NSString     *name_str;

@end
