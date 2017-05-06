//
//  MJRefreshHeader+TriggerAutomaticallyRefresh.m
//  weimi
//
//  Created by ray on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "MJRefreshHeader.h"
#import "MJRefreshHeader+TriggerAutomaticallyRefresh.h"

@implementation MJRefreshHeader (TriggerAutomaticallyRefresh)

- (BOOL)needAutomaticallyRefresh {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setNeedAutomaticallyRefresh:(BOOL)needAutomaticallyRefresh {
    objc_setAssociatedObject(self, @selector(needAutomaticallyRefresh), @(needAutomaticallyRefresh), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)triggerAutomaticallyRefreshTop {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setTriggerAutomaticallyRefreshTop:(CGFloat)triggerAutomaticallyRefreshPercent {
    objc_setAssociatedObject(self, @selector(triggerAutomaticallyRefreshPercent), @(triggerAutomaticallyRefreshPercent), OBJC_ASSOCIATION_RETAIN);
}

+ (void)load {
    // All methods that trigger height cache's invalidation
    SEL selectors[] = {
        @selector(scrollViewContentOffsetDidChange:),
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"tl_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)tl_scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [self tl_scrollViewContentOffsetDidChange:change];
    
    if (self.state != MJRefreshStateIdle || !self.needAutomaticallyRefresh || self.mj_y == 0) return;

    if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
        // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
        if (_scrollView.mj_offsetY <= self.triggerAutomaticallyRefreshTop) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y - old.y < 1) return;
            
            // 检查正在用手滑动
            if (!self.scrollView.tracking && (self.scrollView.isDragging || self.scrollView.isDecelerating)) {
                DDLogInfo(@"beginRefreshing newY:%f , oldY:%f",new.y,old.y);
                [self beginRefreshing];
            }
        }
    }
}

@end
