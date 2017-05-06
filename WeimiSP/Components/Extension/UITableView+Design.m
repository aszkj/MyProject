//
//  UITableView+Design.m
//  weimi
//
//  Created by ray on 16/1/21.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "UITableView+Design.h"

@implementation UITableView (Design)

- (void)updateHeightWithoutReload {
    [self beginUpdates];
    [self endUpdates];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    CGRect visibleRect = CGRectMake(0, fabs(self.contentSize.height-self.bounds.size.height), self.bounds.size.width, self.bounds.size.height);
    [self scrollRectToVisible:visibleRect animated:animated];
    self.hidden = NO;
}

@end
