//
//  JGDropdownMenu.h
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGShopActiveContentController.h"

typedef NS_ENUM(NSUInteger, ShowDropViewDirectionType) {
    ShowDropViewDirectionFromBottom = 0,  // 从下弹出
    ShowDropViewDirectionFromTop,         // 从上弹出
    ShowDropViewDirectionFromLeft,        // 从左弹出
    ShowDropViewDirectionFromRight        // 从右弹出
};

@class JGDropdownMenu;

@protocol JGDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(JGDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(JGDropdownMenu *)menu;
@end

@interface JGDropdownMenu : UIView

@property (nonatomic, weak) id<JGDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  根据指定的view 显示该view的下方
 */
- (void)showFromView:(UIView *)fromView withDuration:(NSTimeInterval)duration;


- (void)showWithFrameWithDuration:(NSTimeInterval)duration;

/**
 *  视图是以window中心为原点*/
- (void)showWithKeyWindowWithDuration:(NSTimeInterval)duration;

/**
 *  距window中心Y轴距离 */
- (void)showWithKeyWindowWithDuration:(NSTimeInterval)duration CustomYToCenterMargin:(CGFloat)margin;


- (void)showWithFrameWithDuration:(NSTimeInterval)duration FromDirection:(ShowDropViewDirectionType)direction viewHeight:(CGFloat)height;

/**
 *  是否需要蒙版
 */
- (void)configBgShowMengban;

/**
 *  配置是否点击view销毁弹框
 */
- (void)configTouchViewDidDismissController:(BOOL)dismiss;

/**
 *  销毁
 */
- (void)dismiss;

- (void)dismissWithTouchDropdownView:(JGDropdownMenu *)dropdownView;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end

