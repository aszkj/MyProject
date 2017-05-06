//
//  TitleSelectorView.h
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTitleSelectorView : UIView

/**
 *  用来响应button的点击事件
 *
 *  @param index 是表示第几个button
 */
typedef void(^TitlePressBlock)(NSInteger index);

@property (copy     ) TitlePressBlock buttonPressBlock;
@property (nonatomic) UIColor          *titleColor;
@property (nonatomic) UIColor          *selectedColor;

/**
 *  用代码创建标题栏使用这个方法
 *
 *  @param 依次写入希望的标题栏,eg. @"标题一",@"标题二".
 *
 *  @return 自定义的标题栏视图
 */
- (id)initWithTitles:(NSString *)firstTitle, ... NS_REQUIRES_NIL_TERMINATION;
/**
 *  如果用IB创建TitleSelectorView,请在viewDidLoad后使用此方法
 *
 *  @param 依次写入希望的标题栏, eg. @"标题一",@"标题二".
 */
- (void)setSelectorTitles:(NSString *)firstTitle, ... NS_REQUIRES_NIL_TERMINATION;


@end
