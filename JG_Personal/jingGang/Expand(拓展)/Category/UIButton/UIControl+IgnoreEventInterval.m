//
//  UIControl+ClickEventInterval.m
//  UIControlHelper
//
//  Created by dengxf on 15/11/11.
//  Copyright © 2015年 dengxf. All rights reserved.
//

#import "UIControl+IgnoreEventInterval.h"
#import <objc/runtime.h>

static const char *kUIControlAcceptEventInterval = "kUIControlAcceptEventInterval";
// ignoreEvent
static const char *kUIControlIgnoreEvent = "kUIControlIgnoreEvent";

@implementation UIControl (IgnoreEventInterval)

+ (void)load {
    Method normal = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method change = class_getInstanceMethod(self, @selector(cus_sendAction:to:forEvent:));
    method_exchangeImplementations(normal, change);
}

- (void)cus_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.ignoreEvent) return;
    if (self.acceptEventInterval > 0)
    {
        self.ignoreEvent = YES;
        [self performSelector:@selector(setIgnoreEvent:) withObject:@(NO) afterDelay:self.acceptEventInterval];
    }
    [self cus_sendAction:action to:target forEvent:event];
}


- (NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self, &kUIControlAcceptEventInterval) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, &kUIControlAcceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ignoreEvent {
    return [objc_getAssociatedObject(self, &kUIControlIgnoreEvent) doubleValue];
}

- (void)setIgnoreEvent:(BOOL)ignoreEvent {
    objc_setAssociatedObject(self, &kUIControlIgnoreEvent, @(ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
