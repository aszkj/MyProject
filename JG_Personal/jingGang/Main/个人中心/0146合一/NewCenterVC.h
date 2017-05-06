//
//  NewCenterVC.h
//  jingGang
//
//  Created by wangying on 15/5/29.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

//我的收藏  档案
@interface NewCenterVC : UIViewController
@property(assign,nonatomic)NSInteger index; //点击那个界面
@property (nonatomic, copy)NSString  *witch;//接收来自主界面传过来得多字符串
@end
