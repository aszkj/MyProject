//
//  UITableView+Design.h
//  weimi
//
//  Created by ray on 16/1/21.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Design)

- (void)updateHeightWithoutReload;
- (void)scrollToBottomAnimated:(BOOL)animated;

@end
