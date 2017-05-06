//
//  JGIntegralHeaderView.h
//  jingGang
//
//  Created by dengxf on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ViewValueType) {
    IntegralViewType = 0,  // 积分类型
    CloudValueViewType     // 云币类型
};


@protocol JGIntegralHeaderViewDelegate <NSObject>

- (void)JGIntegralHeaderViewRuleButtonClick;

@end

@interface JGIntegralHeaderView : UIView

- (instancetype)initWithHeaderViewValue:(NSString *)string;

@property (nonatomic,assign) id<JGIntegralHeaderViewDelegate>delegate;

/**
 *  判断是积分还是云币页面
 */
@property (assign, nonatomic) ViewValueType valueType;

/**
 *  云币、积分数量
 */
@property (nonatomic,copy) NSString *strIntegralCloudValue;


@property (copy , nonatomic) NSString *totleValue;



@end
