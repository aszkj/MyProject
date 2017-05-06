//
//  JGTouchEdgeInsetsButton.m
//  jingGang
//
//  Created by dengxf on 16/2/19.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGTouchEdgeInsetsButton.h"

@implementation JGTouchEdgeInsetsButton
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (([event type] != UIEventTypeTouches)) {
        return [super pointInside:point withEvent:event];
    }
    CGRect frame = CGRectMake(self.touchEdgeInsets.left,
                              self.touchEdgeInsets.top,
                              self.bounds.size.width - self.touchEdgeInsets.left - self.touchEdgeInsets.right,
                              self.bounds.size.height - self.touchEdgeInsets.top - self.touchEdgeInsets.bottom);
    return CGRectContainsPoint(frame, point);
}

@end
