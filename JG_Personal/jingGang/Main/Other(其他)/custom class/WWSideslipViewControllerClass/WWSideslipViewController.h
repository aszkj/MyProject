//
//  WWSideslipViewController.h
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWSideslipViewController : UIViewController{
@private
//    UIViewController * leftControl;
//    UIViewController * mainControl;
//    UIViewController * righControl;    
    
    CGFloat scalef;
}


@property(nonatomic, retain)UIViewController * leftControl;
@property(nonatomic, retain)UIViewController * mainControl;
@property(nonatomic, retain)UIViewController * righControl;

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat speedf;

//是否允许点击视图恢复视图位置。默认为yes
@property (strong) UITapGestureRecognizer *sideslipTapGes;

//恢复位置
-(void)showMainView;

//显示左视图
-(void)showLeftView;

//显示右视图
//-(void)showRighView;

+ (WWSideslipViewController *) instance;

- (void)doSomeThingtoLeft;
- (void)doSomeThingtoRight;


@end
