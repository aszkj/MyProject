//
//  XKJHSlideSwitchView.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SUNSlideSwitchViewDelegate;
@interface XKJHSlideSwitchView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_rootScrollView;                  //主视图
    UIScrollView *_topScrollView;                   //顶部页签视图
    
    CGFloat _userContentOffsetX;
    BOOL _isLeftScroll;                             //是否左滑动
    BOOL _isRootScroll;                             //是否主视图滑动
    BOOL _isBuildUI;                                //是否建立了ui
    
    NSInteger _userSelectedChannelID;               //点击按钮选择名字ID
    
    UIImageView *_shadowImageView;
    UIImage *_shadowImage;
    
    UIColor *_tabItemNormalColor;                   //正常时tab文字颜色
    UIColor *_tabItemSelectedColor;                 //选中时tab文字颜色
    UIImage *_tabItemNormalBackgroundImage;         //正常时tab的背景
    UIImage *_tabItemSelectedBackgroundImage;       //选中时tab的背景
    NSMutableArray *_viewArray;                     //主视图的子视图数组
    
    UIButton *_rigthSideButton;                     //右侧按钮
    
    __weak id<SUNSlideSwitchViewDelegate> _slideSwitchViewDelegate;
}

@property (nonatomic, strong) UIScrollView *rootScrollView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, assign) CGFloat userContentOffsetX;
@property (nonatomic, assign) NSInteger userSelectedChannelID;
@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
@property (nonatomic, weak)   id<SUNSlideSwitchViewDelegate> slideSwitchViewDelegate;
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;
@property (nonatomic, strong) NSMutableArray *viewArray;

@property (nonatomic, strong) UIImageView *msgTips;
@property (nonatomic, strong) UILabel *msgNotReadNum;

@property (nonatomic, strong) UIImageView *friendTips;
@property (nonatomic, strong) UILabel *friendNotReadNum;

@property (nonatomic, assign) BOOL displayTip;
/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI;
- (void)setDefauletViewFromIndex:(NSInteger)index;

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */

@end

@protocol SUNSlideSwitchViewDelegate <NSObject>

@required

/*!
 * @method 顶部tab个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result tab个数
 */
- (NSUInteger)numberOfTab:(XKJHSlideSwitchView *)view;

/*!
 * @method 每个tab所属的viewController
 * @abstract
 * @discussion
 * @param tab索引
 * @result viewController
 */
- (UIViewController *)slideSwitchView:(XKJHSlideSwitchView *)view viewOfTab:(NSUInteger)number;

@optional

/*!
 * @method 滑动左边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result 
 */
- (void)slideSwitchView:(XKJHSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 滑动右边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(XKJHSlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 点击tab
 * @abstract
 * @discussion
 * @param tab索引
 * @result 
 */
- (void)slideSwitchView:(XKJHSlideSwitchView *)view didselectTab:(NSUInteger)number;

- (void)slideSwitchViewStartScroll;

@end
