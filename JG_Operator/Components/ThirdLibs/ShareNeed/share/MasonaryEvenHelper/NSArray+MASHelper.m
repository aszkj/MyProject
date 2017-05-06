//
//  NSArray+MASHelper.m
//  CommonLib
//
//  Created by bibibi on 15/7/27.
//  Copyright (c) 2015年 bibibi. All rights reserved.
//

#import "NSArray+MASHelper.h"

@implementation NSArray (MASHelper)

- (void)mas_distributeViewsAlongAxis:(AxisType)axisType withFixedSpacing:(CGFloat)paddingSpace withLeadSpacing:(CGFloat)leadSpacing
{
    if (self.count < 2) {
        return;
    }

    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == AxisTypeHorizon) {
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
              if (prev) {
                  make.left.equalTo(prev.mas_right).offset(paddingSpace);
                  make.width.equalTo(prev);
              }
              else {
                  make.left.equalTo(tempSuperView).offset(leadSpacing);
              }
              if (i == (CGFloat)self.count - 1) {
                  make.right.equalTo(tempSuperView).offset(-leadSpacing);
              }
            }];
            prev = v;
        }
    }
    else {
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    make.top.equalTo(prev.mas_bottom).offset(paddingSpace);
                    make.height.equalTo(prev);
                }
                else {
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                if (i == (CGFloat)self.count - 1) {
                    make.bottom.equalTo(tempSuperView).offset(-leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (void)mas_distributeViewsAlongAxis:(AxisType)axisType withFixedItemLength:(CGFloat)itemLength withLeadSpacing:(CGFloat)leadSpacing
{
    if (self.count < 2) {//一个不需要均匀分布
        return;
    }
    
    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == AxisTypeHorizon) {
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*itemLength;
                    make.width.equalTo(@(itemLength));
                    make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                }
                else {
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                    make.width.equalTo(@(itemLength));
                }
                if (i == (CGFloat)self.count - 1) {
                    make.right.equalTo(tempSuperView).offset(-leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            MAS_VIEW *v = [self objectAtIndex:i];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                if (prev) {
                    CGFloat offset = (1-(i/((CGFloat)self.count-1)))*itemLength;
                    make.height.equalTo(@(itemLength));
                    make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                }
                else {
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                    make.height.equalTo(@(itemLength));
                }
                if (i == (CGFloat)self.count - 1) {
                    make.bottom.equalTo(tempSuperView).offset(-leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (MAS_VIEW *)mas_commonSuperviewOfViews
{
    MAS_VIEW *commonSuperview = nil;
    MAS_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[MAS_VIEW class]]) {
            MAS_VIEW *view = (MAS_VIEW *)object;
            if (previousView) {
                commonSuperview = [view mas_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
