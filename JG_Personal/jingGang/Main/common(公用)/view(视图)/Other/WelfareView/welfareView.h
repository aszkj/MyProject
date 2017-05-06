//
//  welfareView.h
//  QDDictionaryData
//
//  Created by张康健 on 15-08-08.


#import <UIKit/UIKit.h>
/**
 *  给定一个字符串，动态的创建相对应的label
 */

typedef void(^ClickIndexBlock)(NSInteger clickIndex, NSString *clickTitle,BOOL open);

@interface welfareView : UIView

//以字符串的形式给
@property (nonatomic, copy) NSString *welfaresString;

//以数组的形式给
@property (nonatomic, copy) NSArray *titleArr;

//button距离view两边的间距
@property (nonatomic, assign) CGFloat marginLeft;

//button距离view顶部和底部的间距
@property (nonatomic, assign) CGFloat marginTop;

//中间button之间的垂直间距
@property (nonatomic, assign) CGFloat verticalGap;

//中间button之间的垂直间距
@property (nonatomic, assign) CGFloat horizontalGap;

//button中标题的高度
@property (nonatomic, assign) CGFloat titleHeight;

//button中标题距离button顶部和底部的高度
@property (nonatomic, assign) CGFloat buttonTitleToTopEdge;

//button中标题距离button左右的距离
@property (nonatomic, assign) CGFloat buttonTitleToleftRightEdge;

//默认没选中颜色
@property (nonatomic, strong)UIColor *bgcolor;

//button点击选中的颜色
@property (nonatomic, strong)UIColor *selectedColor;

//点击选中的block
@property (nonatomic, copy)ClickIndexBlock clickIndexBlock;



#pragma mark - 可事先计算出高度
-(CGFloat )beginCaculateHeightWithTitleArr:(NSArray *)titleArr;

@property (nonatomic, assign)CGFloat welfheight;

@end
