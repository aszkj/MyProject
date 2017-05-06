//
//  UIControl+ClickEventInterval.h
//  UIControlHelper
//
//  Created by dengxf on 15/11/11.
//  Copyright © 2015年 dengxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (IgnoreEventInterval)


@property (assign , nonatomic) NSTimeInterval acceptEventInterval;

@property (assign, nonatomic) BOOL ignoreEvent;

@end
