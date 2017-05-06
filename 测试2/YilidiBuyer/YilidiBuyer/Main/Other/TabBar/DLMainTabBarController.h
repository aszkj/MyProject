//
//  DLMainTabBarController.h
//  YilidiSeller
//
//  Created by User on 16/3/17.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobleConst.h"

@interface DLMainTabBarController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic,assign)NSInteger shopCartBadgeNumber;

/**
 *  从外部设置index
 */
- (void)setTabIndex:(NSInteger)index;

- (void)hiddenBottomView;
- (void)showBottomView;



@end
