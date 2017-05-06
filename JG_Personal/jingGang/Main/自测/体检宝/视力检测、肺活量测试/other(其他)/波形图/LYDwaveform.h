//
//  LYDwaveform.h
//  波形图
//
//  Created by Dong on 14-3-14.
//  Copyright (c) 2014年 CNTV. All rights reserved.
//

/* 波形图
 //开启定时器
[timer setFireDate:[NSDate distantPast]];
 //关闭定时器
 [timer setFireDate:[NSDate distantFuture]];
 */

#import <UIKit/UIKit.h>

@interface LYDwaveform : UIView
{
    float swing;
    int   i;
    float j;
}



@property (nonatomic, assign) NSInteger height;//波形高度

@property (nonatomic, assign) CGFloat radian;//波形弧度

@property (nonatomic, assign) NSInteger frequency;//频率


- (void)callDraw:(float)f;

@end
