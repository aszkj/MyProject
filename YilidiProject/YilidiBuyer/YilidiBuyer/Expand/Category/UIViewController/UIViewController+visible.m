//
//  UIViewController+visible.m
//  YilidiBuyer
//
//  Created by mm on 17/2/22.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "UIViewController+visible.h"

@implementation UIViewController (visible)

- (BOOL)isVisible {
    
    return (self.isViewLoaded && self.view.window);
    
}


@end
