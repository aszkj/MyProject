//
//  JGBloodPressureTestProgressView.h
//  CAShapeLayer
//
//  Created by dengxf on 16/2/18.
//  Copyright © 2016年 dengxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGBloodPressureTestProgressView : UIView

@property (assign, nonatomic) CGFloat lowPercent;

@property (assign, nonatomic) CGFloat highPercent;

- (void)setHightData:(CGFloat)hightData lowData:(CGFloat)lowData;

@end
