//
//  SGTopTitleView.h
//  SGTopTitleViewExample
//
//  Created by Sorgle on 16/8/24.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

// 欢迎来GitHub下载最新Demo
// GitHub下载地址：https://github.com/kingsic/SGTopTitleView.git

#import <UIKit/UIKit.h>
@class SGTopTitleView;

@protocol SGTopTitleViewDelegate <NSObject>
// delegate 方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index;

@end

@interface SGTopTitleView : UIScrollView
/** 静止标题数组 */
@property (nonatomic, strong) NSArray *staticTitleArr;
/** 滚动标题数组 */
@property (nonatomic, strong) NSArray *scrollTitleArr;
/** 存入所有Label */
@property (nonatomic, strong) NSMutableArray *allTitleLabel;

#pragma mark - - - 以下属性一定要设置在 -> 标题数组 <- 之后, 否则无效果
/** 文字以及指示器颜色设置(默认为红色)*/
@property (nonatomic, strong) UIColor *titleAndIndicatorColor;
/** 是否隐藏指示器(默认为NO) 指示器的宽度是根据标题内容的宽度变化而变化的, 所以设置这个属性一定要在 -> 标题数组属性之后 */
@property (nonatomic, assign) BOOL isHiddenIndicator;
/** 背景指示器样式(默认指示器在标题文字下方, 设置此属性指示器显示在文字后方) */
@property (nonatomic, assign) BOOL showsTitleBackgroundIndicatorStyle;

@property (nonatomic, weak) id<SGTopTitleViewDelegate> delegate_SG;

/** 类方法 */
+ (instancetype)topTitleViewWithFrame:(CGRect)frame;

- (void)seletedIndex:(NSInteger)index;

#pragma mark - - - 给外界ScrollView提供的方法以及自身方法实现
/** 静止标题选中颜色改变以及指示器位置变化 */
- (void)staticTitleLabelSelecteded:(UILabel *)label;
/** 滚动标题选中颜色改变以及指示器位置变化 */
- (void)scrollTitleLabelSelecteded:(UILabel *)label;
/** 滚动标题选中居中 */
- (void)scrollTitleLabelSelectededCenter:(UILabel *)centerLabel;


@end
