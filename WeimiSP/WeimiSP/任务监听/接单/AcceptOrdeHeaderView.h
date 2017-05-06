//
//  AcceptOrdeHeaderView.h
//  WeimiSP
//
//  Created by 鹏 朱 on 16/2/22.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AcceptOrdeHeaderEntity;

@interface AcceptOrdeHeaderView : UIView

@property (nonatomic) UILabel *time;
@property (nonatomic) UILabel *acceptOrderNum;
@property (nonatomic) UILabel *income;
@property (nonatomic) UILabel *completeOrderNum;
@property (nonatomic) UILabel *completeOrderPercentage;

//设置内容
- (void)setEntity:(AcceptOrdeHeaderEntity *)entity;

@end
