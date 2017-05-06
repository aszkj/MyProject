//
//  IncomeStatisticstaTableHeadView.h
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/10/30.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IncomeStatisticstaTableHeadViewDelegate <NSObject>
//点击确定按钮代理方法
- (void)NofitiCationConfirmButtonClikStartTimeWith:(NSString *)startTime overTime:(NSString *)overTime;

//点击时段选择按钮
- (void)NofitiCationSelectButtonClick;



@end
@interface IncomeStatisticstaTableHeadView : UIView
@property (nonatomic,assign) id<IncomeStatisticstaTableHeadViewDelegate>delegate;
@property (nonatomic,strong) UILabel *labelSelectLater;       //选择后设置的时间段label

@end
