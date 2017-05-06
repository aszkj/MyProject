//
//  NSArray+extend.h
//  YilidiSeller
//
//  Created by yld on 16/4/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (extend)

-(NSArray *)transferDicArrToModelArrWithModelClass:(Class)modelClass;

- (void)setArrUisFont:(UIFont *)font;

/**
 增加或减少约束数组中每个约束的数值
 */
- (void)changeUiDetaConstraint:(CGFloat)detaConstraint;

/**
 数组中所有数字位数长度之和加起来是否大于最小的最大长度

 @param minMaxLength 最小的最大长度
 */
- (BOOL)isTotalNumbersBitLengthBiggerThanMinMaxLength:(NSInteger)minMaxLength;
@end
